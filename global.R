library(shiny)

make_ui <- function(x, var) {
  na_num = sum(is.na(x))
  if (is.numeric(x)) {
    rng <- range(x, na.rm = TRUE)
    sliderInput(var, ifelse(na_num == 0, var, sprintf('%s (缺失数量: %s)', var, na_num)), 
                min = floor(rng[1]), max = ceiling(rng[2]), value = rng)
  } else if (is.factor(x)) {
    levs <- levels(x)
    selectInput(var, ifelse(na_num == 0, var, sprintf('%s (缺失数量: %s)', var, na_num)), 
                choices = levs, selected = levs, multiple = TRUE)
  } else {
    # Not supported
    NULL
  }
}


filter_var <- function(x, val) {
  if (is.numeric(x)) {
    !is.na(x) & x >= val[1] & x <= val[2]
  } else if (is.factor(x)) {
    x %in% val
  } else {
    # No control, so don't filter
    TRUE
  }
}

analysis_var <- function(df, var) {
  if (nrow(df) == 0 || !(var %in% colnames(df))){
    return(tags$div('没有选中任何数据'))
  }
  e <- new.env()
  
  x = df[[var]]
  e$data <- list(data=x, name=var)
  if (is.numeric(x)) {
    template = 'template.numeric.Rmd'
  } else if (is.factor(x)) {
    template = 'template.factor.Rmd'
  } else {
    return(tags$div('没有选中任何数据'))
  }
  output_file = file.path(getwd(), 'index.html')
  rmarkdown::render(template, output_file=output_file, envir = e)
  includeHTML('index.html')
}
