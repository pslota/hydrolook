#' @title Check real time lag of realtime stations
#' @export
#'
#' @examples
#' rl_alg <- check_realtime_lag(stations = "ALL")
#'
#' rl_lag %>%
#'  filter(Lag < 10) %>%
#'    mutate(median = median(Lag)) %>%
#'    ggplot(aes(x = Lag)) +
#'    geom_histogram(bins = 100) +
#'    scale_x_continuous(breaks = seq(1,10,0.5)) +
#'    labs(x = "Lag Value (hours)",
#'         y = "Number of Occurences",
#'         title = "Realtime Hydrometric Station Data Lag",
#'         subtitle = "Each station in BC was pinged for the most recent hydrometric observation. The difference between this value and the time when the ping took place is the lag value.",
#'         caption = "Generated by Sam Albers - BC Ministry of Environment")
#'

## There is a bug here. Need to code so that if Lag is greater 20, go back a re-run the loop
## I think while() is what we want here
## Though I think this might have something to do with the hourly versus daily in HYDAT::RealTimeData
check_realtime_lag <- function(stations = "ALL") {

  ## Pull all the stations that are currently realtime
  all_stations = readr::read_csv("http://dd.weather.gc.ca/hydrometric/doc/hydrometric_StationList.csv",
                                 skip = 1, col_types = readr::cols(),
                                 col_names= c("station_number", "STATION_NAME","LATITUDE", "LONGITUDE",
                                              "PROV_TERR_STATE_LOC","TIMEZONE"))

  ## Find the subset that is BC
  bcstations = all_stations[all_stations$PROV_TERR_STATE_LOC == "BC", ]

  ##Which stations should perform the test on?
  if (stations == "ALL") {
    loop_stations = bcstations$station_number
    #loop_stations = c("07EA005","07FD004","10BE001","08LG067","08NN023", "10BE009")
  } else {
    loop_stations = stations
  }

  ## Loop  to find
  df <- c()
  for (i in 1:length(loop_stations)) {
    #cat(paste0("Checking station: ", loop_stations[i], "\n"))

    rtdata = tryCatch(
      HYDAT::RealTimeData(station_number = loop_stations[i], prov_terr_loc = "BC"),
      error = function(e)
        data.frame(Status = e$message)
    )

    ## Is there a status column?
    if (is.null(rtdata$Status) == TRUE) {
        rtdata = dplyr::filter(rtdata, date_time == max(date_time, na.rm = TRUE))
        #stn_time = rtdata$date_time
        rtdata = dplyr::mutate(rtdata, Lag = lubridate::with_tz(Sys.time(), "UTC") - date_time)
        rtdata = dplyr::mutate(rtdata, Lag = as.numeric(Lag))
        #Lag_ind = rtdata$Lag
        cat(paste0(rtdata$Lag, " ",rtdata$station_number, "\n"))
        #stopifnot(Lag_ind < 30)
        rtdata = dplyr::mutate(rtdata, Status = "in datamart")
        rtdata = dplyr::select(rtdata, station_number, Lag, Status)
        u = rtdata

        #dbreturn <- u$Lag
    } else { ## If there is no status column that means there was error - output error
      u = data.frame(
        station_number = loop_stations[i],
        Lag = NA,
        Status = "url not located; check datamart"
      )
      #df = rbind(u, df)
    }
    df = rbind(u, df)

    rm("rtdata")

  }

return(df)
}
