library(RMySQL)
library(tidyr)
mydb = dbConnect(MySQL(), user="root", password="admin", dbname="reddit", host="127.0.0.1")
for (i in 1:length(table1$country)) {
  sql = sprintf("insert into Table1 (country, year, cases, population) 
                values ('%s', %d, %d, %d)", 
                table1$country[i], table1$year[i], table1$cases[i], table1$population[i])
  rs = dbSendQuery(mydb, sql)
}
dbClearResult(rs)
dbDisconnect(mydb)