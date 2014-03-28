source('globals.R')

# comment.char = "" must be set due to # char in C# 
tcir = read.table("merged_counts_joy.csv", sep=",", header=TRUE, comment.char = "")
# order by issue_count descending then by language name
sorted_by_ratio <- tcir[with(tcir, order(-percentage, language)), ]

# open a device using png() and specify taget image file
png(filename="commit-messages-joy-percentage.png",
    width = 800, height = 600, units = "px", pointsize = 14
)

bp(sorted_by_ratio$percentage,
   'Commit Messages with Expressions of Joy',
   sorted_by_ratio$language,
   c(0, 0.2))

# close device
dev.off()
