refine <- read.csv("refine_original.csv", stringsAsFactors = FALSE)
library(tidyr)
library(plyr)
library(dplyr)
trimws(refine$company)
for (ref in 1:length(refine$company)) {
  if (grepl("^f+|^p+|^P+", refine[ref, 1]) == TRUE){
    refine[ref, 1] <- "phillips"
  } else if (grepl("^a+|^A+", refine[ref, 1]) == TRUE) {
    refine[ref, 1] <- "akzo"
  } else if (grepl("^u+|^U+", refine[ref, 1]) == TRUE) {
    refine[ref, 1] <- "unilever"
  } else if (grepl("^V+|^v+", refine[ref, 1]) == TRUE) {
    refine[ref, 1] <- "van_houten"
  }
}
refine <- separate(refine, 
           Product.code...number, 
           c("product_code", "product_number"), 
           sep = "-")
refine$product_category <- revalue(refine$product_code, 
          c("p" = "Smartphone", 
            "x" = "Laptop", 
            "v" = "TV", 
            "q" = "Tablet"))
refine <- unite(refine, 
                "address_full", 
                address, city, country, sep = ", ")
companies <- unique(refine$company)
for (d in companies) {
  refine$d <- refine$company == d
  refine <- plyr::rename(refine, c(d = paste("company", d, sep = "_")))
}

products <- unique(refine$product_category)
for (s in products) {
  refine$s <- refine$product_category == s
  refine <- plyr::rename(refine, c(s = paste("product", tolower(s), sep = "_")))
}



