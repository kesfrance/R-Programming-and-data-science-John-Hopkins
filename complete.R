#!/usr/bin/R
#
# Another program created from the 2nd project in R-programming
# On Coursera
#
# by: Francis Kessie
#
# complete.R is a function that reads a directory full of files and 
# reports the number of completely observed cases in each data file. 
# The function returns a data frame where the first column is the name 
# of the file and the second column is the number of complete cases.

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
    print(dataframes)

}

complete("specdata", 1)
