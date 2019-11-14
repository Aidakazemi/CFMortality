[![Build Status](https://travis-ci.org/resplab/CFMortality.svg?branch=master)](https://travis-ci.org/resplab/CFMortality)
[![CRAN Status](https://www.r-pkg.org/badges/version/CFMortality)](https://cran.r-project.org/web/packages/CFMortality/index.html)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

## CFMortality
R package for predicting 1- and 2- year risk of death (with  a threshold risk of death of >= 20% for the 1-year model) in cyctic fibrosis patients based on patients' overal health status described in [https://erj.ersjournals.com/content/54/3/1900224](https://erj.ersjournals.com/content/54/3/1900224).


### Installation
You can install the latest development version from GitHub:

```
install.package("devtools")
devtools::install_github("resplab/CFMortality")
```

### Mortality Prediction

To get a prediction for mortality rate for first and second year , you will need to pass in patient's risk factors. For example: 

```
predictCFMortality (age = 16, male = 0, fvc = 66.7, fev1 = 47.4, fev1LastYear = 80.5, bcepacia = 0, underweight = 0, nHosp = 0, pancreaticInsufficient = 1, CFRelatedDiabetes = 0, ageAtDiagnosis = 0.9)

```

The **predictCFMortality()** function returns 1- year and 2-year mortality rate of patients with cystic fibrosis with 20% cut-off for risk of death of the 1-year model.

### Cloud-based API Access
The [PRISM platform](http://prism.resp.core.ubc.ca) allows users to access CFMortality through the cloud. Fore more info please refer to the [PRISM model repository](http://resp.core.ubc.ca/ipress/prism).

#### R

In R, you can use package [`prism`](https://github.com/resplab/prism) to access the API.

```
library(prism)
connect_to_model('CFMortalityPrism', 123456, "cfmortality.cp.prism-ubc.linaralabs.com/ocpu/library/CFMortalityPrism/R/gateway/json")
input <- get_default_input()
model_run(input)
```

#### Linux

In Ubuntu, you can call the API with `curl`:

```
curl -X POST -H "Content-Type: application/json" -d '{"api_key":["123456"],"func":["prism_model_run"],"model_input":[{"age": 16,"male": 0,"age": 57,"fvc": 66.7,"fev1": 47.4,"fev1LastYear": 80.5,"bcepacia": 0,"underweight": 0,"nHosp": 0,"pancreaticInsufficient": 1,"CFRelatedDiabetes": 0,"ageAtDiagnosis": 0.9}]}' http://cfmortality.cp.prism-ubc.linaralabs.com//ocpu/library/CFMortalityPrism/R/gateway/json
```

#### Windows

In Windows PowerShell, you can use `curl` to access the API:

```
curl -Body '{"api_key":["123456"],"func":["prism_model_run"],"model_input":[{"age": 16,"male": 0,"age": 57,"fvc": 66.7,"fev1": 47.4,"fev1LastYear": 80.5,"bcepacia": 0,"underweight": 0,"nHosp": 0,"pancreaticInsufficient": 1,"CFRelatedDiabetes": 0,"ageAtDiagnosis": 0.9}]}' -Method POST -uri http://cfmortality.cp.prism-ubc.linaralabs.com//ocpu/library/CFMortalityPrism/R/gateway/json -Headers @{"Content-type"="application/json"}
```


### Citation

Please cite: 

```
Stanojevic, Sanja, et al. "Development and external validation of 1-and 2-year mortality prediction models in cystic fibrosis." European Respiratory Journal 54.3 (2019): 1900224.
```
