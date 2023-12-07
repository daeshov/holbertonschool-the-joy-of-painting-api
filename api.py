from flask import Flask, jsonify
from sqlalchemy import create_engine
from index import process_csv

app = Flask(__name__)

# Database connection
engine = create_engine("mysql+pymysql://root@localhost/joy_of_painting_api")


# Route to get the data
@app.route('/', methods=['GET'])
def get_data():
    file_paths = [
        'datasets/The Joy Of Painting - Episode Dates',
        'datasets/The Joy Of Painting - Colors Used.csv',
        'datasets/The Joy Of Painting - Subject Matter.csv'
    ]
    has_headers = [False, True, True]
    result = []

    for i, file_path in enumerate(file_paths):
        result.extend(process_csv(file_path, has_headers[i]))

    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
