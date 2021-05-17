#Antes de executar, criar as redes executando o script SNA-01.R

#Acessando atributos dos nós e links
E(net)       #Os links (Edges) do objeto “net”
V(net)       #Os nós (Vertices) do objeto “net”
E(net)$type  #O atibuto "type" dos links
V(net)$media #O atributo "media" dos nós

#Visualização da Rede - Exemplo 1
plot(net, edge.arrow.size=.4,vertex.label=NA)

#Atributos do grafo bipartido
table(V(net2)$type)

#Projeções do grafo bipartido
net2.bp = bipartite.projection(net2)
plot(net2.bp$proj1, vertex.label.color="black", vertex.label.dist=1, 
     vertex.size=7, vertex.label=nodes2$media[!is.na(nodes2$media.type)])
plot(net2.bp$proj2, vertex.label.color="black", vertex.label.dist=1, 
     vertex.size=7, vertex.label=nodes2$media[is.na(nodes2$media.type)])

#Atributos de visualização da rede
#grafo com arestas curvas (edge.curved=.1) e tamanho reduzido da seta:
plot(net, edge.arrow.size=.4, edge.curved=.1)

# Altera a cor do vértice para verde
# Troca o rótulo do vértice pelos nomes armazenados no atributo "media"
plot(net, edge.arrow.size=.2, edge.curved=0,vertex.color="green", 
     vertex.frame.color="#555555",vertex.label=V(net)$media, 
     vertex.label.color="black",vertex.label.cex=.7)

#########################################################################
#Definindo atributos é adicionando ao próprio objeto iGraph.
# Criar o vetor de cores que será usado para cada tipo de mídia:
colrs = c("gray50", "tomato", "gold")
V(net)$color = colrs[V(net)$media.type]
# Alterar o tamanho do nó de acordo com o tamanho da audiência:
V(net)$size = V(net)$audience.size*0.7
# Atualmente, o rótulo dos nós são os seus IDs. Alterar para NA faz com que eles não sejam renderizados
V(net)$label.color = "black"
V(net)$label = NA
# Alterar o tamanho do nó com base no seu peso
E(net)$width = E(net)$weight/6
# Alterar o tamanho da seta e a cor das arestas
E(net)$arrow.size = .2
E(net)$edge.color = "gray80"
E(net)$width = 1+E(net)$weight/12
# É possível ainda alterar o layout do grafo
graph_attr(net, "layout") = layout_with_lgl
plot(net)
