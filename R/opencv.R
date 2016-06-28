#' @export
opencvVersion <- function() {
  pkgPath <- find.package("ROpenCV")
  pcPath <- "/opencv/lib/pkgconfig/opencv.pc"
  pc <- read.table(paste0(pkgPath, pcPath), sep = "\t")$V1
  as.character(pc[grepl("Version", pc)])
}


#' @export
opencvConfig <- function(output = "libs") {
  pkgPath <- find.package("ROpenCV")
  pcPath <- "/opencv/lib/pkgconfig/opencv.pc"
  pc <- read.table(paste0(pkgPath, pcPath), sep = "\t")$V1

  prefix <- paste0(pkgPath, "/opencv")
  execPrefix <- prefix
  libDir <- paste0(execPrefix, "/lib")
  includedirOld <- paste0(prefix, "/include/opencv")
  includedirNew <- paste0(prefix, "/include")

  if (output == "libs") {
    paste0("-L", libDir, " -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_dnn -lopencv_dpm -lopencv_fuzzy -lopencv_line_descriptor -lopencv_optflow -lopencv_plot -lopencv_reg -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_rgbd -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_text -lopencv_face -lopencv_xfeatures2d -lopencv_shape -lopencv_video -lopencv_ximgproc -lopencv_calib3d -lopencv_features2d -lopencv_flann -lopencv_xobjdetect -lopencv_objdetect -lopencv_ml -lopencv_xphoto -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_photo -lopencv_imgproc -lopencv_core")
  } else if (output == "cflags") {
    paste0("-I", includedirOld, " -I", includedirNew)
  } else {
    stop("output should be either 'libs' or 'cflags'")
  }
}



