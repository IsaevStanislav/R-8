library('shiny')       # загрузка пакетов
library('data.table')

df <- data.table(read.csv('IMDB-201811.csv', 
                          stringsAsFactors = F))

# размещение всех объектов на странице
shinyUI(
    pageWithSidebar(
        # название приложения:
        headerPanel('Разброс показателей фильмов за 2018 год на портале IMDb'),
        # боковая панель:
        sidebarPanel(                           # шаг
            # выпадающий список: переменная по оси 0Y
            selectInput('Y.var',    # переменная
                        'Переменная Y',
                        # список:
                        list('Сборы фильма' = 'Gross_Earning_in_Mil',
                             'Оценка' = 'Rating',
                             'Оценка Metascore' = 'Metascore',
                             'Жанр' = 'Genre'),
                        selected = 'Gross_Earning_in_Mil'),
            # выпадающий список: переменная по оси 0X 
            selectInput('X.var',    # переменная
                        'Переменная X',
                        # список:
                        list('Сборы фильма' = 'Gross_Earning_in_Mil',
                             'Оценка' = 'Rating',
                             'Оценка Metascore' = 'Metascore',
                             'Жанр' = 'Genre'),
                             selected = 'Rating'),
            sliderInput('Runtime.range', 'Продолжительность:',
                        min = 85, max = 152, value = c(85, 152))
        ),
        # главная область
        mainPanel(
          # график разброса переменных
          plotOutput('gplot'),
          # описательные статистики
          verbatimTextOutput('XY.summary'),
          # модель
          verbatimTextOutput('lm.result')
            )
        )
    )