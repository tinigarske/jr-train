drat::addRepo("rcourses")
install.packages("nclRshiny")
install.packages("nclRshiny", dependencies = TRUE)

################################################################################
library("nclRshiny")

vignette("slides1", package = "nclRshiny")
vignette("chapter1", package = "nclRshiny")
vignette("chapter2", package = "nclRshiny")
vignette("chapter3", package = "nclRshiny")

nclRshiny::create_project()
## some editing of the .Rmd
rmarkdown::render("exercises/chapter1/markdown1.Rmd""")
rmarkdown::render("test.Rmd")
