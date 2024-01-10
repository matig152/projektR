# Define server logic required to draw a histogram
function(input, output, session) {
  #load packages
  library(ggplot2)
  library(rpart)
  library(rpart.plot)
  library(dplyr)
  # logic
  students_df <- read.csv("StudentsPerformance.csv")
  colnames(students_df) <- c("Plec", "Rasa", "WyksztalcenieRodzicow", "Lunch", "Test", "math.score", "reading.score", "writing.score")
  
    # Histogramy 
    output$mathHist <- renderPlot({
        x <- students_df$math.score
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = 'lightblue', border = 'blue',
             xlab = 'Wynik w %', ylab="",
             main = 'Histogram wyników z matematyki')
    })
    output$writingHist <- renderPlot({
      x <-students_df$writing.score
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = 'lightgreen', border = 'darkgreen',
           xlab = 'Wynik w %', ylab="",
           main = 'Histogram wyników z pisania')
    })
    output$readingHist <- renderPlot({
      x <- students_df$reading.score
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
      scor <- students_df[[scoreVar]]
      # RENDERUJ DRZEWKO
      formula <- paste0("scor ~ ", paste(vars, collapse=" + "))
      rpart.plot(rpart(as.formula(formula) , data=students_df), 
                 tweak = 0.8, type=1, shadow.col = "#176B87", branch.lty = 5, extra = 101, 
                 fallen.leaves = T, leaf.round = 0, round = 0, branch.col = "#176B87", branch.lwd = 3, 
                 nn.round=0, split.cex =1.2)
    })
    # Wykresy zależności zmiennych
    output$corr <- renderPlot({
      #ZBIERZ ZMIENNĄ X
      varX <- input$corrVarX
      #ZBIERZ ZMIENNĄ Y
      varY <- input$corrVarY
      #WYKRESY
      w <- ggplot(data = students_df, aes(x = .data[[varX]], y = .data[[varY]])) + 
        geom_boxplot(fill="#B4D4FF", color="#176B87") + theme_minimal() + 
        ggtitle(paste("Porównanie rozkładów zmiennej '", varY, "' w kategoriach zmiennej '", varX, "'"))
      print(w)
    })
    
}
