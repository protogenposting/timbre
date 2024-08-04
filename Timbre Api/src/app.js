const databaseName='app.db'

const db = require('better-sqlite3')(databaseName);
const express = require('express');

const app = express();
const port = 3000;

const query = `
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name STRING NOT NULL,
        username STRING NOT NULL UNIQUE
    )
`;

db.exec(query)

const data = [
    {name: "bobby boi", username: "sans"},
    {name: "guacamole", username: "owo"},
    {name: "scoop", username: "cock123"}
]

const insertData = db.prepare("INSERT INTO users (name, username) VALUES (?, ?)");

data.forEach((user)=>{
    try{
        insertData.run(user.name,user.username)
    }
    catch(e)
    {

    }
});

app.get('/api/users',(req,res) => {
    const users = db.prepare('SELECT * FROM users').all();

    console.log(users);

    res.json({users: users})
})

app.listen(port,() => {
    console.log(`Listening on port ${port}`)
})