#' Compute Ratios
#'
#' @param data \code{data.frame} with input data
#' @param groupBy grouping entries by specific column name
#' @param dimensions vector with column names used for computing ratios
#' @param target column name with target numeric values to compute rarios
#' @param distanceFromMean boolean to compute only ratios or also distance from mean value in column
#' @return data frame with ratios
#' @import data.table
#' @export
#' @examples
#' library("ratan")
#' r <- computeRatios(
#'     as.data.frame(Titanic),
#'     "Class",
#'     c("Sex", "Age", "Survived"),
#'     "Freq")
computeRatios <- function(data, groupBy, dimensions, target, distanceFromMean = TRUE) {
  # join all column names for data frame view
  selectedColumns <- c(groupBy, dimensions, target)
  # generate view on data
  data <- data[,selectedColumns]
  # get names of groups
  groups <- unique(data[,groupBy])

  # initialize rows
  rows <- list()
  # iterate over group
  for(group in sort(groups)){
    # get data for specific group
    groupData <- data[which(data[,groupBy]==group),]
    # compute ratios for all combinations of selected dimensios
    row <- .computeRatios(dimensions, groupData, target)
    rows[[length(rows)+1]] <- row
  }
  # convert to a data frame
  df <- rbindlist(rows, fill=TRUE)
  df <- as.data.frame(df)
  rownames(df) <- sort(groups)
  # remove NAs
  df[is.na(df)] <- 0
  # sort alphabetically according to the names of rows and columns
  df <- df[order(row.names(df), decreasing = TRUE),]
  df <- df[,order(colnames(df), decreasing = FALSE)]

  # compute distance from mean value in column
  if(distanceFromMean){
    means <- apply(df, 2, mean)
    for(a in colnames(df)){
      df[,a] <- df[,a] - means[a]
    }
  }
  df
}

.computeRatios <- function(dims, data, target, prev=""){
  # initialize output
  out <- list()
  # total sum of current view
  totalSum <- sum(data[,target])
  for(d in dims){
    for(v in unique(data[,d])){
      ps <- sum(data[which(data[,d]==v), target])
      name <- paste(prev,"/",d,"=",v,sep = "")
      out[[name]] <- ps/totalSum
      out <- c(out,.computeRatios(setdiff(dims,d), data[which(data[,d]==v),], target, name))
    }
  }
  out
}
