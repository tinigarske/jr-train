library("shiny")
library("nclRshiny")

## Basic layout. Two regions.
ui = basicPage(
  plotOutput("scatter", click = "plot_click"),
  verbatimTextOutput("info")
)

## Simulate data
x = signif(rnorm(100), 3); y = signif(rnorm(100), 3);
dd = data.frame(x, y)
server = function(input, output) {
  
  ## Scatter plot
  output$scatter = renderPlot({
    plot(dd$x, dd$y)
  })
  
  ## Text box
  output$info = renderPrint(
    # nearPoints() also works with hover and dblclick events
    nearPoints(dd, input$plot_click, xvar = "x", yvar = "y")
  )
  
}
runApp(list(ui=ui, server=server))
