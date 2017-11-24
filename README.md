<!-- README.md is generated from README.Rmd. Please edit that file -->
Overview
--------

Desrciption of `reppear` package.

Installation
------------

First install `pearsonverse` [package](https://bitbucket.pearson.com/projects/EF/repos/pearsonverse/browse). During attaching `pearsonverse`, it installs all `*pear` packages.

``` r
library(pearsonverse)
```

However, if you want install just `reppear` package:

``` r
##### CHANGE THIS LINE START #####
bibucket_login <- "example" 
##### CHANGE THIS LINE END #######

pearsonverse::install_pkgpear("reppear", bibucket_login)  
```
