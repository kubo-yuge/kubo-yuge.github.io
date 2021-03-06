# To make html
#    20190408

thisfile <- function(){
  path <- readline("Main Path ")
  if((nchar(path)>0)&&(substring(path,nchar(path))!="/")){
    path=paste(path,"/",sep="")
    setwd(path)
  }
  str <- readline("File(html) ")
  if(nchar(str)>0){
    tmp=grep(".",str,fixed=T)
    if(length(tmp)==0){
      str=paste(str,".html",sep="")
      str=paste(path,str,sep="")
    }
  }else{
    str=""
  }
  cat("File=",str,"\n",sep="")
  str
}

thismaintitle <- function(){
  str <- readline("Main Title ")
  if(nchar(str)==0){
    str="Main Title"
  }
  cat("Main Title=",str,"\n",sep="")
  str
}

thistitle <- function(){
  str <- readline("Title ")
  if(nchar(str)==0){
    str="Title"
  }
  cat("Title=",str,"\n",sep="")
  str
}

thispath <- function(){
  str <- readline("Path ")
  if(nchar(str)>0){
    if(substring(str,nchar(str))!="/"){
      str=paste(str,"/",sep="")
    }
  }
  cat("Path=",str,"\n",sep="")
  str
}

thisimage <- function(){
  str=""
  while(nchar(str)==0){
    str=readline("Image ")
  }
  tmp=strsplit(str,".",fixed=T)
  tmp=tmp[[1]][2]
  name=toupper(tmp)
  cat("Image=",str,"\n",sep="")
  c(str,name)
}

thisitem <- function(){
  str=""
  while(nchar(str)==0){
    str=readline("Item File ")
  }
  tmp=strsplit(str,".",fixed=T)
  tmp=tmp[[1]]
  if(length(tmp)>1){
    name=tmp[2]
  }else{
    name=""
  }
  c(str,name)
}

thispathno <- function(N){
  str="" ; num=N+1;
  while((nchar(str)==0)||(num>N)){
    str=readline("No of Path ")
    num=as.numeric(str)
  }
  num
}

thisimageno <- function(N){
  str="" ; num=N+1;
  while((nchar(str)==0)||(num>N)){
    str=readline("No of Image ")
    num=as.numeric(str)
  }
  num
}

thisitemno <- function(N){
  str="" ; num=N+1;
  while((nchar(str)==0)||(num>N)){
    str=readline("No of Item ")
    tmp=toupper(substring(str,1,1))
    if(tmp=="N"){return("next")}
    if(tmp=="E"){return("end")}
    num=as.numeric(str)
  }
  num
}

wfile=thisfile()
maintitle=thismaintitle()

cat("<html>\n",file=wfile,append=F)
cat("<head>\n",file=wfile,append=T)
cat("<title>",maintitle,"</title>\n",file=wfile,sep="",append=T)
cat("</head>\n",file=wfile,append=T)
cat("<body>\n",file=wfile,append=T)
cat('<p><font size="10">&emsp;',maintitle,'</font>\n',file=wfile,sep='',append=T)
#tmp=system("date", intern=TRUE)
#tmp=gsub(" ","0",substring(tmp,1,11),fixed=T)
#tmp=gsub("�N","/",tmp,fixed=T)
#tmp=gsub("��","/",tmp,fixed=T)
#tmp=gsub("��","",tmp,fixed=T)
#cat('<font size="5">&emsp;&emsp;',tmp,"</font></p>\n",file=wfile,sep="",append=T)
cat("\n",file=wfile,append=T)

cat("Input info/data of each item\n")
cmdL=c()
str=""
while(str!="end"){
  Plist=dir()
  for(J in 1:length(Plist)){
    cat(J,Plist[J],"\n")
  }
  path=Plist[thispathno(length(Plist))]
  Flist=dir(path)
  if(length(Flist)==0){
    cat("There is no item\n")
    next
  }
  for(J in 1:length(Flist)){
    cat(J,Flist[J],"\n")
  }
  title=path
  cmdL=c(paste("<!-- ",title," -->",sep=""))
  cmdL=c(cmdL,'<table border="1" height="30">')
  tmp='    <tr><th colspan="2" align="left"><font size="5">&emsp;'
  tmp=paste(tmp,title,'</font></th></tr>',sep="")
  cmdL=c(cmdL,tmp)
  image=Flist[thisimageno(length(Flist))]
  tmp=strsplit(image,".",fixed=T)
  tmp=tmp[[1]]
  name=toupper(tmp[2])
  tmp='    <tr><td rowspan="20"><a href="'
  tmp=paste(tmp,path,"/",image,'"><img src="',sep="")
#  tmp='    <tr><td rowspan="20"><img src="'
  tmp=paste(tmp,path,"/",image,'" alt=',name,' width="240"></a></td></tr>',sep="")
  cmdL=c(cmdL,tmp)
  head='    <tr><td align="center" width="80"><a href="'
  tail='</a></td></tr>'
  str=""
  while((str!="end")&&(str!="next")){
    str=thisitemno(length(Flist))
    if(is.numeric(str)){
      str=Flist[str]
    }
    tmp=strsplit(str,".",fixed=T)
    tmp=tmp[[1]]
    if(length(tmp)>1){
      name=tmp[2]
    }else{
      name=""
    }
#    str=thisitem()
#    name=str[[2]]
#    str=str[[1]]
    cat("File=",str,",Name=",name,"\n",sep="")
    if(nchar(name)>0){
      tmp=paste(head,path,"/",str,'">',name,tail,sep="")
      cmdL=c(cmdL,tmp)
    }
  }
  tmp=paste('    <tr><td align="center" width="80"></td></tr>',sep="")
  cmdL=c(cmdL,tmp)
  tmp=paste("</table></br>",sep="")
  cmdL=c(cmdL,tmp)
  for(cmd in cmdL){
    cat(cmd,file=wfile,append=T)
    cat('\n',file=wfile,append=T)
  }
  cat("\n",file=wfile,append=T)
  if(str=="next"){str=""}
}
cat("</body>\n",file=wfile,append=T)
cat("</html>\n",file=wfile,append=T)
