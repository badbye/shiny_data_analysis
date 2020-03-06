#' 猜测数据类型,自动转换
guess_type <- function(x) {
  if (is.numeric(x)) {
    return(guess_type.numeric(x))
  }
  if (is.factor(x)){
    return(guess_type.factor(x))
  }
  if (is.logical(x)){
    return(as.factor(as.integer(x)))
  }
  return(x)
}

guess_type.numeric <- function(x) {
  nlen = length(x)
  if (length(unique(x)) <= max(min(nlen * 0.1, 10), 20)) {
    return(as.factor(x))
  }
  x
}

guess_type.factor <- function(x) {
  if (length(levels(x)) == length(x)){
    return(as.character(x))
  }
}