# Define server logic required to draw a histogram
function(input, output, session) {
  data <- read.csv("StudentsPerformance.csv")
  colnames(data) <- c("Plec", "Rasa", "WyksztalcenieRodzicow", "Lunch", "Test", "math.score", "reading.score", "writing.score")
  
    # Histogramy 
    output$mathHist <- renderPlot({
        x <- data$math.score
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = 'lightblue', border = 'blue',
             xlab = 'Wynik w %', ylab="",
             main = 'Histogram wyników z matematyki')
    })
    output$writingHist <- renderPlot({
      x <-data$writing.score
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = 'lightgreen', border = 'darkgreen',
           xlab = 'Wynik w %', ylab="",
           main = 'Histogram wyników z pisania')
    })
    output$readingHist <- renderPlot({
      x <- data$reading.score
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = 'pink', border = 'red',
           xlab = 'Wynik w %', ylab="",
           main = 'Histogram wyników z czytania')
    })
    
    # Drzewka regresyjne
    output$tree <- renderPlot({
      # ZBIERZ OBJAŚNIAJĄCE ZMIENNE 
      vars <- input$variables
      # ZBIERZ OBJAŚNIANĄ ZMIENNĄ
      scoreVar <- input$scoreVar
      scor <- data[[scoreVar]]
      # RENDERUJ DRZEWKO
      formula <- paste0("scor ~ ", paste(vars, collapse=" + "))
      rpart.plot(rpart(as.formula(formula) , data=data))
    })
    
    
}
