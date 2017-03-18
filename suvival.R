library(pROC)
##数据使用pROC包自带数据库
data(aSAH)
KKK=c((rnorm(nrow(aSAH),mean = 30,sd=10)))
aSAH<-data.frame(aSAH,KKK)
library(ggplot2)
aSASH1<-aSAH[order(aSAH[,8]),]
c<-c(1:113)
aSASH1<-data.frame(aSASH1,c)

brk=c(-20,-15,-10,-5,0,10,20,25)
dat <- data.frame(
  x = aSASH1$c,
  #注意，在处理实际数据时，需要将放在x轴下方的条形图的数据取反变为负数
  y = aSASH1$KKK-30)
dat$d=aSASH1$KKK-30
dat$pos = (dat$d) >= 0
g=(ggplot(dat,type="h", aes(x=x, y=d, fill=pos),xName="",yName="riskratio")  
   +geom_bar(stat="identity", position="identity",colour = "black", size = 0.1)
   +scale_y_continuous(breaks=brk,labels = brk+30)
   + scale_fill_discrete(name="risk ratio",
                         breaks=c("FALSE","TRUE"),
                         labels=c("lowrisk","highrisk"))
   +geom_vline(aes(xintercept=48.5), colour="#BB0000", linetype="dashed")
   +scale_x_continuous(breaks = NULL,labels= NULL)
   +labs(x = "", y = "riskratio")
   +theme_bw()
   +theme(plot.margin=unit(x=c(0,0,0,0),units="mm"),
          panel.grid =element_blank(),
          panel.border = element_blank(),
          axis.line.y = element_line(colour = "black",size=1),
          legend.position = "right"
          ##legend.direction="horizontal"
   )
)
g

aSASH1$time<-c((rnorm(nrow(aSAH),mean = 50,sd=20)))
time=data.frame(
  pos=dat$pos,
  x=aSASH1$c,
  y=aSASH1$time
)
P=(ggplot(time,aes(x=x, y=y,colour=pos,shape=pos)) + geom_point()
   +labs(x = "patient",y = "survivaltime")
   +geom_vline(aes(xintercept=48.5),colour="#BB0000",linetype="dashed")
   +scale_x_continuous(breaks = NULL,labels= NULL)
   
   +theme_bw() 
   +theme(plot.margin=unit(x=c(0,0,0,0),units="mm"),
          panel.grid =element_blank(),
          panel.border = element_blank(),
          axis.line.y = element_line(colour = "black",size=1),
          axis.line.x = element_line(colour = "NA"),
          axis.ticks.x = element_blank())
)
P
#####ggplot2画热图
genedata<-matrix(rnorm(1000,mean=15,sd=7),nrow = 6,ncol = 113,byrow = F)
rownames(genedata)<-rownames(genedata,do.NULL = FALSE,prefix = "gene")
colnames(genedata)<-aSASH1$c
require(reshape2)
heatmap<-melt(genedata)
d=(ggplot(heatmap, aes(Var2,Var1))
   + geom_tile(aes(fill = value), colour = "white") 
   + scale_fill_gradient(low = "white",  high = "steelblue")
   + scale_x_continuous(labels=NULL,breaks=1:length(aSASH1$c))
   + labs(x = "",y = "")
   
   +geom_vline(aes(xintercept=48.5),colour="#BB0000",linetype="dashed")
   +theme_bw() 
   +theme(plot.margin=unit(x=c(0,0,0,0),units="mm"),
          panel.grid =element_blank(),
          panel.border = element_blank(),
          axis.line.y = element_line(colour = "black",size=1),
          axis.line.x = element_line(colour = "NA"),
          axis.ticks.x = element_blank() )
)
d
#多个图进行拼合###
library(ggbio)
tracks(g,P,d)