rm(list = ls()) #clear environment values

library("hgu95av2.db") #loading package

ls('package:hgu95av2.db') #list package

entrezID<- toTable(hgu95av2ENTREZID)#extract GeneID for probe
symbol<- toTable(hgu95av2SYMBOL)#extract symbol for probe
genename<- toTable(hgu95av2GENENAME)#extract genename for probe

probe<- sample(unique(mappedLkeys(hgu95av2ENTREZID)),60)#extract 60samples randomly

tmp1 = symbol[match(probe,symbol$probe_id),]#match probe to genesymbol
tmp2 = entrezID[match(probe,entrezID$probe_id),]#match probe to geneid
tmp3 = genename[match(probe,genename$probe_id),]#match probe to genename

gene_ID<- tmp2$gene_id     #show the name for frame
gene_symbol<- tmp1$symbol
gene_name<- tmp3$gene_name

write.table(probe,'probe.csv',quote = F,col.names = F,row.names = F,sep="\t")
write.table(tmp1$symbol,'symbol.csv',quote = F,col.names = F,row.names = F,sep = "\t")
write.table(tmp2$gene_id,'gene_ID.csv',quote = F,col.names = F,row.names = F,sep = "\t")
write.table(tmp3$gene_name,'gene_Name.csv',quote = F,col.names = F,row.names = F,sep="\t")


df<- data.frame(probe,gene_ID,gene_symbol,gene_name)#build frame

write.table(df,'IDconvert.xls',quote = F,col.names = T,row.names = F,sep = "\t")

