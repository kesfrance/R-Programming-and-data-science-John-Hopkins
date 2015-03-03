#!/usr/bin/R
#
# This program was created from the 2nd project in R-programming
#
# by: Francis Kessie
#
# corr.R is a function that takes a directory of data files and a threshold
# for complete cases and calculates the correlation between sulfate and nitrate
# for monitor locations where the number of completely observed cases 
# (on all variables) is greater than the threshold. The function returns a vector 
# of correlations for the monitors that meet the threshold requirement.
# If no monitors meet the threshold requirement, then the function returns
# a numeric vector of length 0.
#


complete <- function(specdata, ids = 1:332){
      directory <- specdata
      id_list <- c()
      complete_dataset <- c()
      for (id in ids) {
            id_list <- c(id_list, id)
            csvFiles <- list.files(pattern="\\.csv")[id]
            file_list <- vector('list', length=length(csvFiles))
            df_list <- lapply(X=csvFiles, read.csv, header=TRUE)
            names(df_list) <- csvFiles
            df <- do.call("rbind", df_list)
            good <- complete.cases(df)
            complete_data <- nrow(df[good, ])
            complete_dataset <- c(complete_dataset, complete_data)
    
       }
  
  dataframes <- data.frame(id = id_list, nobs = c(complete_dataset))
}

corr <- function(specdata, threshold = 0) {
      complete_cases <- complete(specdata)
      highvalues <- complete_cases[ ,2] > threshold
      complete_cases[ ,2][!highvalues] <- NA
      good_higher <- complete.cases(complete_cases)
      complete_higher <- complete_cases[good_higher, ]
      complete_higher_ids <- complete_higher[ , 1]
      my_vector <- vector(mode = "numeric", length = 0)

      for (i in complete_higher_ids) {
            csvFiles2 <- list.files(pattern="\\.csv")[i]
            mydata2 <- read.csv(csvFiles2, header=TRUE, sep=",")
            corlt_2 <- cor(mydata2$sulfate, mydata2$nitrate, use="pairwise.complete.obs")
            my_vector <- c(my_vector, corlt_2)

      

      }

    my_vector

}

