source('utils.R')
DATA_FILE = 'data.csv'
if (!file.exists(DATA_FILE)){
  write.csv(iris,DATA_FILE, row.names = F)
}
df = read.csv(DATA_FILE)
for (col in colnames(df)){
  df[[col]] = guess_type(df[[col]])
}

#' 获取数据的函数 
get_df <- function (){
  # 修改以下内容，获取需要的数据即可
  df
}


