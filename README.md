<a rel="Inspiration" href="https://github.com/BCDevExchange/docs/blob/master/discussion/projectstates.md"><img alt="An idea being explored and shaped. Open for discussion, but may never go anywhere." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/inspiration.svg" title="An idea being explored and shaped. Open for discussion, but may never go anywhere." /></a>

<!-- README.md is generated from README.Rmd. Please edit that file -->
Warning
=======

The project is under active development and breaking changes will be made.

hydrolook
=========

The hydrolook package has been developed to provide a series semi-automated reports on various facets of the Water Survey of Canada hydrometric network.

Installation
------------

To install the `hydrolook` package, you need to install the devtools package then both the `hydrolook` and `tidyhydat` package

``` r
install.packages("remotes")
remotes::install_github("bcgov/hydrolook")
```

Then to load the package you need to use the library command. When you install hydrolook, several other packages will be installed as well. One of those packages, `dplyr`, is useful for data manipulations and is used regularly here. Even though `dplyr` is installed alongside `hydrolook`, you must still load it explicitly.

``` r
library(hydrolook)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following object is masked from 'package:testthat':
#> 
#>     matches
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

HYDAT download
--------------

To use most of the `hydrolook` package you will need the most recent version of the HYDAT database. The sqlite3 version can be downloaded here:

-   <http://collaboration.cmc.ec.gc.ca/cmc/hydrometrics/www/>

You will need to download that file, unzip it and put it somewhere on local storage. The path to the sqlite3 must be specified within each function that uses HYDAT. Or you can use the `download_hydat()` function from `tidyhydat`.

Example
-------

This is a basic example of `hydrolook` usage. Reports are written in rmarkdown format and are generated using `generate_report()`. For example, if we wanted to generate the Net\_diag report we could use the following command:

``` r
realtime_lag_report(output_type = "pdf", province = "PE")

station_report(output_type = "pdf", STATION_NUMBER = "08MF005")
```

Project Status
--------------

This package is under continual development.

Getting Help or Reporting an Issue
----------------------------------

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/hydrolook/issues/).

How to Contribute
-----------------

If you would like to contribute to the package, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

License
-------

    Copyright 2017 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at 

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
