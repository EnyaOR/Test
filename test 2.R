
#Regional level differences in average RHU of species
#input regional level RHU values per species, per year

require(tidyr)
require(dplyr)
require(plyr)
require(Rmisc)

#####FOR AVERAGE RHU ACROSS YEARS-PREFERRED APPROACH####

####FIRST, determine total number of years each species is counted in each region####
####for all habitat types####
counts<-read.csv(file.choose(new=F))
counts1<-counts[,c(3:9)]

region<-read.csv(file.choose(new=F))
merge_reg<-merge(counts1,region,by=c("country"))
all_yrs<-merge_reg[merge_reg$year>="1998",]
colnames(all_yrs)[7]<-"species"

West<-all_yrs[all_yrs$region=="West",]
test<-West %>% group_by(EURING) %>%
  summarise_each(funs(n_distinct(.)))

species_tot_year<-test[,c(1,4)]

#####for woodland habitats where there are RHU values available####

regioninput<-read.csv(file.choose(new=F))
wood<-regioninput[regioninput$habitat=="WOODLAND100",]
West<-wood[wood$region=="West",]

West2<-na.omit(West)

####SECOND,####

####determine average RHU across all years RHU values are available in woodland####
sort1<-summarySE(West2,measurevar="RHU",groupvars = c("species","region"))
sort1_fix<-sort1[,c(1,4)]
colnames(sort1_fix)[2]<-"avg_rhu_all_yrs"

####THIRD, determine the number of years where avg RHU is >=1 for woodland####

##determine the avg RHU for years where RHU>1##

West2_rhu_1<-West2[West2$RHU>="1",]
sort_West2_rhu_1<-summarySE(West2_rhu_1,measurevar="RHU",groupvars = c("species","region"))
rhu_1_fix<-sort_West2_rhu_1[,c(1,3)]
colnames(rhu_1_fix)[2]<-"no_yrs_rhu_1"

merge_rhu<-merge(species_tot_year,sort1_fix,by.x ="EURING",by.y="species",all=T)
merge_rhu2<-merge(merge_rhu,rhu_1_fix,by.x="EURING",by.y="species",all=T)
colnames(merge_rhu2)[1]<-"EURING"

list<-read.csv(file.choose(new=F))

result<-merge(list,merge_rhu2,by=c("EURING"))
result2<-na.omit(result)
write.csv(result2,"West result_1998_Woodland_100%.csv",row.names=T)

#FROM HERE WORK IN EXCEL TO GENERATE PROPORTION OF YEARS RHU>1, 25,50,75,100%

