const mysql = require('mysql');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'arqs'
});

connection.connect((err) => {
    if (err) {
        console.error('Error connecting to database: ', err);
    } else {
        console.log('Connected to database!');
    }
});


const express = require('express');
const app = express();

app.get('/games', (req, res) => {
    connection.query('SELECT GID, Name FROM games', (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving game data from database.');
        } else {
            res.status(200).json(results);
        }
    });
  });

app.get('/map', (req, res) => {
connection.query('SELECT * FROM map', (err, results) => {
    if (err) {
        console.error('Error retrieving data: ', err);
        res.status(500).send('Error retrieving game data from database.');
    } else {
        res.status(200).json(results);
    }
});
});


app.listen(3000, () => {
    console.log('Server started on port 3000');
});
