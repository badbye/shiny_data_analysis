library(shiny)
library(shinyjs)
source('global.R')
source('data.R')

server <- function(input, output, session) {
  vars <- reactive(colnames(get_df()))
  
  # --------------------------- 动态UI & 数据计算 --------------------------- #
  output$filter <- renderUI({
    lapply(vars(), function(x) make_ui(get_df()[[x]], x))
  })
  
  selected <- reactive({
    each_var <- lapply(vars(), function(x) filter_var(get_df()[[x]], input[[x]]))
    # Reduce(`&`, each_var)
    purrr::reduce(each_var, `&`)
  })
  
  filteredData <- reactive({
    get_df()[selected(), ]
  })
  
  #--------------------------- 数据展示 ---------------------------#
  output$desc <- renderText({
    sprintf('数据总量: %s; 筛选后数据量: %s', 
            nrow(get_df()), 
            nrow(filteredData())
            )
  })
  output$table <- DT::renderDT({
    DT::datatable(filteredData(), filter = "top",
                  options = list(stateSave = TRUE))
  })
  
  observeEvent(input$table_state, {
    print(input$table_state)
  })
  # --------------------------- 分析 --------------------------- #
  output$col <- renderUI({
    selectInput('selectedColumn', label='选择变量', 
                choices = vars(), selected=vars()[1])
  })
  
  output$analysis <- renderUI({
    analysis_var(filteredData(), input$selectedColumn)
  })
  
}