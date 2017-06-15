#' load a Swirl course
#'
#' load a Swirl course. Courses can be
#' created as described here: http://swirlstats.com/instructors.html.
#'
#' @param directory path to directory of course to upload
#'
#' @details It returns the a data frame.
#'
#' @import dplyr
#'
#' @export
load_course <- function(directory) {
  if (!file.exists(directory)) {
    stop("Directory ", directory, "not found")
  }

  # retrieve the current username as well
  # username <- parse_current_user()$username
  username <- "FSI2017"

  course_name <- basename(directory)
  course_title <- gsub("_", " ", course_name)

  ## add Exercise objects to database
  full_batched <- NULL
  lesson_dirs <- list.files(directory, full.names = TRUE, include.dirs = TRUE)

  if (length(lesson_dirs) == 0) {
    stop("No lessons found in course")
  }

  for (lesson_dir in lesson_dirs) {
    yaml_file <- file.path(lesson_dir, "lesson.yaml")
    if (!file.exists(yaml_file)) {
      stop("lesson.yaml not found in ", lesson_dir)
    }
    y <- yaml::yaml.load_file(yaml_file)

    # batched <- dplyr::rbind_all(lapply(y[-1], as.data.frame, stringsAsFactors = FALSE))
    batched <- dplyr::bind_rows(lapply(y[-1], as.data.frame, stringsAsFactors = FALSE))

    batched <- batched %>%
      mutate(exercise = seq_len(n()),
             lesson = gsub("_", " ", basename(lesson_dir)))

    full_batched <- rbind(batched, full_batched)
  }

  full_batched <- dplyr::transmute(full_batched,
                                   course = course_title,
                                   lesson = lesson,
                                   exercise = exercise,
                                   instructor = username,
                                   prompt = Output,
                                   answer = as.character(CorrectAnswer),
                                   hint = Hint)

  return(full_batched)
  # Fixes issue of full lesson paths uploaded to zip
  wd <- getwd()
  setwd(dirname(directory)) #Go to top level directory

  # Return to the original directory
  setwd(wd)

  invisible()
}

#' load all Swirl courses
#'
#' load all Swirl courses. Courses can be
#' created as described here: http://swirlstats.com/instructors.html.
#'
#' @param directory path to directory where all the subdirectories are course directories
#'
#' @details It returns a combined data frame for all courses
#'
#' @import dplyr
#'
#' @export
load_all_courses <- function(directory) {
  # load_all_courses("/Users/hubertj/Desktop/NewProject/SocraticSwirl/socraticswirlInstructor-2016pol345/courses/qss-swirl-socraticswirl")
  all_courses <- NULL
  for (i in list.dirs(path = directory, full.names = TRUE, recursive = FALSE)) {
    # print(paste("Process course:", i))
    all_courses <- rbind(all_courses, load_course(i))
  }
  return(all_courses)
}

#' load all Swirl courses
#'
#' @param file that stores the merged records
#'
#' @details It returns a combined data frame for the merged
#'
#' @import dplyr
#'
#' @export
load_student_list <- function(file) {
  # read.csv("../../Records/studentList.tsv", header=TRUE, sep="\t")
  f <- read.csv(file, header=TRUE, sep="\t", stringsAsFactors=FALSE)
  if (!is.null(f$createdAt))  {
    f$createdAt <- as.POSIXct(strptime(f$createdAt,format='%a %b %d %H:%M:%S %Y'))
    f$updatedAt <- f$createdAt
  }
  if (!is.null(f$exercise)) f$exercise <- as.numeric(f$exercise)
  return(f)
}


# a0 <- load_all_courses("/Users/hubertj/Desktop/NewProject/SocraticSwirl/socraticswirlInstructor-2016pol345/courses/qss-swirl-socraticswirl")
# a1 <- load_student_list("/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records/studentList.tsv")
# a2 <- load_student_list("/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records/studentQuestion.tsv")
# a3 <- load_student_list("/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records/studentSession.tsv")
# a4 <- load_student_list("/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records/studentResponse.tsv")




