library(shiny)

ui = fluidPage(fluidRow(
  column(4,wellPanel(radioButtons("dist", label = "Distribution", choices = c("Normal","Poisson")))),
  column(4,wellPanel(numericInput("n", label = "N points", value = 10, min = 1))),
  column(4,uiOutput("parchoice"))
  ),
  fluidRow(plotOutput("hist"))
)

server = function(input,output){
  output$parchoice = renderUI({
    switch(input$dist,
           Normal = wellPanel(numericInput("mean", label = HTML("&mu;:"), value = 0),
                              numericInput("sd",label = HTML("&sigma;:"), value = 1)),
           Poisson = wellPanel(numericInput("rate", label = HTML("&lambda;:"), value = 10))
    )
  })
  dat = reactive({
    switch(input$dist,
           Normal = rnorm(input$n, input$mean, input$sd),
           Poisson = rpois(input$n, input$rate)
           )
  })
  output$hist = renderPlot({
    switch(input$dist,
           Normal = hist(dat()),
           Poisson = barplot(table(dat()))
    )
  })
    
}

runApp(list(ui = ui, server = server))