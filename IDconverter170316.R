rm(list = ls())

library("hgu95av2.db")
probe2entrezID<- toTable(hgu95av2ENTREZID)
probe2symbol<- toTable(hgu95av2SYMBOL)
probe2genename<- toTable(hgu95av2GENENAME)

my_probe<- sample(unique(mappedLkeys(hgu95av2ENTREZID)),30)

tmp1 = probe2symbol[match(my_probe,probe2symbol$probe_id),]
tmp2 = probe2entrezID[match(my_probe,probe2entrezID$probe_id),]
tmp3 = probe2genename[match(my_probe,probe2genename$probe_id),]

write.table(my_probe,'my_probe.txt',quote = F,col.names = F,row.names = F)
write.table(tmp1$symbol,'my_symbol.txt',quote = F,col.names = F,row.names = F)
write.table(tmp2$gene_id,'my_geneID.txt',quote = F,col.names = F,row.names = F)
write.table(tmp3$gene_name,'my_geneName.txt',quote = F,col.names = F,row.names = F)


