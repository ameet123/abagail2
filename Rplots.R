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
