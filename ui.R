library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textOutput('desc'),
      uiOutput("filter")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("数据",  DT::dataTableOutput("data")),
        tabPanel("分析",  
                 uiOutput("col"),
                 uiOutput('analysis')
        )
      )
    )
  )
)