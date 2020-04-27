
#correct predictions
accuracy <- function(tp,tn,fp,fn) {
  correct <- tn+tp
  all<- tp+fp+tn+fn
  return (correct/all)
}

#correct event predictions
precision <- function(tp,fp) {
  predictions<- tp+fp
  return(tp/predictions)
}

#event predictions against events
recall<- function(tp,fn) {
  events<-tp+fn
  return(tp/events)
}

CMatrixStats<- function(cMatrix) {
    tp = cMatrix['P','P']
    tn = cMatrix['N','N']
    fn = cMatrix['P','N']
    fp = cMatrix['N','P']

    results = matrix(0,nrow=1,ncol=3)
    colnames(results)<- c('Accuracy','Precision','Recall')
    results[1,'Accuracy'] <- accuracy(tp,tn,fn,fp)
    results[1,'Precision'] <- precision(tp,fp)
    results[1,'Recall'] <- recall(tp,fn)
    return(results)
}

generateCMatrix<- function() {
  cMatrix = matrix(0,nrow=2,ncol=2)
  colnames(cMatrix)<- c('P','N')
  rownames(cMatrix)<- c('P','N')
  return (cMatrix)  
}
