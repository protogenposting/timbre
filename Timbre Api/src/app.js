const databaseName='app.db'

const db = require('better-sqlite3')(databaseName);
const express = require('express');

const app = express();
app.use(express.json());
const port = 3000;
const apiPath='/api/'

const query = `
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name STRING NOT NULL,
        username STRING NOT NULL UNIQUE,
        password STRING NOT NULL
    );
    CREATE TABLE IF NOT EXISTS baseStats (
        id INTEGER PRIMARY KEY,
        pp INTEGER NOT NULL,
        cockSize INTEGER NOT NULL
    );
`;

const currentSessions = [

]

db.exec(query)

//get all the users
app.get(apiPath+'users',(req,res) => {
    if(verify_token(req.headers.authorization))
    {
        const users = db.prepare('SELECT * FROM users').all();

        console.log(users);

        res.json({users: users})
    }
    else
    {
        res.send("nuh uh tell me the secret password!!!")
    }
})

//get a user by name
app.get(apiPath+'user/:name',(req,res) => {
    if(verify_token(req.headers.authorization))
    {
        const user = db.prepare(`
            SELECT * FROM users WHERE username = ?
            `).get(req.params.name);

        console.log(user);

        res.json({user: user})
    }
    else
    {
        res.send("nuh uh tell me the secret password!!!")
    }
})

//delete a user
app.delete(apiPath+'user/:name',(req,res) => {
    if(verify_token(req.headers.authorization))
    {
        db.prepare(`DELETE * FROM users WHERE username = ?`).run();

        res.send("Ok did that");
    }
    else
    {
        res.send("nuh uh tell me the secret password!!!")
    }
})

//create a user :3
app.post(apiPath+'newUser',(req,res) => {
    if(verify_token(req.headers.authorization))
    {
        console.log(req.body)
        
        const insertData = db.prepare("INSERT INTO users (name, username, password) VALUES (?, ?, ?)");
        
        var result = insertData.run(req.body.name,req.body.username,req.body.password)
        
        res.send(result)
    }
    else
    {
        res.send("nuh uh tell me the secret password!!!")
    }
})

function verify_token(_token)
{
    return _token == "A92n5nIlklaPosfbngfbsYYhfkskaNuuHGFNJSA"
}

app.listen(port,() => {
    console.log(`Listening on port ${port}`)
})