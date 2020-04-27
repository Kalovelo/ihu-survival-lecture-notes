
closestNeighbor<- function(TRRow,data,TS) {
  cn<- NA
  cd<- 100 #High value, will be replaced on 1st loop.
  for (i in 1:length(TS[,1])){ 
    distance<- euklidian(unlist(TRRow),unlist(TS[i,]))
    if(distance<cd){
      cd<-distance
      cn<-TS[i,]
    }
  }
  return (cn)
}

fillCMatrix<- function(TS,TR,data,cMatrix) {
  for (i in 1:length(f1TS[,1]))
  {
    cMatrix= predict(TS[i,],closestNeighbor(TS[i,],data,TR),cMatrix)
  }
  return (cMatrix)
}

predict<- function(p,neighbor,cMatrix) {
  pC = unlist(p['c'])
  neighborC = unlist(neighbor['c'])

  if(pC == neighborC && pC == 1){
    cMatrix['P','P']=cMatrix['P','P']+1
  }
  else if(pC == 1 && neighborC == 0){
    cMatrix['P','N']=cMatrix['P','N']+1
  }
  else if(pC == 0 && neighborC == 1){
    cMatrix['N','P']=cMatrix['N','P']+1
  }
  else{
    cMatrix['N','N']=cMatrix['N','N']+1
  }
  return(cMatrix)
}