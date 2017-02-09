library(readxl)
read_excel("Refine.xls")
library(tidyr)
library(plyr)
library(dplyr)
refine <- read_excel("Refine.xls")
trimws(refine$company)
refine <- separate(refine, `Product code / number`, c("product_code", "product_number"), sep = "-")
refine$product_category <- revalue(refine$product_code, c("p" = "Smartphone", "x" = "Laptop", "v" = "TV", "q" = "Tablet"))
refine <- unite(refine, "address_full", address, city, country, sep = ", ")
refine$company <- tolower(refine$company)
refine$company_philips <- refine$company == "philips"
refine$company_akzo <- refine$company == "akzo"
refine$company_van_houten <- refine$company == "van houten"
refine$company_unilever <- refine$company == "unilever"
refine$product_smartphone <- refine$product_category == "Smartphone"
refine$product_laptop <- refine$product_category == "Laptop"
refine$product_tablet <- refine$product_category == "Tablet"
refine$product_tv <- refine$product_category == "TV"
summary(refine)