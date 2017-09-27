library(shiny)
library(shinydashboard)
library(nclRshiny)
data("movies",package = "nclRshiny")

mycss <- "
.info-box:hover,
.info-box:hover .info-box-icon {
background-color: #7FFFD4 !important;
}
.info-box:active,
.info-box:active .info-box-icon {
background-color: #7FFFD4 !important;
}
"

withPopup <- function(tag, text) {
  content <- div(em(text))
  tagAppendAttributes(
    tag,
    `data-toggle` = "popover",
    `data-html` = "true",
    `data-trigger` = "hover",
    `data-content` = content
  )
}

ui = dashboardPage(
  dashboardHeader(title = "Tags"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard"))
    )),
  dashboardBody(
    # to allow my own CSS and JS
    tags$head(tags$style(HTML(mycss))),
    tags$head(tags$script("$(function() { $(\"[data-toggle='popover']\").popover(); })")),
    tabItems(
      tabItem("overview",
              fluidRow(
                column(4,radioButtons("genre", "Movie Genre", 
                                      choices = c("Romance","Action","Comedy"))),
                
                  withPopup(infoBox("N",textOutput("nbox"))," films in this category")
                  
              )
      )
    )
  )
)

server = function(input,output){
 output$nbox = renderText({
   nrow(movies[movies[input$genre]==1,])
 })
}

runApp(list(ui = ui, server = server))