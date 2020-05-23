This repository contains the replication materials for **Us v.s. Them in 280 Characters - Why Political Polarization Fuels Vicious Attacks on Twitter** by **Blarry Wang**.

## Setup
- Operating System: macOS 10.14.4 (Mojave)
- Python Version: 3.7.4
- R Version: 3.6.1

### Required Python Packages
- pandas
- pyreadstat
- numpy
- scipy
- nltk
- tqdm
- matplotlib
- seaborn
- sklearn
- tweepy
- selenium
- pywikibot
- mwparserfromhell

### Required R Packages
- ggplot2
- dplyr
- lindia
- lsr

### Notes
Python scraping may take a while, please be patient.

## Instructions
### Step 1: Getting the Candidate Information
- You can ignore this step if you decide to use the finished data file: `2014_us_gubernatorial_election_candidates_with_twitter_and_gender.jsonlist`.
- Run `scrape_candidates.py` to scrape candidate information from Wikipedia.
- Manually duplicate `2014_us_gubernatorial_election_candidates.jsonlist` under `data/race/` and rename it to `2014_us_gubernatorial_election_candidates_with_twitter_and_gender.jsonlist`; then add in data for fields `"twitter"` and `"gender"`.

### Step 2: Getting the Tweets
- Run `get_all_twitter_ids.py` to retrieve all tweet ids from candidates 3 months prior to the election. You can ignore this step if you wish to use the scraped tweet IDs `all_tweet_ids.json` under `data/tweets/`.
- Run `get_all_tweets_with_meta.py` to retrieve all tweet texts and metadata that are associated with the above IDs.
- The tweets are saved as `all_tweets_with_coding.json`,  `all_tweets_with_coding.csv`, and `all_tweets_with_meta_short.json` under `data/tweets/`.

### Step 3: Automatic Coding and Reproducing Full Dataset
- Run `Tweet Automatic Coding Pipeline.ipynb` to code the tweets with necessary attributes for analysis.
- Manually code policy tokens in `token_coding_init.csv` under `data/token_coding/` and save it as `token_coding.csv`. You can ignore this step by using the existing coded file.
- Run `Independent Variables.ipynb` to create an easy-to-read format for the independent variables.
- Run `Data Set Merge Pipeline.ipynb` to create the final dataset.
- The final dataset is saved as `final_dataset.csv` under `data/`.

### Step 4: Reproducing Analysis
- Run `Analysis.Rmd` to reproduce the models, figures, and tables.
- The final figures are saved under `figures/`.

### Step 5: Validation
- Run the "`Generate`" section in `Tweet Coding Quality Analysis.ipynb` to produce the files needed for validation.
- Manually code `sample_validation_init.csv` under `data/validation` and save it as `sample_validation.csv`. You can ignore this step by using the existing file,
- Run the "Validation" section in `Tweet Coding Quality Analysis.ipynb` to produce stats for the validation.

## Data
The `data/` directory contains the necessary data to replicate the analysis and analytical figures and tables in the paper.  Below, I describe each of the datasets in this directory. `final_dataset.csv` is the final dataset that is used for analysis.

### Polarization Measures
- `polarization/raw_data/Pew/`: this folder contains 2014 political polarization survey data. You can downloaded it from https://www.people-press.org/dataset/2014-political-polarization-survey/.
- `polarization/raw_data/Shor & McCarty/`: this folder contains the data for *Measuring American Legislatures* by Boris Shor and Nolan McCarty (`shor_mc.sta`). You can download it from https://americanlegislatures.com/data/.
- `polarization/processed_data/`: this folder contains the processed data from the raw data.

### Race Information
- `race/`: this folder contains the information about the 2014 Gubernatorial Elections.

### Tweets
- `tweets/`: this folder contains all the tweets and their metadata.

### Token Coding
- `token_coding/`: this folder contains the data for coding policy tokens.

### Validation
- `validation/`: this folder contains the data for validation.

### Demographics
- `demographics/`: this folder contain the demographics data for American Community Survey 2014 (`ACS2014_5yr.csv`). You can download it from https://www.census.gov/data.html.
