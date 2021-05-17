#Antes de executar, criar as redes executando o script SNA-01.R

#########################################################################
#Cálculo das Métricas de Centralidade
#Centralidade de grau
deg = degree(net, mode="all")
plot(net, vertex.size=deg*3)

#Histograma com a distribuição de frequência dos graus
hist(deg, breaks=1:vcount(net)-1, main="Histograma de Graus dos Nós")

#Centralidade de intermediação
betweenness(net, directed=T, weights=NA)

#Centralidade de proximidade
closeness(net, mode="all", weights=NA)

#Centralidade de vetor próprio
vp = eigen_centrality(net, directed=T, weights=NA)

#Identificação dos vértices influentes
hs = hub_score(net, weights=NA)$vector
as = authority_score(net, weights=NA)$vector
par(mfrow=c(1,2))
plot(net, vertex.size=hs*50, main="Hubs")
plot(net, vertex.size=as*30, main="Authorities")

#########################################################################
#Cálculo das Métricas relativas à Estrutura do Grafo
#Proporção de arestas com a característica de reciprocidade
dyad_census(net) #Quantidade de arestas mútuas, assimétricas ou nulas
2*dyad_census(net)$mut/ecount(net) #Cálculo de Reciprocidade

#Densidade
edge_density(net, loops=F)
ecount(net)/(vcount(net)*(vcount(net)-1)) #Para grafos direcionados

#Coeficiente de agrupamento é chamado de (Transitividade)
transitivity(net, type="global") #grafo é tratado como não direcionado
transitivity(as.undirected(net, mode="collapse")) #igual ao de cima
transitivity(net, type="local")
triad_census(net) #para grafos direcionados

#Cálculo do diâmetro
diameter(net, directed=F, weights=NA)
get_diameter(net, directed=T)

#Visualização do diâmetro
diam = get_diameter(net, directed=T)
vcol = rep("gray40", vcount(net))
vcol[diam] = "gold"
ecol = rep("gray80", ecount(net))
ecol[E(net, path=diam)] = "orange"
# E(net, path=diam) encontra as arestas ao longo do caminho = ‘diam’
plot(net, vertex.color=vcol, edge.color=ecol, edge.arrow.mode=0)

#########################################################################
#Distâncias e caminhos
#Comprimento médio
mean_distance(net, directed=F)

#Caminhos mais curtos
distances(net)
distances(net, weights=NA) #ignora os pesos das arestas

#Distância para um nó em específico
dist.from.NYT = distances(net, v=V(net)[media=="NY Times"], to=V(net), weights=NA)
# Alterar a cor dos nós, de acordo com a distância
oranges = colorRampPalette(c("dark red", "gold"))
col = oranges(max(dist.from.NYT)+1)
col = col[dist.from.NYT+1]
plot(net,vertex.color=col,vertex.label=dist.from.NYT,
     edge.arrow.size=.6,vertex.label.color="white")

#########################################################################
#Detecção de Comunidades
net.sym = as.undirected(net, mode= "collapse", 
                        edge.attr.comb=list(weight="sum", "ignore"))
ceb = cluster_edge_betweenness(net.sym)
dendPlot(ceb, mode="hclust")
plot(ceb, net)
length(ceb)
membership(ceb) #comunidade a que cada nó pertence

#Detecção de comunidades baseada na otimização da modularidade
cfg = cluster_fast_greedy(as.undirected(net))
plot(cfg, as.undirected(net))

#Decomposição K-Core
kc = coreness(net, mode="all")
colrs = c("gray50", "tomato", "gold")
plot(net, vertex.size=kc*6, vertex.label=kc, vertex.color=colrs[kc])
