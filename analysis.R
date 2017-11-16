# This project is done by Janesh Devkota on 2017-11-16

# Please run this file in order to create codebook.md and analysis.md
# While there are several libraries that are reference in analysis.R only knitr and markdown will be 
# required here
require(knitr)
require(markdown)

knit(input = "analysis.Rmd", encoding="ISO8859-1", output = "analysis.md")
markdownToHTML("analysis.md", "run_analysis.html")
