.onAttach <- function(...) {
  # For the instructor code for uploading courses, the keys are set socraticswirl-instructor.R.
  # For the dashboard running on the server, they are set here.

  # A First Course in Quantitative Social Science
  # Test database
  # Sys.setenv(PARSE_APPLICATION_ID = "TEST-KEY",
  #           PARSE_API_KEY = "TEST-KEY")
  # Production database
  # Sys.setenv(PARSE_APPLICATION_ID = "PROD-KEY",
  #            PARSE_API_KEY = "PROD-KEY")

  # Dima's demo database
  # Sys.setenv(PARSE_APPLICATION_ID = "C0pM75Sepnt5WhK6P6yhRA0TqVa6Xa3vqwZjpLfT",
             # PARSE_API_KEY = "HyXS1gEn6gf7gibjDJVWPYsnIoc0SXcp4mwohdmI")
}

.onLoad <- function(libname, pkgname) {
  rstudioserver <- list(
    Instructor = "FSI2017",
    # CourseFolder = "/usr/local/R/FSI2017/Courses/qss-swirl-pol345",
    # RecordFolder = "/usr/local/R/FSI2017/Records",
    CourseFolder = "/Users/hubertj/Desktop/NewProject/SocraticSwirl/socraticswirlInstructor-2016pol345/courses/qss-swirl-socraticswirl",
    RecordFolder = "/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records"
  )
  options(SocraticswirlInstructorRStudioServer = rstudioserver)

  invisible()
}
