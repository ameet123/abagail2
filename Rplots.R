library(ggplot2)

root_dir<-"C:/Users/AF55267/Documents/personal/ML/homework/hw-2/abagail2/archive/"
setwd(root_dir)
rhc_2<-read.csv("iter-2/RHC_error.csv",header=FALSE)
r_p_2<-ggplot(data=rhc_2, aes(x=Iterations, y=error, group=1)) +
   geom_line(color="red")+
   geom_point()+labs(title="Random Hill Climb: errors[2000 iterations]")
print(r_p_2)
# Plot test time and acc
rhc_tt_acc<- read.csv("iter-1/RHC_acc_testTime.csv",header=FALSE)
colnames(rhc_tt_acc)<-c("sample_num","testing_sec","accuracy")
r_tt_acc<-ggplot(data=rhc_tt_acc, aes(x=sample_num, y=accuracy)) +
  geom_line( )+
  geom_point(color="blue")+labs(title="Random Hill Climb: accuracy")
print(r_tt_acc)
r_tt_testing<-ggplot(data=rhc_tt_acc, aes(x=sample_num, y=testing_sec)) +
  geom_line()+
  geom_point()+labs(title="Random Hill Climb: testing sec.")
print(r_tt_testing)
# SA
sa_error<- read.csv("iter-1/SA_error.csv",header=FALSE)
colnames(sa_error)<-c("iteration","error")
sa_error_g<-ggplot(data=sa_error, aes(x=iteration, y=error)) +
  geom_line( )+
  geom_point( )+labs(title="Simulated Annealing: Error[iterations=2000]")
print(sa_error_g)
# sa acc
sa_acc<- read.csv("iter-1/SA_acc_testTime.csv",header=FALSE)
colnames(sa_acc)<-c("sample_num","testing_sec","accuracy")
sa_acc_g<-ggplot(data=sa_acc, aes(x=sample_num, y=accuracy)) +
  geom_line( )+
  geom_point( )+labs(title="Simulated Annealing: Accuracy [iterations=2000]")
print(sa_acc_g)
sa_test_g<-ggplot(data=sa_acc, aes(x=sample_num, y=testing_sec)) +
  geom_line( )+
  geom_point( )+labs(title="Simulated Annealing: Testing sec. [iterations=2000]")
print(sa_test_g)
# SA-2
sa_error2<- read.csv("iter-2/SA_error.csv",header=FALSE)
colnames(sa_error2)<-c("iteration","error")
sa_error2_g<-ggplot(data=sa_error2, aes(x=iteration, y=error)) +
  geom_line( )+
  geom_point(color="red")+labs(title="Simulated Annealing: Error[iterations=3000]")
print(sa_error2_g)
# GA
ga_error<- read.csv("iter-1/GA_error.csv",header=FALSE)
colnames(ga_error)<-c("iteration","error")
ga_error_g<-ggplot(data=ga_error, aes(x=iteration, y=error)) +
  geom_line( )+
  geom_point( )+labs(title="Genetic Algorithm: Error[iterations=100]")
print(ga_error_g)

ga_acc<- read.csv("iter-1/GA_acc_testTime.csv",header=FALSE)
colnames(ga_acc)<-c("sample_num","testing_sec","accuracy")
ga_acc_g<-ggplot(data=ga_acc, aes(x=sample_num, y=accuracy)) +
  geom_line( )+
  geom_point( )+labs(title="Genetic Algorithm: Accuracy [iterations=100]")
print(ga_acc_g)
ga_test_g<-ggplot(data=ga_acc, aes(x=sample_num, y=testing_sec)) +
  geom_line( )+
  geom_point( )+labs(title="Genetic Algorithm: Testing sec. [iterations=100]")
print(ga_test_g)

# PRoblems 
# Two Color
root_dir<-"C:/Users/AF55267/Documents/personal/ML/homework/hw-2/abagail2/output"
setwd(root_dir)
two_c<-read.csv("comp2C.csv",header=FALSE)
colnames(two_c)<-c("optimizer","elapsed_ms","optimal_count")
two_c$xIndex <- as.numeric(row.names(two_c))
twoc_mean<-aggregate(. ~ optimizer,two_c[-4],mean)

two_c_g<-ggplot(data=two_c, aes(x=xIndex, y=elapsed_ms,
                                group=optimizer,color=optimizer)) +
  geom_line( )+
  geom_point( )+labs(title="Two Color: Elapsed ms.")
print(two_c_g)
# without mimic 
twoc_sans_mimic<- subset(two_c,optimizer!="MIMIC")
twoc_rest_g<-ggplot(data=twoc_sans_mimic, aes(x=xIndex, y=elapsed_ms,
                                group=optimizer,color=optimizer)) +
  geom_line( )+
  geom_point( )+labs(title="Two Color: Elapsed ms.")
print(twoc_rest_g)
two_c_cnt_g<-ggplot(data=two_c, aes(x=xIndex, y=optimal_count,
                                group=optimizer,color=optimizer)) +
  geom_line( )+
  geom_point( )+labs(title="Two Color: Optimal Count")
print(two_c_cnt_g)
# 100 iterations
two_c_1k<-read.csv("comp2C_1000.csv",header=FALSE)
colnames(two_c_1k)<-c("optimizer","elapsed_ms","optimal_count")
two_c_1k$xIndex <- as.numeric(row.names(two_c_1k))
twoc_1k_mean<-aggregate(. ~ optimizer,two_c_1k[-4],mean)

# TSP
# means
tsp<-read.csv("compTSP_.csv",header=FALSE)
colnames(tsp)<-c("optimizer","elapsed_ms","inverse_dist","shortest_distance")
tsp$xIndex <- as.numeric(row.names(tsp))
tsp_mean<-aggregate(. ~ optimizer,tsp[-5],mean)
tsp_g<-ggplot(data=tsp,aes(x=xIndex,y=shortest_distance,group=optimizer,color=optimizer))+
  geom_line()+geom_point() + labs(title="Traveling Salesman: Shortest distance")
print(tsp_g)

# Four peaks
fourp<-read.csv("compFourPeaks.csv",header=FALSE)
colnames(fourp)<-c("optimizer","iteration","elapsed_ms","optima")
fourp$xIndex <- as.numeric(row.names(fourp)) 
aggregate(. ~ optimizer,fourp[-5],max)
fourp_g<-ggplot(data = fourp,aes(x=xIndex,y=optima, group=optimizer,color=optimizer))+
  geom_line()+geom_point()+labs(title="Four Peaks: Optima",x="runs")
print(fourp_g)
#elapsed
fourp_time_g<-ggplot(data = fourp,aes(x=xIndex,y=elapsed_ms, 
                                      group=optimizer,color=optimizer))+
  geom_line()+geom_point()+labs(title="Four Peaks: Elapsed ms.",x="runs")
print(fourp_time_g)
# iterations
#elapsed
fourp_iter_g<-ggplot(data = fourp,aes(x=xIndex,y=iteration, 
                                      group=optimizer,color=optimizer))+
  geom_line()+geom_point()+labs(title="Four Peaks: Iterations",x="runs")
print(fourp_iter_g)
