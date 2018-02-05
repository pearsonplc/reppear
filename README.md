<!-- README.md is generated from README.Rmd. Please edit that file -->
Overview
--------

`reppear` package belongs to the `pearsonverse` - set of packages which facilitates the data science process in R. The main goal of this package is to support teams via **building a reproducible report with standardised layout**.

Installation
------------

First install `pearsonverse` [package](https://github.com/pearsonplc/pearsonverse). It will install all `*pear` packages.

``` r
devtools::install_github("pearsonplc/pearsonverse")
```

However, if you want to install just `reppear` package:

``` r
devtools::install_github("pearsonplc/reppear")
```

Goals
-----

### Building a reproducible report

`report_create(file, subdir = "reports")` - a function which builds the report skeleton in specific path (defined in `subdir` argument). By default, it is created in `reports` folder. When your `subdir` does not have any file, `report_create` function will create following structure:

``` r
report_create("01_report")
```

    #> reports
    #> ├─01_report
    #> │ ├─01_report.Rmd
    #> │ └─deps
    #> ├─_header.html
    #> ├─_tooltip_content.html
    #> └─index.Rmd

**Report structure**

Let's go thorugh each of the component:

-   `01_report` - a directory which stores a report and all its dependendies.
-   `_header.html` - a file which stores a header for the home page and each report. It attaches data from index.Rmd thus it should never be edited by hand.
-   `_tooltip_content.html` - a file which stores tooltip text used in the report. It attaches data from index.Rmd thus it should never be edited by hand.
-   `index.Rmd` - a file which acts as a home page for all reports within the project. More info about the file structure below.

You can then go to `01_report/01_report.Rmd` and start adding R code to build your report. After that, use `Knit` button to compile it to `01_report.html` file.

Once you have a basic structure like above, every time you use `report_create` function, it will build only one directory with another report. For example:

``` r
report_create("02_report")
```

will only create a `02_report` directory with the same structure as `01_report` (`.Rmd` file and `deps` subdirectory).

**`index.Rmd` file**

`index.Rmd` is a home page for all reports related to our project. It has fixed layout and you can manipulate its content using predefined variables in this file:

``` r
title: # you define your project title.
intro: # introduction to the project. Could be a few sentences.
author_email: # define author emails. Use comma separator to add more than one email.
bitbucket_url: # It should automatically add it if you init git thus it should never 
# be edited by hand.

finding: # list of main findings (once you ready to finalise your project).
  - name: # a crucial sentense about your main finding the report.
    link: # link to the report.
  - name: # another finding summarised the report.
    link: # link to the report.

in_progress: # list of linked reports produced during the project.
  - name: # report title (presented as a button label).
    link: # a link to the report.

appendix: # list of linked reports produces during the project.
  - name: # report title (presented as a button label).
    link: # a link to the report.

thanks: # acknowledgement.
  - name: # colleague name.
    forwhat: # for example, "for helping to understand the data."
```

Data Science Workflow
---------------------

This template was designed with the reader in mind. It aims at communicating the results in the most readable way possible. It should support two appoaches of collaborating with stakeholders:

-   seldom collaboration
-   continuous collaboration

Below, the latter approach was described in terms of using `index.Rmd` file:

1.  At the begging of your project you should build a report template by using `report_create` function.
2.  After you finished a first report, you should define following attributes in `index.Rmd` file:

``` r
title: 
intro: 
author_email: 
in_progress: 
  - name: 
    link: 
```

All reports you produce should be listed in `in_progress` attribute using both `name` and `link` attribute. No other attributes are needed.

1.  Once you ready to finalise your whole project, you should choose the most important insights (and associated reports) and put them in `finding` attribute. The rest reports, which don't include important findings for the final reader should go to the `appendix` attribute. Then, remove `in_progress` attribute. Finally, add `thanks` attribute.

``` r
title: 
intro: 
author_email: 

finding: 
    - name: 
      link: 
    - name: 
      link: 

appendix:
  - name:
    link:

thanks: 
  - name: 
    forwhat: 
```

**Addidional features of `index.Rmd` file**

You can also define tooltip text.For example, by adding this chunk of code in `index.Rmd`,

``` r
tooltip:
- name: mpg
  descr: Miles per Gallon - measure of the vehicle's fuel consumption commonly used in 
        the United States, the United Kingdom, and Canada.
```

Once your tooltip is defined and render it by `render_index()` function (which re/builds `index.html`, `_tooltip_content.html` and `_header.html` files), you can use it in any markdown document any number of times by simply adding a span html element directly into the text like that:

``` r
<span class = "tooltipster tooltip-mpg">MPG</span>
```

The class argument is crucial for the tooltip to be displayed properly.

``` r
'Economy of the car decreases by 5.3 <span class = "tooltipster tootlip-mpg">MPG</span></span>
with each additional ton of car weight (on avg.). However, the decrease ...'
```

![tooltip](https://raw.githubusercontent.com/pearsonplc/reppear/readme/inst/img/tooltip.png)

Few tips on how to write tooltips:
- Try to keep the message short and informative.
- Don’t repeat every tooltip each time given phrase is used. Placing it on the first occurrence of in each paragraph it’s used or sections should be enough.
