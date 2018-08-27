roster     <- read.csv("/Users/naupaka/Desktop/AM18_WK-9_(2018.0801).csv", skip = 2)
emails     <- as.character(roster$Email)
email_list <- paste(emails, collapse = ",")
print(email_list)
