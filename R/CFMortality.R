#' 1- and 2- year Mortality Prediction Models in Cystic Fibrosis (CF)
#' 
#' @param age A number for age
#' @param male A binary variable with 0 for females and 1 for males
#' @param fvc  A number for percentage of FVC in current year
#' @param fev1  A number for percentage of fev11 in current year
#' @param fev1LastYear A number for percentage of fev11 in preceeding year
#' @param bcepacia A binary with 0 for no B. cepacia complex and 1 for B. cepacia complex
#' @param underweight A binary with 0 for not being underweight (BMI<18.5) and 1 otherwise
#' @param nHosp number of hospancreaicInsufficienttalizations in preceding year
#' @param pancreaicInsufficient A binary taking 1 for pancreaic insufficient status and 0 otherwise
#' @param CFRelatedDiabetes A binary variable for CF related diabetes
#' @param ageAtDiagnosis A number for age at CF diagnosis in years
#
#' @return 
#' @examples
#' predictCFMortality (age = 16, male = 0, fvc = 66.7, fev1 = 47.4, fev1LastYear = 80.5, bcepacia = 0, underweight = 0, nHosp = 0, pancreaicInsufficient = 1, CFRelatedDiabetes = 0, ageAtDiagnosis = 0.9)
#' predictCFMortality (age = 40.4, male = 1, fvc = 25.7, fev1 = 19.2, fev1LastYear = 20, bcepacia = 1, underweight = 1, nHosp = 6, pancreaicInsufficient = 0, CFRelatedDiabetes = 0, ageAtDiagnosis = 27.2)
#' @source \url{https://erj.ersjournals.com/content/early/2019/05/08/13993003.00224-2019}
#' @export
predictCFMortality <- function (age, male, fvc, fev1, fev1LastYear, bcepacia, underweight, nHosp, pancreaicInsufficient, CFRelatedDiabetes, ageAtDiagnosis) {

 
  
  #1-year Mortality Prediction Model
  lny1 <-  5.702963 - 0.0162938*(male) + 0.7360137*log(fvc/100) + 0.7899955*log(fev1/100) - 0.7302478*(bcepacia) - 0.4588687*(underweight) - 0.0398486*(age) - 0.2818584*(nHosp)

  lnb1 <- 0.1146547 - 0.0792965*(nHosp) - 0.5616525*(log(fev1LastYear/100) -log(fev1/100)) + 0.2554754*(log(fev1/100)) + 0.6058589*(pancreaicInsufficient) + 0.2340407*(CFRelatedDiabetes) + 0.0079757*(ageAtDiagnosis)

  y1 <- exp(lny1)
  
  b1 <- exp(lnb1)

  lns1 <- (1/((-1)*b1))*(1/y1)^b1*(exp(b1)-1)

  s1 <- round(exp(lns1)*100, digits=2)
  
  #2-year Mortality Prediction Model
  lny2 <-  4.55962 + 0.3189947*(male) + 0.5809873*log(fvc/100) + 0.8404154*log(fev1/100) - 0.4187824*(underweight) - 0.9285728*(bcepacia)

  lnb2 <- 0.1863934 - 0.1263516*(nHosp) + 0.1858131*((log(fev1LastYear/100)) -log(fev1/100)) + 0.4353779*(log(fev1/100)) + 0.1927758*(pancreaicInsufficient) - 0.172767*(CFRelatedDiabetes) + 0.0012487*(ageAtDiagnosis)

  y2 <- exp(lny2)
  
  b2 <- exp(lnb2)

  lns2 <- (1/((-1)*b2))*(1/y2)^b2*(exp(b2)-1)

  s2 <- round(exp(lns2)*100, digits=2)

  os <- round (s1*s2/100, digits = 2)
  
  results <- list() 
  if (s1 >= 80.00){
    
    results$first_year_survival <- s1
    results$second_year_survival <- s2
    results$overall_survival <- os
    return(results)
    
    
  } else {
    
    results$first_year_survival <- s1
    return(results)
    
  }  
}
