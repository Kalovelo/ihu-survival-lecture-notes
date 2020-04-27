source("inforetrieval.r")
source("neighboorFuncs.r")
source("utility.r")

#if (c)olor is 1, then we consider it as a false event.
#if (c)olor is 0, then we consider it as a true event.

data <- matrix(list(),nrow=12,ncol=3)
colnames(data)<- c('x','y','c')
data[1,]<- list('x'=1,'y'=1,'c'=1) 
data[2,]<- list('x'=4,'y'=1,'c'=1) 
data[3,]<- list('x'=9,'y'=1,'c'=0) 
data[4,]<- list('x'=3,'y'=5,'c'=0) 
data[5,]<- list('x'=6,'y'=5,'c'=1) 
data[6,]<- list('x'=1,'y'=6,'c'=0) 
data[7,]<- list('x'=2,'y'=6,'c'=0) 
data[8,]<- list('x'=5,'y'=6,'c'=0) 
data[9,]<- list('x'=8,'y'=6,'c'=1) 
data[10,]<- list('x'=1,'y'=8,'c'=1)
data[11,]<- list('x'=3,'y'=9,'c'=0)
data[12,]<- list('x'=9,'y'=2,'c'=0)

data<- alphabetRowNaming('A','L',data)

f1TR <- data[1:8,]
f1TS <- data[9:12,]

f2TR <- data[cbind(c(1:4),c(9:12)),]
f2TS <- data[5:8,]

f3TR <- data[5:12,]
f3TS <- data[1:4,]


cMatrix1 <- generateCMatrix()
cMatrix2 <- generateCMatrix()
cMatrix3 <- generateCMatrix()

cMatrix1<- fillCMatrix(f1TS,f1TR,data,cMatrix1)
cMatrix2<- fillCMatrix(f2TS,f2TR,data,cMatrix2)
cMatrix3<- fillCMatrix(f3TS,f3TR,data,cMatrix3)

print('fold 1')
print(cMatrix1)
print(CMatrixStats(cMatrix1))
print('fold 2')
print(cMatrix2)
print(CMatrixStats(cMatrix2))
print('fold 3')
print(cMatrix3)
print(CMatrixStats(cMatrix3))
