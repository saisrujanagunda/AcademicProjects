library(shiny)

# Load the book_dataset_cleanv.csv file
local_csv <- read.csv("C:/MS_Fall/SC & P/SciComp Project Files/book_dataset_cleanv.csv")

ui <- fluidPage(
  tags$head(
    tags$style(
      HTML(
        "
        body {
          background-image: url('https://www.wallpapertip.com/wmimgs/9-97960_26102-title-room-of-knowledge-man-made-book.jpg'); 
          background-size: cover;
          background-repeat: no-repeat;
          background-attachment: fixed;
          font-family: 'Georgia', Lato;
          color: #333;
        }
        .title {
          text-align: center;
          font-size: 36px;
          margin-bottom: 20px;
        }
        .sidebar {
          background-color: rgba(255, 255, 255, 0.8);
          padding: 20px;
          border-radius: 10px;
          max-width: 600px; 
          color: white;
          margin: 0 auto; 
          
        }
        .main-panel {
          background-color: rgba(255, 255, 255, 0.8);
          padding: 20px;
          border-radius: 10px;
        }
        #keywordInput {
          width: 100%;
          padding: 8px;
          margin-bottom: 10px;
          border-radius: 5px;
          border: 1px solid #ccc;
        }
        #submit {
          width: 100%;
          padding: 8px;
          border-radius: 5px;
          background-color: #A0522D;
          color: white;
          border: none;
        }
        #submit:hover {
          background-color: #8B4513;
          cursor: pointer;
        }
        table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 20px;
        }
        th, td {
          padding: 8px;
          text-align: left;
          border-bottom: 1px solid #ddd;
        }
        "
      )
    )
  ),
  titlePanel("Book Recommender"),
  sidebarLayout(
    sidebarPanel(
      div(class = "sidebar",
          textInput("keywordInput", "Enter keyword:"),
          actionButton("submit", "Get Recommendations")
      )
    ),
    mainPanel(
      div(class = "main-panel",
          tableOutput("bookList")
      )
    )
  )
)

server <- function(input, output) {
  filtered_books <- reactive({
    keyword <- input$keywordInput
    
    # Checking if the keyword is not empty
    if (nchar(keyword) > 0) {
      keyword <- tolower(keyword)
      
      #
      matching_books <- local_csv[grep(keyword, tolower(local_csv$contents)), ]
      
      # Convert empty strings in 'Author' column to NA
      matching_books$Author[matching_books$Author == ""] <- NA
      
      # Remove rows with NA or empty values in specified columns
      matching_books <- matching_books[complete.cases(matching_books$Title, matching_books$Author, matching_books$ISBN, matching_books$Rating), ]
      
      # Checking if there are matching books after filtering
      if (nrow(matching_books) > 0) {
        # Sort by avg_reviews/Rating column to get top-rated books
        top_books <- matching_books[order(matching_books$Rating, decreasing = TRUE), ]
        
        # Return the top 10 books
        return(head(top_books, 10))
      } else {
        # Return a message if no matching books found
        return(data.frame(message = "No matching books found for the entered keyword."))
      }
    } else {
      return(NULL)
    }
  })
  
  output$bookList <- renderTable({
    req(input$submit)
    filtered_data <- req(filtered_books())
    
    if (is.null(filtered_data)) {
      return(NULL)
    } else if ("message" %in% colnames(filtered_data)) {
      return(data.frame(message = filtered_data$message))
    } else {
      filtered_books_subset <- filtered_data[, c("ISBN","Title", "Author", "Rating")] # Creating a subset of the filtered data containing specific columns ISBN, Title, Author, Rating
      return(filtered_books_subset)
    }
  })
}

shinyApp(ui, server)
