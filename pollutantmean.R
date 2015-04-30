#!/usr/bin/R
#
# A program created from the first project in R-programming on coursera
#
# by: Francis Kessie
#
#
# pollutantmean.R calculates the mean of a pollutant (sulfate or nitrate) 
# across a specified list of monitors. Given a vector monitor ID numbers, the 
# function computes the mean of the pollutant across all of the monitors, 
# ignoring any missing values coded as NA.


pollutantmean <- function(specdata, pollutant, id = 1:332){
          directory <- specdata
          csvFiles <- list.files(pattern="\\.csv")[id]
          file_list <- vector('list', length=length(csvFiles))
          df_list <- lapply(X=csvFiles, read.csv, header=TRUE)
          names(df_list) <- csvFiles
          df <- do.call("rbind", df_list)
          all_pollutant <- (df[ , pollutant])
          bad <- is.na(all_pollutant)
          positive_pollutant <- all_pollutant[!bad]
          mean(positive_pollutant)
          
  
}

#pollutantmean("specdata", "nitrate")
