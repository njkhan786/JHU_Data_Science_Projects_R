library(shiny)

# Loading libraries and data
library(datasets)
library(ggplot2)
data(mtcars)


shinyServer(
  function(input, output){
    output$oam <- renderPrint({input$am})
    output$oweight <- renderPrint({input$weight})    
    #output$odate <- renderPrint({input$date})
    
    output$oplot <- renderPlot({
      if (input$am == 'Manu') {
        data<-mtcars[mtcars$am == 0,]
        fit <- lm(mpg~ wt, data = data)
      } else{ 
        data<-mtcars[mtcars$am == 1,] 
        fit <- lm(mpg~ wt, data = data)
      }

      wt <- input$weight
      pred <- data.frame(wt)
      pred$mpg <- predict(fit, pred)
      
      ggplot(data, aes(wt, mpg)) +
        ggtitle('Estimation of the MPG') +
        xlab('Weight (in ton)') +
        ylab('MPG (miles per gallon)') +
        geom_smooth(method = lm)  +
        geom_point(data = pred, aes(wt, mpg), colour =2, size =10) +
        geom_text(x = pred$wt+0.5, y=pred$mpg, label = 'Predicted MPG is') + 
        geom_text(x = pred$wt+0.5, y=pred$mpg-2, label = as.character(format(pred$mpg, digits =3))) 
      
      
    })
  }
)