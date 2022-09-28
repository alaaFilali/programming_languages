# Read the .csv file and store it in a DataFrame called df
df <- read_csv('QueryResults.csv', col_names = c('DATE', 'TAG', 'POSTS'))
df<- df[-1,]


# Look at the first and last 5 rows of the DataFrame
head(df)


# How many rows and how many columns does it have?
nrow(df)
ncol(df)


# Count the number of entries in each column
df %>% 
  count()


# Which programming language had the most number of 
# posts since the creation of Stack Overflow?
data <- df %>% 
  group_by(TAG) %>% 
  summarise(number_of_posts = sum(POSTS))

data[order(data$number_of_posts, decreasing = TRUE),]


# how many months of posts exist for each programming language?
df %>% 
  group_by(TAG) %>% 
  count() 


# Inspecting the Data Type of the DATE column
typeof(df$DATE)


# convert the string to a timestamp
df$DATE <- as.POSIXct(df$DATE, format="%Y-%m-%d")


# pivot the df DataFrame
reshaped_df <- df %>% pivot_wider(names_from = 'TAG', values_from = 'POSTS')


# Examine the dimensions of the reshaped DataFrame
nrow(reshaped_df)
ncol(reshaped_df)


# Examine the head and the tail of the DataFrame
head(reshaped_df)
tail(reshaped_df)


# Print out the column names
colnames(reshaped_df)


# Count the number of entries per column
result <- data.frame(
  Results = names(reshaped_df),
  Totals = sapply(reshaped_df, function(x) length(grep(".", x)))
)
rownames(result) <- NULL


# Dealing with NaN Values
reshaped_df[is.na(reshaped_df)] <- 0


# check if there are any NaN values left in the entire DataFrame
colSums(is.na(reshaped_df))


# show a line chart for the popularity of a programming language
ggplot(reshaped_df) + geom_line(aes(x=DATE, y=java))


# plot all the programming languages on the same chart?
df %>% 
  ggplot() + geom_line(aes(DATE, POSTS, color=TAG)) 
