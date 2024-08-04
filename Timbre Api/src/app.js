const databaseName='app.db'

const db = require('better-sqlite3')(databaseName);
const express = require('express');

const app = express();
const port = 3000;
const apiPath='/api/'

const query = `
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name STRING NOT NULL,
        username STRING NOT NULL UNIQUE,
        password STRING NOT NULL
    )
`;

db.exec(query)

const data = [
    {name: "Protogen Posting", username: "protogenposting",password: "TimbreUnlock123"},
]

const insertData = db.prepare("INSERT INTO users (name, username, password) VALUES (?, ?, ?)");

data.forEach((user)=>{
    try{
        insertData.run(user.name,user.username,user.password)
    }
    catch(e)
    {
        
    }
});

app.get(apiPath+'users',(req,res) => {
    if(verify_token(req.headers.authorization))
    {
        const users = db.prepare('SELECT * FROM users').all();

        console.log(users);

        res.json({users: users})
    }
    else
    {
        res.send("nuh uh send me the secret password!!!")
    }
})

function verify_token(_token)
{
    return _token == "A92n5nIlklaPosfbngfbsYYhfkskaNuuHGFNJSA"
}

app.listen(port,() => {
    console.log(`Listening on port ${port}`)
})