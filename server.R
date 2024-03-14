#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinyjs)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  shinyjs::disable(id = "run")
  
    estimate <- reactive({
      req(input$ADT)
      req(input$HUmean)
      req(input$SUVmax)
      lp <- -4.660246 + 1.690656 * as.numeric(input$ADT) + 0.0043016 * input$HUmean + 0.317027 * input$SUVmax 
      p <- 1/(1+exp(-lp))
      return(p)
    })
    
    # estimate <- bindEvent(reactive({
    #   req(input$ADT)
    #   req(input$HUmean)
    #   req(input$SUVmax)
    #   lp <- -4.660246 + 1.690656 * as.numeric(input$ADT) + 0.0043016 * input$HUmean + 0.317027 * input$SUVmax 
    #   p <- 1/(1+exp(-lp))
    #   return(p)
    # }), input$run)

    output$outText <- renderUI({
      est <- estimate()
      est.col <- switch(as.character(cut(est, breaks = c(-Inf, 0.25, 0.50, 0.75, Inf))),
             "(-Inf,0.25]" = "#1fde18", 
             "(0.25,0.5]" = "#eded47",
             "(0.5,0.75]" = "#f0ad30",
             "(0.75, Inf]" = "#f04630")
      HTML(sprintf("The estimated risk of true skeletal metastases for a prostate cancer patients exhibiting [18F]PSMA-1007 bone focal uptakes with an 
              HUmean of %.1f and a SUVmax of %s is:</br>
              <div style='text-align: center; margin:10px'><h1 style='color:%s'>%.1f%%</h3></div>
              </br></br><p>For citation purposes, please reference ...</p>", 
              input$HUmean,
              input$SUVmax,
              est.col,
              est*100))
    })
    
    observe({
      if(input$ADT!='' & !is.na(input$HUmean) & !is.na(input$SUVmax)) {
        shinyjs::enable(id = "run")
      } else {
        shinyjs::disable(id = "run")
      }
    })

    # force inrange values
    observeEvent(input$HUmean, {
      if (!is.na(input$HUmean)) {
        if (input$HUmean > 2000) {
          updateNumericInput(session = session, "HUmean", value = 2000)
        }
        if (input$HUmean < 0) {
          updateNumericInput(session = session, "HUmean", value = 0)
        }
      }
    })

    observeEvent(input$SUVmax, {
      if (!is.na(input$SUVmax)) {
        if (input$SUVmax > 400) {
          updateNumericInput(session = session, "SUVmax", value = 400)
        }
        if (input$SUVmax < -1000) {
          updateNumericInput(session = session, "SUVmax", value = -1000)
        }
      }
    })
}
