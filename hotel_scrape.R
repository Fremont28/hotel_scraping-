#scrape hotel prices and locations from Booking.com 

jump<-seq(0,450,by=15)
site<-paste0('https://www.booking.com/searchresults.html?label=gen173nr-1FCAEoggJCAlhYSDNYBGgsiAEBmAExuAEHyAEM2AEB6AEB-AECkgIBeagCAw&sid=3758ab4bd122c4a08f5f71bd4644af1d&city=-390625&class_interval=1&dest_id=-390625&dest_type=city&dtdisc=0&from_idr=1&ilp=1&inac=0&index_postcard=0&label_click=undef&postcard=0&room1=A%2CA&sb_price_type=total&ss_all=0&ssb=empty&sshis=0&rows=15&offset=',
             jump,sep="")
df_list2<-lapply(site,function(i){
  page<-read_html(i)
  metrics<-html_nodes(page,'.price') %>% html_text() %>%
    gsub("^\\s+|\\s+$", "", .) 
})

df_list2 
df_final1<-do.call(rbind,df_list2)
df_final2<-as.data.frame(df_final1)

#remove patterns from dataframe (hotel prices) 
dollar_remove=substr(df_final2$V2,start=4,stop=9)
#apply to each column (remove dollar sign pattern from each column) 
x1=sapply(df_final2,function(x) substr(x,start=4,stop=9))
#change dimensions of the dataset
x2=as.data.frame(matrix(t(x1),ncol=1))
x2$V1<-as.numeric(x2$V1)
