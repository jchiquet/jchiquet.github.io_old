mat.plot <- function(M, mode=c("raster", "tile")) {

  suppressMessages(require(reshape2))
  suppressMessages(require(ggplot2))
  suppressMessages(require(scales))
  
  mode <- match.arg(mode)
  rownames(M) <- 1:nrow(M)
  colnames(M) <- 1:ncol(M)
  
  ## turning the matrix to a proper ggplot data
  suppressMessages(d <- melt(as.data.frame(M)))
  d$row <- rep(1:nrow(M), ncol(M))
  d <- d[, c(3,1,2)]
  colnames(d) <- c("row", "col", "value")
  
  p <- ggplot(d, aes(row, col, fill = value, colour="gray80"))
  if (mode == "tile") {
    p <- p + geom_tile() 
  } else {
    p <- p + geom_raster() 
  }
  
  p <- p + scale_fill_gradient2(name="correlation",
                                limits=c(0,max(M)),
                                low = "white", high = muted("red"),
                                midpoint = 0.04, space = "Lab",
                                na.value = "grey50", guide = "colourbar") +
    theme(legend.position="none",
          axis.line = element_blank(), 
          axis.text.x = element_blank(), 
          axis.text.y = element_blank(),
          axis.ticks = element_blank(), 
          axis.title.x = element_blank(), 
          axis.title.y = element_blank())
  return(p)
}

