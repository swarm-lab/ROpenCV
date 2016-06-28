#' @title OpenCV version
#'
#' @description Determines the version of OpenCV installed within R.
#'
#' @return A character string with the version of OpenCV installed by
#'  \code{\link{ROpenCV}}.
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @export
opencvVersion <- function() {
  pkgPath <- find.package("ROpenCV")
  pcPath <- "/opencv/lib/pkgconfig/opencv.pc"
  pc <- read.table(paste0(pkgPath, pcPath), sep = "\t")$V1
  as.character(pc[grepl("Version", pc)])
}


#' @title C/C++ configuration options
#'
#' @description Determines the configuration options for compiling C/C++-based
#'  packages against OpenCV installed by \code{\link{ROpenCV}}.
#'
#' @param output Either 'libs' for library configuration options or 'cflags' for
#'  C/C++ configuration flags.
#'
#' @return A concatenated character string (with \code{\link{cat}}) of the
#'  configuration options.
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @export
opencvConfig <- function(output = "libs") {
  pkgPath <- find.package("ROpenCV")
  prefix <- paste0(pkgPath, "/opencv")

  if (output == "libs") {
    execPrefix <- prefix
    libDir <- paste0(execPrefix, "/lib")
    pcPath <- "/opencv/lib/pkgconfig/opencv.pc"
    pc <- read.table(paste0(pkgPath, pcPath), sep = "\t")$V1
    libs <- gsub(".*\\/lib ", "", as.character(pc[grepl("Libs:", pc)]))
    cat(paste0("-L", libDir, " ", libs))
  } else if (output == "cflags") {
    includedirOld <- paste0(prefix, "/include/opencv")
    includedirNew <- paste0(prefix, "/include")
    cat(paste0("-I", includedirOld, " -I", includedirNew))
  } else {
    stop("output should be either 'libs' or 'cflags'")
  }
}
