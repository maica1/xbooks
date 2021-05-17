#Carregando a Biblioteca igraph
library(igraph)

#########################################################################
#EXEMPLO 1: Importar os arquivos de nós e links
nodes = read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links = read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

#Examinar os dados importados
head(nodes)
head(links)
nrow(nodes); length(unique(nodes$id))
nrow(links); nrow(unique(links[,c("from", "to")]))

#"Limpando" os dados
links = aggregate(links[,3], links[,-3], sum)
links = links[order(links$from, links$to),]
colnames(links)[4] = "weight"

#########################################################################
#EXEMPLO 2: Importar os arquivos de nós e links
nodes2 = read.csv("Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
links2 = read.csv("Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)
head(nodes2)
head(links2)

#########################################################################
#Criando objetos do tipo rede
net = graph_from_data_frame(d=links, vertices=nodes, directed=T)
net
head(net)

net2 = graph_from_incidence_matrix(links2)
net2
