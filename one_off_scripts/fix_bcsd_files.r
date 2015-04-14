library(ncdf4)
library(ncdf4.helpers)
library(RPostgreSQL)
library(PCICt)
library(digest)
library(rgdal)
library(snow)

fix.bcsd.files <- function(file.list, host="monsoon.pcic", db="pcic_meta", user="pcic_meta", password=NULL) {
  drv <- dbDriver("PostgreSQL")
  con <- NULL
  if(is.null(password))
    con <- dbConnect(drv, host=host, dbname=db, user=user)
  else
    con <- dbConnect(drv, host=host, dbname=db, user=user, password=password)

  query <- "select filename,first_1mib_md5sum from data_files"
  result <- dbSendQuery(con, query)
  dat <- fetch(result, -1)

  matches <- grepl("BCSD", dat$filename)
  existence <- file.exists(dat$filename)

  browser()
  
  dbDisconnect(con)

}
  
