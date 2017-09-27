library("shiny")
library("nclRshiny")

## Basic layout. Two regions.
ui = basicPage(
  plotOutput("scatter", click = "plot_click"),
  verbatimTextOutput("info")
)

## Simulate data
x = signif(rnorm(10), 3); y = signif(rnorm(10), 3);
server = function(input, output) {
  
  ## Scatter plot
  output$scatter = renderPlot(plot(x, y))
  
  ## Text box
  output$info = renderText(
    paste0("x = ", input$plot_click$x, "\ny = ", input$plot_click$y)
  )
  
}
runApp(list(ui=ui, server=server))
