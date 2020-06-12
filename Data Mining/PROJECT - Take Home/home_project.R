## Young Kalovelul
rm(list=ls())
library("datasets")
library("readxl")
library(ggplot2)

#STEP 1

#read data
my_data <- read_excel("odep_data.xlsx")
summary(my_data)

#STEP 2
C4_S1_2018 <- subset(my_data,my_data$course %in% 'C4' & my_data$exam %in% 'S1' & my_data$year %in% '2018')
grades<-C4_S1_2018$grade
summary(grades)

#STEP 3
gradeTitles<- c('Medium','Good','Very Good','Excellent')

#values between 5...10 / total grade titles
diaspora = 5/4

#init
gradeTitleCol = c()

C4_S1_2018_Passed<-subset(C4_S1_2018,C4_S1_2018$grade>=5)

for (grade in grades) {
  gradeIndex = as.integer((grade-5)/diaspora)+1
  
  if (gradeIndex<0) gradeIndex=0
  
  else if (gradeIndex>4) gradeIndex=4
  
  #append gradeTitle
  gradeTitleCol<-c(gradeTitleCol,gradeTitles[gradeIndex])
}

#merge data with new colun
C4_S1_2018_Passed<-cbind(C4_S1_2018_Passed,gradeTitleCol)

#rename new column
colnames(C4_S1_2018_Passed)[6]<- c('rating')

#Percentage Information
proportions <- table(C4_S1_2018_Passed$rating)/length(C4_S1_2018_Passed$rating)
percentages <- proportions*100
percentages

#STEP 4
S1_2018 <- subset(my_data,my_data$exam %in% 'S1' & my_data$year %in% '2018')
S1_grades<-S1_2018$grade
gradeTitlesNew<- c('Failed','Medium','Good','Very Good','Excellent')
gradeTitleCol = c()
for (grade in S1_grades) {
  if(grade<5){
    gradeTitleCol<-c(gradeTitleCol,'Failed')
  }
  else{
    gradeIndex = as.integer((grade-5)/diaspora)+1
    
    if (gradeIndex<0)gradeIndex=0
    
    else if (gradeIndex>4)gradeIndex=4
    
    #append grade Title
    gradeTitleCol<-c(gradeTitleCol,gradeTitles[gradeIndex])
  }
}

#merge data with new column
S1_2018<-cbind(S1_2018,gradeTitleCol)

#column rename
colnames(S1_2018)[6]<- c('rating')
S1_2018

#Edgy filters
S1_2018_Failed <- subset(S1_2018,S1_2018$'rating' %in% 'Failed')
S1_2018_Excellent <- subset(S1_2018,S1_2018$'rating' %in% 'Excellent')

#Top values
course_most_failed<-tail(names(sort(table(S1_2018_Failed$course))), 1)
course_most_Excellent<-tail(names(sort(table(S1_2018_Excellent$course))), 1)

#show
course_most_failed
course_most_Excellent

#STEP 5

# library
S1_2018_passed<-subset(S1_2018,S1_2018$grade>=5)

plot_Data <- S1_2018_passed[c("course","rating")]

#Ratings are levels
condition <- factor(S1_2018_passed$rating,levels=gradeTitles)

#stacked bar plot
ggplot(plot_Data, aes(fill=condition, x=S1_2018_passed$course)) + 
  geom_bar(stat="count")+xlab("course")

#pie plot
ggplot(plot_Data,aes(fill=condition, x=S1_2018_passed$course)) + geom_bar(position="fill") + coord_polar("y",start=0) + xlab('course')+ylab('proportions')

#STEP 6
#read data
rm(list=ls())
library("datasets")
library("readxl")
library(ggplot2)

Data <- read_excel("odep_data.xlsx")
Data_passed <- subset(Data,Data$grade>=5)
Data_passed_slim <-Data_passed[c("student","course","grade")]
d_grade_values<-c('Medium','Good','Very Good','Excellent')

#values between 5...10 / total grade titles
diaspora = 5/4

#init
gradeTitleCol = c()

for (grade in Data_passed_slim$grade) {
  gradeIndex = as.integer((grade-5)/diaspora)+1
  
  if (gradeIndex<0) gradeIndex=0
  
  else if (gradeIndex>4) gradeIndex=4
  
  #append gradeTitle
  gradeTitleCol<-c(gradeTitleCol,d_grade_values[gradeIndex])
}

#generate factor
d_grade<-factor(gradeTitleCol,order=TRUE,d_grade_values)

#merge
united_data_passed<- cbind(Data_passed["student"],paste(Data_passed$course,"-",gradeTitleCol))

#rename merged column
colnames(united_data_passed)[2]<-c("has")

#generate file
write.csv(united_data_passed,"united_data_passed.csv")

#STEP 7
library("arules")

my_transactions <- read.transactions(
  file = "united_data_passed.csv",
  sep = ",",
  format="single",
  cols=c("student","has"),
  header=TRUE
)

#STEP 8

#total students
nrow(my_transactions)

#get frequency of course count
frequency<-summary(my_transactions)@lengths
frequency<-as.data.frame(frequency)

#plot it out
ggplot(data=frequency, aes(x=sizes, y=Freq)) +
  geom_bar(stat="identity")

#STEP 9
#course frequency
item_freq<-itemFrequency(my_transactions,type="relative")

#top 5
top_5_freq<-head(sort(item_freq, decreasing = TRUE), n = 5)

#as df
freq_df<-as.data.frame(top_5_freq)

#check it out as a table
View(freq_df)

#set the course names as the x axis
x_axis<-rownames(freq_df)

#sort x axis
x_axis<-reorder(x_axis, -top_5_freq)

#plot it out
ggplot(freq_df,aes(x=x_axis,y=top_5_freq))+geom_bar(stat = 'identity')

#STEP 10

#apriori macaroni
rules <- apriori(my_transactions, parameter=list(supp=0.05, conf=.63, minlen=2, 
                                           target='rules'))
#sort it out
rules<-sort(rules,decreasing = TRUE,by="lift")

#check it out
inspect(head(rules,10))

#STEP 11

redundant_rules <- is.redundant(rules)
nr_rules <- rules[!redundant_rules]


#STEP 12
View(nr_rules)
#rules are already sorted by lift,therefore we get a 10piece chunk and we're good to go
inspect(head(nr_rules,n=10))

rules_G_VG_C10 <- subset(rules,lhs %in% c('C10 - Good','C10 - Very Good'))

#Wish Grep worked properly
nrrules_Exc <- subset(nr_rules,lhs %pin%  'Excellent' | rhs %pin%  'Excellent')

#Check our execellent redundant bois
inspect(nrrules_Exc)

#STEP 13
#Σε αντίθεση με το Lift, δεν ισχύει η συμμετρική ιδιότητα συνεπώς
#η αγορά ενός αγαθού Χ μπορεί να τείνει στην αγορά του Υ,
#αλλά δεν σημαίνει απαραίτητα πως η αγορά του Υ τείνει στην αγορά του Χ.

#STEP 14 - [HALT!] not sure if rest courses should be considered.

#No time for efficient code right now
juicy_rules<- subset(nr_rules,
  (
    (lhs %in%  'C4 - Very Good' | lhs %in%  'C4 - Excellent') 
    | (lhs %in%  'C6 - Very Good' | lhs %in%  'C6 - Excellent')
  )
  & (rhs %pin%  'Very Good' | rhs %pin%  'Excellent'))

inspect(juicy_rules)

#Add Conviction Column and filter out redundant dudes
juice<-cbind(as(juicy_rules, "data.frame"), conviction=interestMeasure(juicy_rules, "conviction",trans))

#sort it out by conviction
juice_conv_ordered<-juice[order(juice$conviction,decreasing = TRUE),]
View(juice_conv_ordered)
