library(shiny)
library(tidyverse)
library(plotly)
library(shinycssloaders)
library(shinydashboard)

ranking <- readRDS("ranking.rds" ) %>% mutate(siglaTribunal = fct_reorder(siglaTribunal, score, .desc = T))

top5 <- ranking %>% slice_min(order_by = score, n = 5) %>% pull(siglaTribunal) %>% as.character()

ui <- dashboardPage(
    dashboardHeader(title = "Inconsistências nos dados dos Juizados Especiais", titleWidth = 500),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Sobre", tabName = "sobre", icon = icon("info")),
        menuItem("Ranking", tabName = "ranking", icon = icon("trophy"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = "sobre",
              fluidRow(
                column(width = 6,
                       h2("Por que Juizado Especial?"),
                       p("O grupo 3 do desafio 2 do CNJ Inova optou por por focar na Justiça Estadual, por ser a 
                          porta de entrada e onde está localizada a maior parte da movimentação processual brasileira. 
                          E para poder ajustar algoritmos de machine learning e fazer análises mais precisos, optamos 
                          também por focar nos Juizados Especiais, por possuir um grande diversidade de processos e partes, 
                          gerande grande inconsistência de dados. O código e análise podem ser posteriormente adaptados 
                          para outros graus e ramos."), 
                       h2("Sobre o Ranking"),
                       p("O ranking é feito baseado em um score de inconsistência dos dados processuais
                         do DataJud, calculado por um algoritmo não supervisionado de detecção de anomalias, 
                         o isolation forest, para cada tribunal."), 
                       h2("Prêmio CNJ de Qualidade"),
                       p("A ideia é dialogar com o já existente Prêmio CNJ de Qualidade, que possui um Eixo dos 
                         Dados e Tecnologia com requisitos do DataJud. O ranking de inconsistência seria, então, 
                         mais um critério que ensejaria pontuação e incentivaria boas práticas na inserção dos dados."), 
                       offset = 0.5)
              )
      ),
      tabItem(tabName = "ranking",
              fluidRow(
                column(width = 12,
                h2("Ranking de Inconsistência nos Dados"),
                p("Verde: menor que a média nacional de inconsistência"),
                p("Vermelho: maior que a média nacional de inconsistência"),
                withSpinner(plotlyOutput("ranking", width = "800px", height = "800px")), offset = 0.5)
              )
      )
    )
  )
, skin = "green")
server <- function(input, output) {

    output$ranking <- renderPlotly({
      ranking %>%
        plot_ly(y = ~siglaTribunal, x = ~score, color = ~score > mean(score),
                colors = c("forestgreen", "red")) %>% 
        add_bars(hoverinfo = "text", text = ~paste0("Tribunal: ", siglaTribunal, 
                                                    "\nScore de Inconsistência: ", format(score, decimal.mark = ",", digits = 3))) %>% 
        layout(title = "", showlegend = FALSE,
               yaxis = list(title = "Sigla do Tribunal"),
               xaxis = list(title = "Score de Inconsistência")) %>% config(displayModeBar = F) %>% 
        add_annotations(x = c(0.45, 0.48, 0.48, 0.48, 0.49),
                        y = top5,
                        text = c("+50 pontos Prêmio CNJ", "+40 pontos Prêmio CNJ", "+30 pontos Prêmio CNJ", 
                                 "+20 pontos Prêmio CNJ", "+10 pontos Prêmio CNJ"),
                        showarrow = FALSE)
    })
}

shinyApp(ui = ui, server = server)
