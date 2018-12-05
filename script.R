setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Bibliotecas necesarias
require(wordcloud)
require(tm)
require(SnowballC)

# Importar tuits
texto <- read.table('tuits.txt',
                   header = FALSE,
                   stringsAsFactors = FALSE,
                   sep = '\n')

# Eliminar URLs
texto <- as.data.frame(sapply(texto, function(x){
  gsub('(https?|ftp)://.[.a-zA-Z0-9/?=\\-&_]+', '', x, perl = TRUE)
}), stringsAsFactors = FALSE)

# Eliminar hashtags y menciones
texto <- as.data.frame(sapply(texto, function(x){
  gsub('(#|@)[a-zA-Z\u0400-\u04FF0-9_]+', '', x, perl = TRUE)
}), stringsAsFactors = FALSE)

# Eliminar duplicados
texto_unificado <- unique(texto)

# Creacion del corpus
textmining <- tm::Corpus(VectorSource(texto_unificado[,1]))

# Transformaciones
textmining <- tm::tm_map(textmining, tm::content_transformer(tolower))
textmining <- tm::tm_map(textmining, tm::removePunctuation)
textmining <- tm::tm_map(textmining, tm::removeNumbers)

# Lematizador
textmining <- tm::tm_map(textmining, tm::removeWords, stopwords('russian'))
textmining <- tm::tm_map(textmining, tm::stemDocument, language='russian')

# Nube de etiquetas
png('tag_cloud.png', units="in", width=4, height=4, res=500)
wordcloud::wordcloud(textmining, max.words=100, rot.per=0, random.order=FALSE, scale=c(3,0.2) ,col=brewer.pal(4,'RdYlBu')[4:1])
dev.off()



