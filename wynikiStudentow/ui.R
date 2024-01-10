#tabpanele
tabpanel1 <- tabPanel("Histogramy", uiOutput('page1'),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("bins", "Liczba klas:",min = 1, max = 50,value = 30)
                        ),
                        mainPanel(plotOutput("mathHist"), plotOutput("writingHist"), plotOutput("readingHist"))
                      )
)
tabpanel2 <- tabPanel("Regresyjne drzewa klasyfikacyjne", uiOutput('page2'),
                      sidebarLayout(
                        sidebarPanel(
                          checkboxGroupInput("variables", "Wybierz zmienne objaśniające: ", 
                                             choices=list('Płeć' = 'Plec', 
                                                          'Rasa' = 'Rasa', 
                                                          'Wykształcenie rodziców' = 'WyksztalcenieRodzicow', 
                                                          'Rodzaj spożywanego lunchu' = 'Lunch', 
                                                          'Ukończenie testu przygotowującego' = 'Test'),
                                             selected = c("Plec", "Rasa","WyksztalcenieRodzicow", "Lunch", "Test") ),
                          radioButtons("scoreVar", "Wybierz zmienną objaśnianą:", 
                                       choices = list('Wynik z matematyki' = 'math.score', 
                                                      'Wynik z pisania' = 'writing.score',
                                                      'Wynik z czytania' = 'reading.score'),
                                      )
                        ),
                        mainPanel(plotOutput('tree'))
                      )
)
tabpanel3 <- tabPanel("Wykresy pudełkowe wyników", uiOutput('page3'),
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("corrVarX", "Wybierz zmienną wg której podzielić próbę", 
                                       choices = list('Płeć' = 'Plec', 
                                                      'Rasa' = 'Rasa', 
                                                      'Wykształcenie rodziców' = 'WyksztalcenieRodzicow', 
                                                      'Rodzaj spożywanego lunchu' = 'Lunch', 
                                                      'Ukończenie testu przygotowującego' = 'Test')
                          ),
                          radioButtons("corrVarY", "Wybierz który z wyników odłożyć na osi Y:", 
                                       choices = list(
                                                      'Wynik z matematyki' = 'math.score', 
                                                      'Wynik z pisania' = 'writing.score',
                                                      'Wynik z czytania' = 'reading.score')
                          )
                        ),
                        mainPanel(plotOutput('corr'))
                      )
)


#RysujUI
fluidPage(
    # CSS
    includeCSS("styles.css"),
    # Application title
    titlePanel("Analiza wyników studentów"),
    # Wywolanie UI
    navbarPage("", collapsible = T, id="navbar", 
          tabpanel1, tabpanel2, tabpanel3
    )
    
)

      
    
    
  

