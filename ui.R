
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Monte Carlo simulation of pi"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      # Number of random plot attempts
      sliderInput("attempts",
                  "Number of attempts:",
                  min = 1,
                  max = 30000,
                  value = 5000),
      # Animation with custom interval (in ms) to control speed,
      # plus looping
      sliderInput("animation", "Looping Animation:", 1, 2000, 1,
                  step = 10, animate=
                    animationOptions(interval=300, loop=TRUE)),
      tableOutput("values")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
      #plotOutput("piPlot")
    )
  )
))
