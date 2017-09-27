library(shiny)
library(nclRshiny)
data(movies, package = "nclRshiny")

# note that this is not a fluidPage
ui = navbarPage("Using navbar",
  tabPanel("Plot",
           # each tab can have it's own layout
           sidebarLayout(
             sidebarPanel(
               radioButtons("movie_type", label = "Movie genre", c("Romance", "Action"))
               ),
             mainPanel(plotOutput("scatter"))
           )
  ),
  tabPanel("Summary",verbatimTextOutput("summary"))
)

server = function(input,output){
  dat = reactive({
    movies[movies[input$movie_type]==1,]
  })
  output$scatter = renderPlot({
    an = dat()
    plot(an$rating, an$length, ylab="Length", xlab="Rating", 
         pch=21, bg="steelblue", ylim=c(0, max(an$length)), 
         xlim=c(1, 10), main=paste0(input$movie_type, " movies"))
  })
  output$summary = renderPrint(summary(dat()[,c("length","rating")]))
}

runApp(list(ui=ui, server=server))