#' Visualize
#'
#' @param df \code{data.frame} with input data
#' @return plotly object
#' @import plotly
#' @export
#' @examples
#' library("ratan")
#' df <- computeRatios(
#'     as.data.frame(Titanic),
#'     "Class",
#'     c("Sex", "Age", "Survived"),
#'     "Freq")
#' visualize(df)
visualize <- function(df) {

  p <- plot_ly(
    x = (colnames(df)),
    y = (rownames(df)),
    z = data.matrix(df[ nrow(df):1, ]),
    type = "heatmap",
    colorscale = "Greys",
    width=1700,
    height=900
  ) %>%
    layout(
      margin=list(
        l=120,
        r=10,
        b=500,
        t=10
      ),
      xaxis=list(
        showticklabels=TRUE,
        tickangle=90,
        tickfont=list(
          family='Old Standard TT, serif',
          size=9
        )
      ),
      yaxis=list(
        autorange='reversed',
        showticklabels=TRUE,
        tickfont=list(
          family='Old Standard TT, serif',
          size=10,
          color='black'
        )
      )
    )
  p
}
