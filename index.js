const fs = require('fs').promises;
const sqlite3 = require('sqlite3').verbose();
const csv = require('csv-parser');
const path = require('path');

// Connect to the SQLite database
const db = new sqlite3.Database('./sql_server/joy_of_painting_series.db');

async function insertDataFromCSV(table, csvFileName) {
  const csvFilePath = path.join(__dirname, 'datasets', `${csvFileName}.csv`);

  try {
    // Read CSV data
    const data = await fs.readFile(csvFilePath, 'utf8');
    const rows = data.trim().split('\n').map(row => row.split(','));

    // Insert data into the database
    const columns = rows[0].map(col => `"${col.replace(/"/g, '')}"`).join(', ');
    const placeholders = rows[0].map(() => '?').join(', ');
    const sql = `INSERT INTO ${table} (${columns}) VALUES (${placeholders})`;

    console.log('Generated SQL query:', sql);

    db.serialize(() => {
      const stmt = db.prepare(sql);

      rows.slice(1).forEach(row => {
        stmt.run(row);
      });

      stmt.finalize();
    });

    console.log(`Data inserted into ${table} from ${csvFilePath}`);
  } catch (error) {
    console.error(`Error reading or inserting data for ${table}: ${error.message}`);
  }
}

async function main() {
  // Insert data into episodes table
  await insertDataFromCSV('episodes', 'The Joy Of Painting - Episode Dates');

  // Insert data into colors table
  await insertDataFromCSV('colors', 'The Joy Of Painting - Colors Used');

  // Insert data into subject_matters table
  await insertDataFromCSV('subject_matters', 'The Joy Of Painting - Subject Matter');

  // Close the database connection after all operations have finished
  db.close((err) => {
    if (err) {
      console.error(`Error closing the database connection: ${err.message}`);
    } else {
      console.log('All operations completed. Database connection closed.');
    }
  });
}

// Call the main function
main();
