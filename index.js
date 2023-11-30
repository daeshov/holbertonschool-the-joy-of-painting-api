const fs = require('fs');
const csv = require('csv-parser');


const processCSV = (filePath, hasHeaders) => {
  const data = [];

  fs.createReadStream(filePath)
    .pipe(csv({ headers: hasHeaders }))
    .on('data', (row) => {
      // Process each row and extract into multiple columns
      const title = String(row[0]).replace(/\([^)]*\)/, '').trim();
      const date = /\((.*?)\)/.exec(row[0]);
      const formattedDate = date ? date[1] : '';
      const paint_index = row.painting_index.trim();

      data.push({
        title: title,
        date: formattedDate.trim(),
        paint_index: paint_index,
      });
    })
    .on('end', () => {
      // After reading all data
      console.log(data);
      // Perform further processing or insert into the database here
    });
};

processCSV('datasets/The Joy Of Painting - Episode Dates.csv', false);
processCSV('datasets/The Joy Of Painting - Colors Used.csv', true)
