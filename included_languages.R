# comment.char = "" must be set due to # char in C# 
tcir = read.table("included_languages.csv", sep=",", header=TRUE, comment.char = "")
sorted_by_ratio <- tcir[with(tcir, order(-cntlang, repository_language)), ]

png(filename="included-languages-commit-counts.png",
    width = 800, height = 600, units = "px", pointsize = 14
)

# suppress scientific notation of numbers
options(scipen=3)

# vertical labels: las=2, margins: mar=c(bottom, left, top, right)
par(las=2, mar=c(6, 6, 2, 2),mgp=c(4.5,1,0))
bp <- barplot(sorted_by_ratio$cntlang,
    ylab="Commit Message Count",
    names.arg=sorted_by_ratio$repository_language,
    col=heat.colors(nrow(tcir)),
    log(sorted_by_ratio$cntlang)
)

# close device
dev.off()
