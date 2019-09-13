require(tidyr)
require(dplyr)
require(plyr)
require(Rmisc)

#### Avg RHU and number years RHU>1 for all habitats by region ####
####WOODLAND####
regioninput<-read.csv(file.choose(new=F))
wood<-regioninput[regioninput$habitat=="WOODLAND",]
West<-wood[wood$region=="West",]

West2<-na.omit(West)

sort1<-summarySE(West2,measurevar="RHU",groupvars = c("species","region"))
sort1_fix<-sort1[,c(1,4)]
colnames(sort1_fix)[2]<-"avg_rhu_wood"

West2_rhu_1<-West2[West2$RHU>="1",]
sort_West2_rhu_1<-summarySE(West2_rhu_1,measurevar="RHU",groupvars = c("species","region"))
rhu_1_fix<-sort_West2_rhu_1[,c(1,3)]
colnames(rhu_1_fix)[2]<-"no_yrs_rhu_1"

merge_rhu<-merge(sort1_fix,rhu_1_fix,by="species",all=T)
colnames(merge_rhu)[1]<-"EURING"

list<-read.csv(file.choose(new=F))

wood_result<-merge(list,merge_rhu,by="EURING")

####URBAN####
urban<-regioninput[regioninput$habitat=="URBAN",]
West<-urban[urban$region=="West",]

West2<-na.omit(West)

sort1<-summarySE(West2,measurevar="RHU",groupvars = c("species","region"))
sort1_fix<-sort1[,c(1,4)]
colnames(sort1_fix)[2]<-"avg_rhu_urban"

West2_rhu_1<-West2[West2$RHU>="1",]
sort_West2_rhu_1<-summarySE(West2_rhu_1,measurevar="RHU",groupvars = c("species","region"))
rhu_1_fix<-sort_West2_rhu_1[,c(1,3)]
colnames(rhu_1_fix)[2]<-"no_yrs_rhu_1"

merge_rhu<-merge(sort1_fix,rhu_1_fix,by="species",all=T)
colnames(merge_rhu)[1]<-"EURING"

urban_result<-merge(list,merge_rhu,by="EURING")

####WETLAND####
wetland<-regioninput[regioninput$habitat=="WETLAND",]
West<-wetland[wetland$region=="West",]

West2<-na.omit(West)

sort1<-summarySE(West2,measurevar="RHU",groupvars = c("species","region"))
sort1_fix<-sort1[,c(1,4)]
colnames(sort1_fix)[2]<-"avg_rhu_wetland"

West2_rhu_1<-West2[West2$RHU>="1",]
sort_West2_rhu_1<-summarySE(West2_rhu_1,measurevar="RHU",groupvars = c("species","region"))
rhu_1_fix<-sort_West2_rhu_1[,c(1,3)]
colnames(rhu_1_fix)[2]<-"no_yrs_rhu_1"

merge_rhu<-merge(sort1_fix,rhu_1_fix,by="species",all=T)
colnames(merge_rhu)[1]<-"EURING"

wetland_result<-merge(list,merge_rhu,by="EURING")

####SEMI-NATURAL####
seminat<-regioninput[regioninput$habitat=="SEMI-NATURAL",]
West<-seminat[seminat$region=="West",]

West2<-na.omit(West)

sort1<-summarySE(West2,measurevar="RHU",groupvars = c("species","region"))
sort1_fix<-sort1[,c(1,4)]
colnames(sort1_fix)[2]<-"avg_rhu_seminat"

West2_rhu_1<-West2[West2$RHU>="1",]
sort_West2_rhu_1<-summarySE(West2_rhu_1,measurevar="RHU",groupvars = c("species","region"))
rhu_1_fix<-sort_West2_rhu_1[,c(1,3)]
colnames(rhu_1_fix)[2]<-"no_yrs_rhu_1"

merge_rhu<-merge(sort1_fix,rhu_1_fix,by="species",all=T)
colnames(merge_rhu)[1]<-"EURING"

seminat_result<-merge(list,merge_rhu,by="EURING")

####FARMLAND####
farm<-regioninput[regioninput$habitat=="FARMLAND",]
West<-farm[farm$region=="West",]

West2<-na.omit(West)

sort1<-summarySE(West2,measurevar="RHU",groupvars = c("species","region"))
sort1_fix<-sort1[,c(1,4)]
colnames(sort1_fix)[2]<-"avg_rhu_farm"

West2_rhu_1<-West2[West2$RHU>="1",]
sort_West2_rhu_1<-summarySE(West2_rhu_1,measurevar="RHU",groupvars = c("species","region"))
rhu_1_fix<-sort_West2_rhu_1[,c(1,3)]
colnames(rhu_1_fix)[2]<-"no_yrs_rhu_1"

merge_rhu<-merge(sort1_fix,rhu_1_fix,by="species",all=T)
colnames(merge_rhu)[1]<-"EURING"

farm_result<-merge(list,merge_rhu,by="EURING")

####MERGE ALL COLUMNS BY EURING####
final1<-merge(wood_result,urban_result,by=c("EURING","species"),all=TRUE)
final2<-merge(final1,wetland_result,by=c("EURING","species"),all=TRUE)
final3<-merge(final2,seminat_result,by=c("EURING","species"),all=TRUE)
final_result<-merge(final3,farm_result,by=c("EURING","species"),all=TRUE)
write.csv(final_result,"West result_1km_ALL HABITATS.csv",row.names=T)
