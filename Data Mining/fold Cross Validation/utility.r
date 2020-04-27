
alphabetRowNaming<- function(start,end,df) {
  #set row alphabet names
  intA = utf8ToInt(start)
  intL = utf8ToInt(end)
  listAL = strsplit(intToUtf8(c(intA:intL)),"")
  listAL = unlist(listAL)
  rownames(df)<- (listAL)
  return(df)
}


euklidian <- function(p1,p2) {
  x1 <- (p1['x']-p2['x'])^2
  x2 <- (p1['y']-p2['y'])^2
  sqrt(sum(x1,x2))
}