# ChessMetrics: Quantifying My Board Battles

![alt text](https://github.com/Schlon24/ChessMetrics-Quantifying-My-Board-Battles/blob/b96a4b33a449278217449ee1d4d87a486b6d8dd3/ChessMetrics_%20Quantifying%20My%20Board%20Battles.png)

## Introduction

I've always had a thing for chess. I started playing when I was young but took a break at 14. Recently, with the surge in online chess popularity, I found myself drawn back to the board after 13 years. Now, as I immerse myself in online matches, I can't help but wonder: How am I doing? And more importantly, where can I improve?

To answer these questions, I turned to data. Specifically, I wanted to get a clear picture of my performance by examining my win rate. I decided to dig deep into the games I've played, analyzing everything from the openings I use to the days I play most frequently. This project covers the steps I took: from collecting and cleaning data in Python, analyzing my chess performance, to finally visualizing the results in a Tableau dashboard.

## Data Collection

### API Integration
I predominantly play my games on the two major chess platforms: Chess.com and Lichess. Consequently, my data extraction had to span both these platforms, with an end goal of merging the datasets for a comprehensive analysis.

1. Chess.com:
   - How: I used Chess.com's API. You can see the details in their [documentation](https://www.npmjs.com/package/chess-web-api#getplayercurrentdailychessusername-options-callback).
   - Data: The data I got was in JSON format. It gave me the basics about each game, but some details were trickier to extract.
2. Lichess:
   - How: For Lichess, I used the berserk library in Python. Check out how it works in its [documentation](https://berserk.readthedocs.io/en/master/usage.html#pgn-vs-jsonto).
   - Data: The data was also in JSON format. But compared to Chess.com, Lichess's data was more detailed, which was helpful for later analysis.

Having collected data from both platforms, the next step was to clean and organize it. More on that in the ETL section!

## ETL Process
Data collection was just the tip of the iceberg. The next phase involved cleaning, transforming, and structuring the data, ensuring it's ready for deeper analysis.

### Extract:
The initial data pull from both Chess.com and Lichess APIs returned a JSON response. This format is common for API calls, but it's not always the most straightforward to handle, especially when working towards analytical purposes.

### Transform:
I opted for Python's Pandas library to shape this data, converting the JSON responses into structured dataframes:

1. Lichess:
   - Transitioning from JSON to a dataframe was straightforward. The data was well-organized, with clear key-value pairs, making the transformation relatively smooth.
2. Chess.com:
   - The challenge here was a bit higher. While I could extract most fields directly, a few critical ones ('opening', 'moves', and 'date') were embedded within a lengthy string named 'pgn'. Extracting these required some hands-on regex magic. This step was complex, but it ensured that the Chess.com data matched the structure of Lichess data.

### Load:
Once the data was cleaned and transformed, I proceeded to store it in a local MySQL server. For this, I leveraged the pymysql package in Python, which facilitated a seamless transfer of data to the database. You can see the specifics of how I implemented this in the code.

## Feature Engineering
When diving into the data, I realized it wasn't immediately tailored to my gameplay. So, I got to work tweaking the data to reflect my experience on the chessboard.

### Making the Data My Own:
1. Lichess Data:
   - I pulled out columns like date, opening, and variation. I also added a played_white column to see when I was the white player.
   - I focused on rated games, as they matter most for tracking progress.
2. Chess.com Data:
   - I did similar tasks: getting the date, opening, and variation columns in shape.
   - Using the white_username column, I determined when I played as white.
3. Bringing Both Together:
   - I merged the data from Lichess and Chess.com.
   - I added an outcome column to easily see if I won, lost, or drew, making sure it reflected my perspective in each game.

## Visualization with Tableau
After processing and refining my chess data, it was time to visualize it. Tableau was my tool of choice, allowing me to create a comprehensive dashboard.

### Dashboard Breakdown:
1. Key Metrics Tiles:
   - **Topmost Display:** Three tiles prominently show 'Games Played', 'Win Rate', and 'Top Weekly Rating Points'.
   - **Time Period Display:** Below each metric is a comparison: the current period versus the previous one. This dynamic comparison updates based on the period selected, be it daily, weekly, monthly, or annually.
   - **Bar Chart:** Just beneath, there's a bar chart that visualizes data for four additional periods, giving me a broader view of my progress over time.
2. Insightful Stats:
   - **Streaks and Records:** This section delves into some interesting personal records: my longest win streak, the day I played the most games, and insights into my best and worst weekdays in terms of win rate.
   - **Openings Performance:** Right next to the stats, there's a horizontal bar chart showcasing the top 10 openings I've played, sorted by win rate. This helps identify which openings have been working in my favor and which might need rethinking.

This Tableau dashboard offers both a macro overview and granular insights into my performance, growth, and areas of opportunity in my chess adventures. For a closer look at the dashboard, feel free to check it out [here](https://public.tableau.com/views/ChessMetricsQuantifyingMyBoardBattles/ChessMetricsQuantifyingMyBoardBattles?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link).
