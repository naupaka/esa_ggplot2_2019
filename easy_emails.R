roster     <- read.csv("/Users/atredenn/Desktop/roster.csv")
emails     <- as.character(roster$Email)
email_list <- paste(emails, collapse = ",")
print(email_list)
