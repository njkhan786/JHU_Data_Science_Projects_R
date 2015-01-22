library(shiny)

shinyUI(
  pageWithSidebar(
    
    headerPanel('Predicting the MPG of a car!'),
    
    # Sidebar panel for the input
    sidebarPanel(
      h3('What kind of car?'),
      checkboxGroupInput('am','Transmission type (Please only select one):',
                         c("Manu" = "Manu",
                           "Automatic" = "Automatic")),
      numericInput('weight', 'Weight of the car (in ton):', 3, min = 0.2, max = 6, step = 0.2)
    ),
    
    # Main panel for rendering the output
    mainPanel(
      # be careful we only have data for manu cars for less than 3 tons 
      # It's usually a good idea to reshow people the values they entered   
      h4("You've selected:"),
      verbatimTextOutput("oam"),
      verbatimTextOutput("oweight"),
      plotOutput('oplot'),
      
      h4('Did you know?'),
      p('Manual cars weight less than 2800 lbs have larger MPGs than cars 
        with automatic transmission. However, for cars heavier than 2800 lbs, 
        those with automatic transmssion have a larger MPG, therefore better 
        fuel efficiency.')
      )
    
  ))