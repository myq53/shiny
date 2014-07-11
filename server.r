library(shiny)
data(swiss)
slidingColors <- colorRampPalette(c('orange','green'))

 shinyServer(
     function(input, output) {
         output$myPlot <- renderPlot({
         provinces <- numeric(0);
         if (1 %in% input$religions) { provinces <- c(provinces, which(swiss$Catholic > 50))}
         if (2 %in% input$religions) { provinces <- c(provinces, which(swiss$Catholic < 50))}
         data <- reactive(swiss[provinces,])
         y <- data()$Fertility
         if (input$dropdown == 1) {
             x <- data()$Agriculture
             message <- "Percentage of males involved in agriculture as their occupation"
             xrange <- c(0,1.1*max(swiss$Agriculture))
         } 
         if (input$dropdown == 2) {
             x <- data()$Education 
             message <- "Percentage of draftees with education beyond primary school"
             xrange <- c(0,1.1*max(swiss$Education) + 5)
         }
         if (input$dropdown == 3) {
             x <- data()$Infant.Mortality
             message <- "Infant (<1 year) mortality rate" 
             xrange <- c(0,1.1*max(swiss$Infant.Mortality) + 5)
         }
         if (input$dropdown == 4) {
             x <- data()$Examination
             message <- "Percentage of draftees receiving the highest mark on an army examination"
             xrange <- c(0,1.1*max(swiss$Examination) + 5)
         }
         if (length(provinces) > 0)
         {  
             plot(x,y,xlim = xrange, ylim = c(30,100), 
                 xlab = message, ylab = "standardized fertility", cex = 1.25, pch = 19,
                 col =  slidingColors(10)[as.numeric(cut(data()$Catholic, breaks = c(0,10,20,30,40,50,60,70,80,90,100)))] 
                 ) 
            fit <- lm(y~x)
            abline(fit, col = "blue", lwd = 2)
         }
         })
         
     }
 )

