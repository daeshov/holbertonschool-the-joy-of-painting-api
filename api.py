from flask import Flask, jsonify
from sqlalchemy import create_engine
import csv

app = Flask(__name__)

# Database connection
engine = create_engine("mysql+pymysql://root@localhost/joy_of_painting_api")

def process_csv(file_path, has_headers):
    # Your existing process_csv function

# Route to get the data
    @app.route('/api/data', methods=['GET'])
    def get_data():
        file_paths = ['datasets/The Joy Of Painting - Episode Dates.csv', 'datasets/The Joy Of Painting - Colors Used.csv', 'datasets/The Joy Of Painting - Subject Matter.csv']
        has_headers = [False, True, True]
        result = []

        for i, file_path in enumerate(file_paths):
            result.extend(process_csv(file_path, has_headers[i]))

        return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
