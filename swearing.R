# comment.char = "" must be set due to # char in C# 
tcir = read.table("merged_counts_swearing.csv", sep=",", header=TRUE, comment.char = "")
# order by issue_count descending then by language name
sorted_by_ratio <- tcir[with(tcir, order(-percentage, language)), ]

# open a device using png() and specify taget image file
png(filename="commit-messages-swearing-percentage.png",
    width = 800, height = 600, units = "px", pointsize = 14
)

# vertical labels: las=2, margins: mar=c(bottom, left, top, right)
par(las=2, mar=c(6, 6, 2, 2))
bp <- barplot(sorted_by_ratio$percentage,
    ylab="Percentage",
#    ylim=c(0,.18),
    names.arg=sorted_by_ratio$language,
    col=heat.colors(nrow(tcir))
)
text(bp, 0, round(sorted_by_ratio$percentage, 2), cex=.8, pos=3)

# close device
dev.off()
