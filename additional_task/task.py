from selenium import webdriver
from selenium.webdriver.common.by import By
import requests
from bs4 import BeautifulSoup
import pandas as pd
import time
from selenium.webdriver.chrome.options import Options

# List of clubs and their Sofascore URLs
clubs = {
    'Real Madrid': 'https://www.sofascore.com/team/football/real-madrid/2829',
    'Barcelona': 'https://www.sofascore.com/team/football/barcelona/2817',
    'Arsenal': 'https://www.sofascore.com/team/football/arsenal/42',
    'Liverpool': 'https://www.sofascore.com/team/football/liverpool/44',
    'Manchester city': 'https://www.sofascore.com/team/football/manchester-city/17',
    'Manchester united': 'https://www.sofascore.com/team/football/manchester-united/35',
    'Internazionale': 'https://www.sofascore.com/team/football/inter/2697',
    'Chelsea': 'https://www.sofascore.com/team/football/chelsea/38',
    'Milan': 'https://www.sofascore.com/team/football/milan/2692',
    'Bayern Munchen': 'https://www.sofascore.com/team/football/fc-bayern-munchen/2672'
}

def scrape_match_data(club_name):
    club_url = clubs[club_name]
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)

    driver.get(club_url)
    time.sleep(5) 

    try:
        matches_tab = driver.find_element(By.LINK_TEXT, "Matches")
        matches_tab.click()
        time.sleep(3)
    except:
        print("Couldn't find Matches tab")

    for _ in range(3):  # Adjust to load enough matches
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(2)

    matches = driver.find_elements(By.CSS_SELECTOR, "div.eventRow__match")  # Example selector
    results = []

    for match in matches[:20]:
        try:
            teams = match.find_element(By.CSS_SELECTOR, "div.eventRow__participants").text
            score = match.find_element(By.CSS_SELECTOR, "div.eventRow__score").text
            date = match.find_element(By.CSS_SELECTOR, "div.eventRow__date").text
            results.append([date, teams, score])
        except:
            continue

    driver.quit()

    df = pd.DataFrame(results, columns=["Date", "Match", "Score"])
    print(df)

    # Use requests and BeautifulSoup to fetch and parse the data
    # Extract last 20 matches, goal scorers, goals scored/conceded
    # Extract league position and points
    pass

# Main loop to iterate over clubs
for club_name, club_url in clubs.items():
    print(f"Scraping data for {club_name}")
    scrape_match_data(club_name, club_url)
    time.sleep(2)  # Delay between requests

# After scraping, compile data into a DataFrame and export as needed

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time
import pandas as pd

# Club names and their Sofascore URLs
clubs = {
    'Real Madrid': 'https://www.sofascore.com/team/football/real-madrid/2829',
    'Barcelona': 'https://www.sofascore.com/team/football/barcelona/2817',
    'Arsenal': 'https://www.sofascore.com/team/football/arsenal/42',
    'Liverpool': 'https://www.sofascore.com/team/football/liverpool/44',
    'Manchester city': 'https://www.sofascore.com/team/football/manchester-city/17',
    'Manchester united': 'https://www.sofascore.com/team/football/manchester-united/35',
    'Internazionale': 'https://www.sofascore.com/team/football/inter/2697',
    'Chelsea': 'https://www.sofascore.com/team/football/chelsea/38',
    'Milan': 'https://www.sofascore.com/team/football/milan/2692',
    'Bayern Munchen': 'https://www.sofascore.com/team/football/fc-bayern-munchen/2672'
}

options = Options()
options.add_argument('--headless')
options.add_argument('--disable-gpu')
driver = webdriver.Chrome(options=options)

def scrape_team_matches(team_name, team_url):
    driver.get(team_url)
    time.sleep(5)

    try:
        matches_tab = driver.find_element(By.LINK_TEXT, 'Matches')
        matches_tab.click()
        time.sleep(5)
    except Exception as e:
        print(f"[{team_name}] Could not open Matches tab: {e}")
        return []

    # Scroll to load more matches
    for _ in range(3):
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(2)

    matches = driver.find_elements(By.CSS_SELECTOR, 'div.eventRow__match')
    match_data = []

    for match in matches[:20]: 
        try:
            date = match.find_element(By.CSS_SELECTOR, 'div.eventRow__date').text
            teams = match.find_element(By.CSS_SELECTOR, 'div.eventRow__participants').text
            score = match.find_element(By.CSS_SELECTOR, 'div.eventRow__score').text

            # Parse score
            if score and "-" in score:
                home_goals, away_goals = map(int, score.split('-'))
                is_home = team_name.lower() in teams.split(' - ')[0].lower()
                goals_for = home_goals if is_home else away_goals
                goals_against = away_goals if is_home else home_goals
            else:
                goals_for = goals_against = None

            match_data.append({
                'Club': team_name,
                'Date': date,
                'Opponent': teams,
                'Score': score,
                'Goals For': goals_for,
                'Goals Against': goals_against
            })
        except Exception as e:
            print(f"[{team_name}] Error extracting match: {e}")
            continue

    return match_data

all_matches = []

for club, url in clubs.items():
    print(f"Scraping {club}...")
    data = scrape_team_matches(club, url)
    all_matches.extend(data)
    time.sleep(2)

driver.quit()

# Save to CSV
df = pd.DataFrame(all_matches)
df.to_csv("club_last_20_matches.csv", index=False)
print("\n Data saved to 'club_last_20_matches.csv'")
