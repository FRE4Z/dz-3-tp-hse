import csv
import random
import os
import sys

NUM_ROWS = 50

COLUMNS = ["id", "avg_headshots_map", "matches_played", "team"]

def generate_row():
    teams = ["NAVI", "FaZe", "G2", "Vitality", "Spirit"]
    return {
        "id": random.randint(1, 100),
        "avg_headshots_map": round(random.uniform(0.5, 15.0), 2),
        "matches_played": random.randint(0, 100),
        "team": random.choice(teams),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)

print(f"Generated {NUM_ROWS} rows to {OUTPUT_FILE}")
