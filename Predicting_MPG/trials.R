library(datasets)
data(mtcars)
aa = 'Manu'
if (aa == 'Manu') {
  data<-mtcars[mtcars$am == 0,] 
  fit <- lm(data$mpg~ data$wt)
} else{ 
  data<-mtcars[mtcars$am == 1,] 
  fit <- lm(mpg~ wt, data = data)
}

wt <- c(3)
pred <- data.frame(wt)
pred$mpg <- predict(fit, pred)
            
#as.character(format(pred$mpg, digits =3))


ggplot(data, aes(wt, mpg)) +
         geom_smooth(method = lm)  +
  geom_point(data = pred, aes(wt, mpg), colour =2, size =10) +
  geom_text(x = pred$wt+0.5, y=pred$mpg, label = 'Predicted MPG is') + 
  geom_text(x = pred$wt+0.5, y=pred$mpg-2, label = as.character(format(pred$mpg, digits =3))) 


