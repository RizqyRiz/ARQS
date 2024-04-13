const express = require('express');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const bodyParser = require('body-parser');

const connection = mysql.createConnection({
    host: '34.29.245.234',
    user: 'user',
    password: 'test@123',
    database: 'arqs'
    port: '3306'
});

connection.connect((err) => {
    if (err) {
        console.error('Error connecting to database: ', err);
    } else {
        console.log('Connected to database!');
    }
});

const app = express();

app.use(bodyParser.json());

// login user
app.post('/api/arqs/login', async (req, res) => {
    const { username, password } = req.body;

    connection.query('SELECT * FROM users WHERE Username = ?', [username], (error, results) => {
      if (error) {
        console.error('Error fetching user from database:', error);
        return res.status(500).json({ message: 'Internal server error' });
      }
  
      // check if user exists
      if (results.length === 0) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      const user = results[0];

      // fix compare() error
      const hashPass = /^\$2y\$/.test(user.Pass) ? '$2a$' + user.Pass.slice(4) : user.Pass;
  
      // compare hashed password
      bcrypt.compare(password, hashPass, (err, match) => {
        if (err) {
          console.error('Error during password comparison:', err);
          return res.status(500).json({ message: 'Internal server error' });
        }

        console.log('Hashed password:', hashPass);
        console.log('Password being compared:', password);
        
        if (match) {
          res.status(200).json(user);
        } else {
          res.status(401).json({ message: 'Invalid credentials' });
        }
      });
    });
});

// fetch list of games
app.get('/api/arqs/games', (req, res) => {

    const query = `
        select g.GID, Name, FirstName, SecondName 
        from games g 
        join usergames ug on ug.GID = g.GID 
        join users u on u.UserID = ug.UserID 
        where ug.deleted = "no" and g.Published = "yes"
    `;
    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving game data from database.');
        } else {
            res.status(200).json(results);
        }
    });
});

// fetch a specific game data
app.get('/api/arqs/game/:GID', (req, res) => {
    const GID = req.params.GID;

    const query = `
        select GID, Name, Lesson, Learningoutcomes, Player 
        from games g 
        where GID = ?
    `;

    connection.query(query, [GID], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving game data from database.');
        } else {
            res.status(200).json(results);
        }
    });
});

// fetch a game's outer map
app.get('/api/arqs/map/:GID', (req, res) => {
    const GID = req.params.GID;

    const query = `
        select m.MID, m.Name, m.Tile_Data, m.Locations
        from map m 
        join games_map gm on gm.MID = m.MID 
        join games g on g.GID = gm.GID 
        where g.GID = ?
    `;

    connection.query(query, [GID], (err, results) => {
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
        SELECT q.QID, q.Name, q.Scenario, q.Actions, q.Json, q.Active, gq.QOrder 
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

// fetch props data
app.get('/api/arqs/game/prop/:propId', (req, res) => {
    const propId = req.params.propId;

    const query = `
        SELECT o.OID, o.Name, o.Description 
        FROM objects o 
        WHERE o.OID = ?
    `;

    connection.query(query, [propId], (err, results) => {
        if (err) {
            console.error('Error retrieving data: ', err);
            res.status(500).send('Error retrieving NPC data from database.');
        } else {
            res.status(200).json(results);
        }
    })
})

app.all('/', (req, res) => {
    console.log("Just got a request!")
    res.send('Yo!')
})

app.listen(3306, () => {
    console.log('Yo!');
});