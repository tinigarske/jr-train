## Typically:
## the ui part would be save in ui.R
## the server section in server.R
## The app would be run using runApp()

library("shiny")
library("nclRshiny")
data(movies, package="nclRshiny")
ui = fluidPage(
  titlePanel("I love movies"), #title
  ## Sidebar with a slider input for no. of points
  sidebarLayout( 
    sidebarPanel(
      selectInput("movie_type", label = "Movie genre", c("Romance", "Action", "Animation"))
    ),
    ## Show a plot of the generated distribution
    mainPanel(plotOutput("scatter"))
  )
)

server = function(input, output) {
  output$scatter = renderPlot({
    an = movies[movies[input$movie_type]==1,]
    setnicepar()
    plot(an$rating, an$length, ylab="Length", xlab="Rating", 
         pch=21, bg="steelblue", ylim=c(0, max(an$length)), 
         xlim=c(1, 10), main=paste0(input$movie_type, " movies"))
    grid()
    
  })
}

runApp(list(ui=ui, server=server))
