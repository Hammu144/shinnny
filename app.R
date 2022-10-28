library(shiny)
library(lab05)

ui <- function(){
  shiny::fluidPage(
    shiny::textAreaInput("user_input", "Enter your text", value = "defual" ),
    shiny::plotOutput("qr_code", width = "100%", height = "400px"),
  )
}

server <-  function(input, output) {
  
  reactive({
    input$userinput
  })
  
  output$qr_code <- shiny::renderPlot({
    qr_data <- (lab05::fetch_qr(input$user_input, size = 150*150))
    a <-  png::readPNG(qr_data, native = FALSE, info = FALSE)
    b <-  matrix(a, nrow=150, byrow = TRUE)
    
    stats::heatmap(b, Rowv = NA,
                   Colv = NA, scale = "none", col = c("black", "white"),
                   labRow = "", labCol = "")
    
  })
  
  
}


shiny::shinyApp(ui, server)
  


