#' Generate index.html to embedd Shiny app deploted at Hugging Face
#'
#' @param username username at Hugging Face
#' @param space name of space at Hugging Face
#' @param webtitle title of page (not a heading!)
#'
#' @importFrom htmltools tags HTML save_html
#'
#' @export
generate_hfspace_shiny_iframe <- function(
  username,
  space,
  webtitle = "It's so shiny~"
) {
  html <- htmltools::tags$html(
    htmltools::tags$head(
      htmltools::tags$meta(charset = "UTF-8"),
      htmltools::tags$meta(http_equiv = "X-UA-Compatible", content = "IE=edge"),
      htmltools::tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0"),
      htmltools::tags$title(webtitle),
      htmltools::tags$style(
        htmltools::HTML("
          html, body {
              height: 100%;
              margin: 0;
              padding: 0;
              overflow: hidden;
          }
          iframe {
              display: block;  /* Remove default margin of iframe */
              width: 100%;
              height: 100%;
              border: none;    /* Optional: remove default border around iframe */
          }
      ")
      )
    ),
    htmltools::tags$body(
      htmltools::tags$iframe(
        src = paste0("https://", username, "-", space, ".hf.space"),
        width = "100%",
        height = "100%",
        style = "border: none;"
      )
    )

  )

  htmltools::save_html(html, "index.html")

  return(html)
}
