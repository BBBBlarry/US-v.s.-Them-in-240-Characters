library(shiny)
library(ggplot2)
library(dplyr)


description_p1 <- "In the fierce contest of the 2014 gubernatorial elections, the candidates fired attack at each other attempting to bring each other down."
description_p2 <- "In general, we can categorize tweets into a hierarchy. On the first level, given a tweet, it can be an attack tweet or not an attack tweet. On the second level, given an attack tweet, it can be about policy or about other things. Lastly, on the first level, given an policy tweet, it can be a contrast policy tweet or pure attack policy tweets."
description_p3 <- "This plot shows the proportion of each tweet classification. You can adjust the level of hierarchy by selecting the options from the left panel."

definition_attack <- "A tweet that is directly negatively impacting the opponent."
definition_policy <- "A attack tweet that is attack the opponent's policies."
definition_contrast <- "A policy attack tweet that also shows their own policies."

ui <- fluidPage(
    # Application title
    titlePanel("Tweet Coding Descriptive Stats"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("tweet_type", "Tweet Type:",
                        c("Attack" = "att",
                          "Policy" = "pol",
                          "Contrast" = "con")),
            mainPanel(
              br(),
              h3("Definitions"),
              HTML(paste(strong("Attack tweet: "), definition_attack)),
              br(),
              HTML(paste(strong("Policy tweet: "), definition_policy)),
              br(),
              HTML(paste(strong("Contrast tweet: "), definition_contrast)),
              br(),
              h3("What does this plot mean?"),
              p(description_p1),
              p(description_p2),
              p(description_p3)
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           h3("How frequently are candidates attacking?"),
           plotOutput("heatmap", height = "600px"),
           strong(textOutput("stats")),
           br()
        )

    )
)

server <- function(input, output) {

    dataset <- load_data()

    # plotting
    downsize_factor = 100
    num_attacks <- sum(dataset$is_attack) %/% downsize_factor
    num_policy <- sum(dataset$is_policy) %/% downsize_factor
    num_contrast <- sum(dataset$is_contrast) %/% downsize_factor
    num_total <- nrow(dataset) %/% downsize_factor

    # stats
    num_att = sum(dataset$is_attack)
    num_pol = sum(dataset$is_policy)
    num_con = sum(dataset$is_contrast)
    num_tot = nrow(dataset)
    perc_att = num_att / num_tot * 100
    perc_pol = num_pol / num_tot * 100
    perc_con = num_con / num_tot * 100

    heat_map_dataset = data.frame(X = 0:(num_total-1),
      is_attack = c(rep(1, num_attacks), c(rep(0, num_total - num_attacks))),
      is_policy = c(rep(1, num_policy), c(rep(0.5, num_attacks - num_policy)), c(rep(0, num_total - num_attacks))),
      is_contrast = c(rep(1, num_contrast), c(rep(0.8, num_policy - num_contrast)), c(rep(0.3, num_attacks - num_policy)), c(rep(0, num_total - num_attacks))))

    heat_map_dataset <- heat_map_dataset %>%
        arrange(desc(is_attack), desc(is_policy), desc(is_contrast))

    # add new sorted row number
    heat_map_dataset <- heat_map_dataset %>%
        mutate(sorted_id = row_number() - 1)

    heat_map_dataset <- heat_map_dataset %>%
        mutate(x_index = sorted_id %% 10) %>%
        mutate(y_index = sorted_id %/% 10)


    output$stats <- renderText({
        type <- input$tweet_type
        if(type == "att") {
            return(paste("Proportion: ", num_att, "out of", num_tot, "(", format(round(perc_att, 2), nsmall = 2), "%)", "tweets are attack tweets."))
        } else if (type == "pol") {
            return(paste("Proportion: ", num_pol, "out of", num_tot, "(", format(round(perc_pol, 2), nsmall = 2), "%)", "tweets are policy tweets."))
        } else if (type == "con") {
            return(paste("Proportion: ", num_con, "out of", num_tot, "(", format(round(perc_con, 2), nsmall = 2), "%)", "tweets are contrast tweets."))
        }
        return(1)
    })


    output$heatmap <- renderPlot({
        type <- input$tweet_type
        if(type == "att") {
            plot <- ggplot(data=heat_map_dataset, aes(x=x_index, y=y_index, fill=is_attack)) +
                geom_tile(width=0.7, height=0.7) +
                coord_equal() +
                scale_x_discrete(limits=seq(0,9),
                                 labels=seq(1,10)) +
                scale_y_discrete(limits=seq(0,29,5),
                                 labels=c(1,seq(5,30,5))) +
                theme(axis.line=element_blank(),
                      #axis.text.x=element_blank(),
                      #axis.text.y=element_blank(),
                      axis.ticks=element_blank(),
                      axis.text.x = element_text(size=12),
                      axis.text.y = element_text(size=12),
                      axis.title.x=element_blank(),
                      axis.title.y=element_blank(),
                      panel.background=element_blank(),
                      panel.border=element_blank(),
                      panel.grid.major=element_blank(),
                      panel.grid.minor=element_blank(),
                      plot.background=element_blank(),
                      plot.title = element_text(hjust = 0.5),
                      plot.subtitle = element_text(hjust = 0.5),
                      legend.title=element_blank()) +
                scale_fill_continuous(
                    type = "viridis",
                    guide = guide_legend(nrow=4),
                    breaks = c(1.0, 0.0),
                    labels = c("Attack Tweet", "Not Attack Tweet")) +
                labs(title = "The Type of Tweets Tweeted by 2014 Gubernatorial Candidates 3 Months Leading to the Election",
                     subtitle = "Each point represents 100 tweets.")
        } else if (type == "pol") {
            plot <- ggplot(data=heat_map_dataset, aes(x=x_index, y=y_index, fill=is_policy)) +
                geom_tile(width=0.7, height=0.7) +
                coord_equal() +
                scale_x_discrete(limits=seq(0,9),
                                 labels=seq(1,10)) +
                scale_y_discrete(limits=seq(0,29,5),
                                 labels=c(1,seq(5,30,5))) +
                theme(axis.line=element_blank(),
                      #axis.text.x=element_blank(),
                      #axis.text.y=element_blank(),
                      axis.ticks=element_blank(),
                      axis.text.x = element_text(size=12),
                      axis.text.y = element_text(size=12),
                      axis.title.x=element_blank(),
                      axis.title.y=element_blank(),
                      panel.background=element_blank(),
                      panel.border=element_blank(),
                      panel.grid.major=element_blank(),
                      panel.grid.minor=element_blank(),
                      plot.background=element_blank(),
                      plot.title = element_text(hjust = 0.5),
                      plot.subtitle = element_text(hjust = 0.5),
                      legend.title=element_blank()) +
                scale_fill_continuous(
                    type = "viridis",
                    guide = guide_legend(nrow=4),
                    breaks = c(1.0, 0.5, 0.0),
                    labels = c("Policy Tweet", "Other Attack Tweet", "Not Attack Tweet")) +
                labs(title = "The Type of Tweets Tweeted by 2014 Gubernatorial Candidates 3 Months Leading to the Election",
                     subtitle = "Each point represents 100 tweets.")
        } else if (type == "con") {
            plot <- ggplot(data=heat_map_dataset, aes(x=x_index, y=y_index, fill=is_contrast)) +
                geom_tile(width=0.7, height=0.7) +
                coord_equal() +
                scale_x_discrete(limits=seq(0,9),
                                 labels=seq(1,10)) +
                scale_y_discrete(limits=seq(0,29,5),
                                 labels=c(1,seq(5,30,5))) +
                theme(axis.line=element_blank(),
                      #axis.text.x=element_blank(),
                      #axis.text.y=element_blank(),
                      axis.ticks=element_blank(),
                      axis.text.x = element_text(size=12),
                      axis.text.y = element_text(size=12),
                      axis.title.x=element_blank(),
                      axis.title.y=element_blank(),
                      panel.background=element_blank(),
                      panel.border=element_blank(),
                      panel.grid.major=element_blank(),
                      panel.grid.minor=element_blank(),
                      plot.background=element_blank(),
                      plot.title = element_text(hjust = 0.5),
                      plot.subtitle = element_text(hjust = 0.5),
                      legend.title=element_blank()) +
                scale_fill_continuous(
                    type = "viridis",
                    guide = guide_legend(nrow=4),
                    breaks = c(1.0, 0.8, 0.3, 0.0),
                    labels = c("Contrast Tweet", "Other Policy Tweet", "Other Attack Tweet", "Not Attack Tweet")) +
                labs(title = "The Type of Tweets Tweeted by 2014 Gubernatorial Candidates 3 Months Leading to the Election",
                    subtitle = "Each point represents 100 tweets.")
        }

        return(plot)
    })
}

# Loads the tweet data
load_data <- function() {
    dataset <- read.csv(file = "./final_dataset.csv", header = TRUE)
    dataset$is_attack<- as.integer(as.logical(dataset$is_attack))
    dataset$is_policy<- as.integer(as.logical(dataset$is_policy))
    dataset$is_contrast<- as.integer(as.logical(dataset$is_contrast))
    dataset$incumbency<- as.integer(as.logical(dataset$incumbency))
    dataset$competitiveness<- as.integer(as.logical(dataset$competitiveness))

    # convert party label
    convert_party <- function(p) {
        if(p == "R") {
            return("R");
        } else if (p == "D") {
            return("D");
        } else {
            return("T");
        }
    }

    dataset$party <- as.factor(sapply(dataset$party, convert_party))
    return(dataset)
}


shinyApp(ui = ui, server = server)
