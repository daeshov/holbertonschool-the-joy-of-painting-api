import csv
from sqlalchemy import create_engine
import re

engine = create_engine("mysql+pymysql://root@localhost/joy_of_painting_api")

def process_csv(file_path, has_headers):
    data = []

    with open(file_path, newline='') as csvfile:
        csv_reader = csv.reader(csvfile)

        # Skip headers if present
        if has_headers:
            headers = next(csv_reader)
        else:
            headers = None

        # the name of each header title
        paint_index_index = None
        ep_colors_index = None
        # Find the indices of 'paint_index' and 'ep_colors' columns
        if headers:
            for i, header in enumerate(headers):
                if 'painting_index' in header:
                    paint_index_index = i
                elif 'colors' in header:
                    ep_colors_index = i

        # Load Episode Dates into a dictionary based on title
        def titles_and_dates(file_path):
            titles_dates = {}
            with open(file_path, 'r') as title_date:
                for row in title_date:
                    match = re.match(r'"(.*)" \((.*)\)', row)
                    if match:
                        title = match.group(1)
                        date = match.group(2)
                        titles_dates[title] = date
            return titles_dates

        # Load Colors Used into a dictionary based on title
        colors_used = {}
        with open('datasets/The Joy Of Painting - Colors Used.csv', newline='') as colors_csv:
            colors_reader = csv.reader(colors_csv)
            colors_headers = next(colors_reader)
            for colors_row in colors_reader:
                if colors_row:
                    title = colors_row[3].strip('""')
                    colors = colors_row[9].strip('[]')
                    colors_used[title] = colors

        for row in csv_reader:
            if len(row) >= 4:
                # Process each row and extract into multiple columns
                title_with_date = row[3]
                paint_index = row[paint_index_index].strip() if paint_index_index is not None else None
                ep_colors = row[ep_colors_index].strip() if ep_colors_index is not None else None
                # Ensure better title matching by removing extra whitespaces and quotes
                cleaned_title = title_with_date.strip().replace('"', '')
                date = titles_and_dates(file_paths[0]).get(cleaned_title, '')
                colors = colors_used.get(cleaned_title, '')

                data.append({
                    'original_title': title_with_date,
                    'cleaned_title': cleaned_title,
                    'date': date,
                    'paint_index': paint_index,
                    'ep_colors': ep_colors,
                    'colors_used': colors,
                })
            else:
                print(f"Not enough elements: {row}")

    return data

file_paths = ['datasets/The Joy Of Painting - Episode Dates', 'datasets/The Joy Of Painting - Colors Used.csv', 'datasets/The Joy Of Painting - Subject Matter.csv']
has_headers = [False, True, True]
result = []

for i, file_path in enumerate(file_paths):
    result.extend(process_csv(file_path, has_headers[i]))

print(result)
