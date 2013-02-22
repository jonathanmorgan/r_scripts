# Load mysql library
library( RMySQL )

# open a connection to a MySQL database
my_db_name <- '<database_name>'
my_db_username <- '<username>'
my_db_password <- '<password>'

con <- dbConnect( dbDriver( "MySQL" ), dbname = my_db_name, username = my_db_username, password = my_db_password )

# try just getting a count of rows.
dbGetQuery( con, "SELECT COUNT( * ) FROM news_tweets" )

# OK.  That worked.  Now, try pulling in whole table.
tweet_df <- dbGetQuery( con, "SELECT * FROM news_tweets" )

# output column names (they are the same as column names in database).
colnames( tweet_df )

# try describing the columns.
#summary( tweet_df$id )
#summary( tweet_df$tweet_timestamp )
#summary( tweet_df$twitter_user_id )

summary( tweet_df$tweet_retweet_count )

summary( tweet_df$user_follower_count )

hist( tweet_df$user_favorites_count )

#summary( tweet_df$user_created )
#summary( tweet_df$tweet_users_mentioned )
#summary( tweet_df$tweet_full_URLs_mentioned )
#summary( tweet_df$tweet_text )
#summary( tweet_df$outlet_twitter_user )

# More descriptives from Quick-R: http://www.statmethods.net/stats/descriptives.html
# - Using tweet_retweet_count as example.

# Install and load Hmisc package
install.packages( "Hmisc" )
library( Hmisc )

# describe a column.
describe( tweet_df$tweet_retweet_count )

# tweet_df$tweet_retweet_count 

# Install and load pastecs package.
install.packages( "pastecs" )
library( pastecs )

# do this describe
stat.desc( tweet_df$tweet_retweet_count )

# Install and load psych
install.packages( "psych" )
library( psych )

# and this one - looks like latest package loaded wins when there are name collisions.
describe( tweet_df$tweet_retweet_count )

#   var       n  mean     sd median trimmed mad min   max range  skew

# log transform?

# always close the connection when you are done.
dbDisconnect( con )

# set working directory
# setwd( "<path_to_working_directory>" )

# try outputting dataframe so SPSS can import it.
write.foreign( tweet_df, "news_tweets.txt", "news_tweets.sps",  package="SPSS" )

# broke because of column names being longer than 8 characters...

# get number of rows in the data frame
nrow( tweet_df )

# save off the data set
# setwd( "<path_to_save_directory>" )
saveRDS( tweet_df, file = "news_tweets.rds" )

# load the data set
tweet_df <- readRDS( file = "news_tweets.rds" )