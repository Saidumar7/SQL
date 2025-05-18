import requests
from bs4 import BeautifulSoup, Comment
import pandas as pd
import time

# Dictionary of 10 elite football clubs and their corresponding fbref URLs
teams = {
    "Manchester City": "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats",
    "Real Madrid": "https://fbref.com/en/squads/53a2f082/Real-Madrid-Stats",
    "Barcelona": "https://fbref.com/en/squads/206d90db/Barcelona-Stats",
    "Bayern Munich": "https://fbref.com/en/squads/054efa67/Bayern-Munich-Stats",
    "Liverpool": "https://fbref.com/en/squads/822bd0ba/Liverpool-Stats",
    "Arsenal": "https://fbref.com/en/squads/18bb7c10/Arsenal-Stats",
    "Juventus": "https://fbref.com/en/squads/e0652b02/Juventus-Stats",
    "PSG": "https://fbref.com/en/squads/361ca564/Paris-Saint-Germain-Stats",
    "Inter Milan": "https://fbref.com/en/squads/d609edc0/Internazionale-Stats",
    "AC Milan": "https://fbref.com/en/squads/dc56fe14/Milan-Stats"
}

def get_season_url(team_url):
    response = requests.get(team_url)
    soup = BeautifulSoup(response.text, "html.parser")
    for a in soup.select("a[href]"):
        if "/squads/" in a["href"] and "/matchlogs/" not in a["href"] and "Stats" in a["href"]:
            return "https://fbref.com" + a["href"]
    return None

def get_team_players(team, season_url):
    try:
        response = requests.get(season_url)
        soup = BeautifulSoup(response.text, "html.parser")

        comments = soup.find_all(string=lambda text: isinstance(text, Comment))
        for comment in comments:
            comment_soup = BeautifulSoup(comment, "html.parser")
            table = comment_soup.find("table", {"id": "stats_standard"})
            if table:
                df = pd.read_html(str(table))[0]
                df["Team"] = team
                return df
        print(f"⚠️ Squad table not found for {team}")
        return None
    except Exception as e:
        print(f"❌ Error scraping {team}: {e}")
        return None

# Main function
def main():
    all_data = []

    for team, url in teams.items():
        print(f"\n🔍 Scraping {team}...")
        season_url = get_season_url(url)
        if season_url:
            df = get_team_players(team, season_url)
            if df is not None:
                all_data.append(df)
        else:
            print(f"❌ Could not find season URL for {team}")
        time.sleep(2)  # Avoid hammering the server

    if all_data:
        final_df = pd.concat(all_data, ignore_index=True)
        final_df.to_csv("top_10_clubs_players.csv", index=False)
        print("\n✅ Data saved to top_10_clubs_players.csv")
    else:
        print("⚠️ No data to save.")

main()
