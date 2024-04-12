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

// fetch list of games
app.get('/api/arqs/games', (req, res) => {
    connection.query('SELECT GID, Name FROM games WHERE Published = \'yes\'', (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving game data from database.');
        } else {
            res.status(200).json(results);
        }
    });
  });

// fetch a game's outer map
// MID31276066781703927429343
app.get('/api/arqs/map/:mapId', (req, res) => {
    const mapId = req.params.mapId;

    const query = `
        SELECT m.MID, m.Name, M.Tile_Data, M.Locations
        FROM map m 
        WHERE MID = ?
    `;

    connection.query(query, [mapId], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving game data from database.');
        } else {
            res.status(200).json(results);
        }
    });
});

// fetch location info
app.get('/api/arqs/map/location/:locId', (req, res) => {
    const locId = req.params.locId;

    const query = `
        SELECT *
        FROM locations 
        WHERE LID = ?
    `;

    connection.query(query, [locId], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving game data from database.');
        } else {
            res.status(200).json(results);
        }
    });
});

// fetch room data
app.get('/api/arqs/locations/area/:areaId', (req, res) => {
    const areaId = req.params.areaId;

    const query = `
        SELECT a.AID, a.Name, a.Type, a.Tile_Data, a.Objects, a.Connectors, ll.Level, l.Player_Start_Point
        FROM areas a
        JOIN location_levels ll ON a.LLID = ll.LLID
        JOIN locations l ON ll.LID = l.LID
        WHERE a.AID = ?
    `;

    connection.query(query, [areaId], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving level data from database.');
        } else {
            res.status(200).json(results);
        }
    })
})

// fetch quest data
app.get('/api/arqs/game/quest/:gameId', (req, res) => {
    const gameId = req.params.gameId;

    const query = `
        SELECT q.QID, q.Name, q.Scenario, q.Actions, q.Json, q.Active 
        FROM quests q 
        JOIN games_quests gq on q.QID = gq.QID
        WHERE gq.GID = ?
    `;

    connection.query(query, [gameId], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving quest data from database.');
        } else {
            res.status(200).json(results);
        }
    })
})

// fetch NPC data
app.get('/api/arqs/game/character/:npcId', (req, res) => {
    const npcId = req.params.npcId;

    const query = `
        SELECT n.NPCID, n.Name, n.Background, n.Visuals 
        FROM npc n 
        WHERE n.NPCID = ?
    `;

    connection.query(query, [npcId], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving NPC data from database.');
        } else {
            res.status(200).json(results);
        }
    })
})

// fetch items data
app.get('/api/arqs/game/item/:itemId', (req, res) => {
    const itemId = req.params.itemId;

    const query = `
        SELECT i.IID, i.Name, i.Description, i.Link, i.Readable, i.Destroyable, i.Content
        FROM items i 
        WHERE i.IID = ?
    `;

    connection.query(query, [itemId], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving NPC data from database.');
        } else {
            res.status(200).json(results);
        }
    })
})

app.listen(3000, () => {
    console.log('Server started on port 3000');
});