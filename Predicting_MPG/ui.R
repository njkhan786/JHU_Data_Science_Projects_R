library(shiny)

shinyUI(
  pageWithSidebar(
    
    headerPanel('Predicting the MPG of a car in the 70s!'),
    
    # Sidebar panel for the input
    sidebarPanel(
      h4('What kind of car?'),
      checkboxGroupInput('am','Transmission type (Please only select one):',
                         c("Manu" = "Manu",
                           "Automatic" = "Automatic")),
      numericInput('weight', 'Weight of the car (in ton):', 3, min = 0.2, max = 6, step = 0.2)
    ),
    
    # Main panel for rendering the output
    mainPanel(
      # Introduction
      h3('How it works:'),
      p('This program predicts the MPG of a car in the 70s based on data from 1974 
        Motor Trend US magazines. Please select the transmission and weight 
        of the car you want to predict in the left penal. The predicted MPG 
        and the general trend of MPG for cars of various weight will be shown 
        in the diagram below.'),
      
      # be careful we only have data for manu cars for less than 3 tons 
      # It's usually a good idea to reshow people the values they entered   
      h3("You've selected:"),
      verbatimTextOutput("oam"),
      verbatimTextOutput("oweight"),
      plotOutput('oplot'),
      
      h3('Did you know?'),
      p('Manual cars weight less than 2800 lbs have larger MPGs than cars 
        with automatic transmission. However, for cars heavier than 2800 lbs, 
        those with automatic transmssion have a larger MPG, therefore better 
        fuel efficiency.')
      )
    
  ))