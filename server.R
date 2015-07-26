
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(plotrix) # for draw.circle()
library(grid)    # for grid()
library(ggplot2) # make pretty later
library(shiny)


#unit_circle <- function(x,y) sqrt((x-0.5)^2 + (y-0.5)^2) <= 0.5
#pi_est <- function(z,n) 4*length(z[z])/n
unit_circle <- function(x,y) sqrt((x-0.5)^2 + (y-0.5)^2) <= 0.5
throw_darts <- function(n) {
  num <<- n  # passed in number of attempts/points
  ps <<- matrix(runif(2*num), ncol=2) # random xy points
  zed <<- unit_circle(ps[,1], ps[,2]) # save inside/outside counts
}
pi_est <- function() 4*length(zed[zed])/num

draw_darts <- function() {
  #num <- n  # passed in number of attempts/points
  #zed <- z  # map of inside/outside circle
  plot(c(0, 1), c(0,1), type = "n", asp = 1, main="The Dartboard",xlab='Unit Square/Circle',ylab='',yaxt='n',frame.plot = FALSE)
  rect(0,0,1,1,border='black')
  draw.circle(0.5,0.5,0.5,border='black')
  points(ps[!zed,1], ps[!zed,2], col='blue', pch=20) # outside points
  points(ps[zed,1], ps[zed,2], col='green', pch=20)  # inside points
}



shinyServer(function(input, output) {

  mydata <- reactive({
    attempts <- input$attempts
    animatation <- input$animation
    pi_estimate <- 0
    pi_error <- 0
  })
  
  sliderValues <- reactive({
    data.frame(
      Name  = c("Attempts","Animation","Pi Estimate"),
      Value = c(input$attempts,input$animation,0))
  })
  
  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
  
  # Render plot of the simulation
  output$distPlot <- renderPlot({

    # Throw some darts! So fast!
    throw_darts(input$attempts)
    
    # draw the basic plots
    draw_darts()
    
    pi_estimate <- pi_est()
    #sliderValues()[["Pi Estimate"]] <- pi_estimate
    #mydata().pi_estimate <- pi_estimate
    
    #par(mfrow=c(3,1))
    #plot(c(0, 1), c(0,1), type = "n", asp = 1, ann=FALSE, xaxt='n',yaxt='n',frame.plot = FALSE)
    #rect(0,0,1,1,border='black')
    #draw.circle(0.5,0.5,0.5,border='black')
    #points(ps[!zed,1], ps[!zed,2], col='blue', pch=20) # outside points
    #points(ps[zed,1], ps[zed,2], col='green', pch=20)  # inside points
    #plot(c(0,input$attempts),c(-1,4), type = "n")
    #lines(sapply(1:5000,function(x,y) {4*length(y[y])/x}, y=zed[1:5000]))
    
  })
  
  # Show the estimate plot of pi
  output$piPlot <- renderPlot({
    plot(c(0,30000),c(-0.5,5), type = "n")
    abline(h=pi,col=2,lty=2)
    # Attempt at plotting pi estimate
    # plot(sapply(1:5000,function(x,y) {4*length(y[y])/x}, y=z[1:5000]))
  })
})
