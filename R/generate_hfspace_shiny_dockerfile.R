#' Generate Shiny Dockerfile for Hugging Face
#'
#' @param base base image
#' @param cran_pkgs_name vector of package names required by your Shiny app
#' @param gh_pkgs_repo vector of dev package hosted in GitHub required by your Shiny app
#' @param port exposed port in dockerfile
#'
#' @import dockerfiler
#'
#' @export
generate_hfspace_shiny_dockerfile <- function(
    base = "rocker/r2u:22.04",
    cran_pkgs_name,
    gh_pkgs_repo = NULL,
    port = 7860
) {
  dock <- dockerfiler::Dockerfile$new(FROM = base)
  dock$WORKDIR("/code")
  dock$RUN(
    paste(
      "install2.r --error --skipinstalled --ncpus -1",
      paste(unique(cran_pkgs_name), collapse = " ")
    )
  )
  dock$RUN(
    paste(
      "installGithub.r",
      paste(unique(c("rstudio/httpuv", gh_pkgs_repo)), collapse = " ")
    )
  )
  dock$COPY(".", ".")
  dock$CMD(
    paste0(
      "R -e 'shiny::runApp(host = \"0.0.0.0\", port = ",
      port,
      ")'"
    )
  )

  dock$write()

  return(dock)
}
