bp <- function(data, heading, names, ylim) {
  # vertical labels: las=2, margins: mar=c(bottom, left, top, right)
  par(las=2, mar=c(6, 6, 2, 2))
  bar <- barplot(
    data,
    main=heading,
    ylab='Percentage of total commit messages in language',
    ylim=ylim,
    names.arg=names,
    col=heat.colors(nrow(tcir))
  )
  
  text(bar, 0, round(data, 2), cex=.8, pos=3)
  title(sub="Source: geeksta.net / @yaph | Data: githubarchive.org", cex.sub = 0.8, col.sub = "gray40", line = 5, adj = 1)
}