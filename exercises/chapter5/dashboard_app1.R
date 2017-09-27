library(shiny)
library(shinydashboard)

ui = dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("My tab", tabName = "tab1", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("tab1",{
        tableOutput("shinydash")
      })
    )
  )
)

server = function(input,output){
  output$shinydash = renderTable(data.frame(getNamespaceExports("shinydashboard")))
}

runApp(list(ui=ui, server=server))