# tabSet layouts

library("shiny")
library("nclRshiny")
data(movies, package="nclRshiny")
# pick out a subset of data to play with
movies = movies[,c("Romance","Action","length","rating")]

ui = fluidPage(
  titlePanel("Tabsets"),
  # side bar for choosing the genre
  sidebarLayout(
    sidebarPanel(
      radioButtons("movie_type", label = "Movie genre", c("Romance", "Action"))
    ),
    mainPanel(
      # use a tabset panel within the main panel
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("scatter")),
                  tabPanel("Summary", verbatimTextOutput("summary"))
      )
    )
  )
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