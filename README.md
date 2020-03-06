在web端简单的拖选，对数据进行过滤和分析。

- `data.R`: 初始化数据

- `template.factor.Rmd`: 对 factor 类型数据分析的模板

- `template.numeric.Rmd`: 对 numeric 类型数据分析的模板

代码改自 https://mastering-shiny.org/。

测试：
```r
shiny::runGitHub('badbye/shiny_data_analysis')
```

使用自己的数据: clone下来后把csv文件放进目录，命名为`data.csv`，再启动即可。

### TODO

- 筛选功能：如果列数太多，展示上会有麻烦；过滤的UI也一般般吧

- 分析模板: 比较简单，没啥东西