library(shiny)
library(nclRshiny)

ui = fluidPage(titlePanel("invalidate"),
               fluidRow(
                 column(4,
                        wellPanel(
                          numericInput("n", label = "Number of points",value = 5)
                        )       
                 ),
                 column(8, plotOutput("scatter"))
               )
)

server = function(input,output,session){
  dat = reactive({
    invalidateLater(4000, session)
    # the plot has a reactive dependency on both
    # n and the invalidation timer
    data.frame(x = runif(input$n),y = runif(input$n))
  })
  output$scatter = renderPlot({
    d = dat()
    plot(d$x,d$y, xlim = c(0,1), ylim = c(0,1))
  })
}

runApp(list(ui=ui, server=server))