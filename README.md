# ratan

Ratio analysis mainly to compute and visualize finacial ratios.

## Installation

R dependencies installation:
```R
install.packages(c("devtools"),dependencies=TRUE, repos="http://cran.us.r-project.org")
```

``ratan`` installation:
```R
library("devtools")
devtools::install_github("jaroslav-kuchar/ratan")
```

## Usage

Compute and visualize ratios on Titanic dataset:

```R
library("ratan")
df <- computeRatios(
   as.data.frame(Titanic),
   "Class",
   c("Sex", "Age", "Survived"),
   "Freq")
p <- visualize(df)
htmlwidgets::saveWidget(p, file = "ESIF_2014.html")
p
```

## Use Case

```R
data <- read.csv("https://github.com/openbudgets/datasets/raw/master/ESIF/2014/raw/ESIF_FINANCE_DETAILS.csv")

d <- c("To.short", "Fund")
g <- "MS.Name"
t <- "Total.Amount"

df <- computeRatios(data, g, d, t)
visualize(df)
```

For demonstration purposes we selected a specific dataset that contains financial data for several countries (namely [ESIF 2014](https://github.com/openbudgets/datasets/blob/master/ESIF/2014/raw/ESIF_FINANCE_DETAILS.csv)). The dataset contains observations described by several attributes. This demonstration considers only attributes that define a country name (MS Name), fund (Fund), category (To short) and amounts (Total Amount).
We grouped all observations by the country (e.g. Austria, Belgium, …). For each group (country) we pre-computed all possible combinations of values based on fund and category attributes. Such combinations can be used to compute ratios of amounts.

    Example for Austria:
    The sum of all amounts for Austria is approx.  10,655,136,237.8
    For Fund=EAFRD is the sum of amounts:  7,699,887,667.78
    The ratio of Fund=EAFRD on the total sum is: 0.722646 (the ratio is further labelled as /Fund=EAFRD)
    For Fund=EAFRD we can generate more sub-ratios: 
    The sum of amount for Fund=EAFRD:  7,699,887,667.78
    For category “Climate Change Adaptation & Risk Prevention” within the Fund=EAFRD is the sum of amounts: 2,516,805,874.14
    The ratio of To Short=Climate Change Adaptation & Risk Prevention on Fund=EAFRD for Austria is: 0.326863 (Further labelled as /Fund=EAFRD/To Short=Climate Change Adaptation & Risk Prevention)
    Computed ratios are directly not very useful for detection of uncommon observations. Therefore, we computed the deviation of the ratio from the mean value of the same ratios calculated for other groups (countries).
    Example for Austria:
    The mean value of ratios for Fund=EAFRD on total sum of amounts is 0.29 (ratio for Austria is excluded). 
    The deviation from the mean value is thus approx. 0.44. 
    When compared to other values of the same ratios, this deviation is unusually higher and such observation can be considered as  "outlier".

The deviations of ratios are visualized in [interactive visualization](ESIF_2014.html). Red colour represents “positive outliers“, where ratios are higher than the mean value. Blue colour stands for “negative outliers”, where the ratios are significantly lower than the mean value. Groups (countries) are represented as rows and ratios as columns. 

Examples of results: 
  * Netherlands has significantly higher ratio of EAFRD fund on Educational & Vocational training than the others. The ratio of ESF is significantly lower.  
  * The ratio of EAFRD fund on sum of all is higher for Luxembourg than for the other countries.

## Contributors

- Jaroslav Kuchař (https://github.com/jaroslav-kuchar)

## Licence

Apache License Version 2.0
