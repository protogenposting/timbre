/**
 * Sessions are used to make sure a person has logged in before giving them any information from the server. Banned users will not be able to create a session.
 */
class Session
{ 
    Session(_username,_key)
    {
        var username = _username
        var key = _key
    }
}

const databaseName='app.db'

//load in the database
const db = require('better-sqlite3')(databaseName);

//load in express
const express = require('express');

//activate express
const app = express();
app.use(express.json());
const port = 3000;
const apiPath='/api/'

//create the tables if they don't exist
const query = `
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY UNIQUE,
        name STRING NOT NULL,
        username STRING NOT NULL UNIQUE,
        password STRING NOT NULL
    );
    CREATE TABLE IF NOT EXISTS baseStats (
        id INTEGER PRIMARY KEY UNIQUE,
        pp INTEGER NOT NULL,
        cockSize INTEGER NOT NULL
    );
    CREATE TABLE IF NOT EXISTS baseStats (
        id INTEGER PRIMARY KEY UNIQUE,
        pp INTEGER NOT NULL,
        cockSize INTEGER NOT NULL
    );
`;

const currentSessions = []

db.exec(query)

//get all the users
app.get(apiPath+'users',(req,res) => {
    if(verify_token(req.headers.authorization))
    {
        const users = db.prepare('SELECT * FROM users').all();

        console.log(users);

        remove_passwords(users)

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

        delete user.password

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

//create a login session
app.post(apiPath+'login',(req,res) => {
    if(verify_token(req.headers.authorization))
    {
        console.log(req.body)
        
        const user = db.prepare(`
            SELECT * FROM users WHERE username = ? AND password = ?
            `).get(req.body.name,req.body.password);
        
        
        if(user == null)
        {
            var sessionID = "0"
            res.send({sessionID: sessionID})
        }
        else
        {
            var sessionID = generate_session_key(120)
            while(currentSessions.indexOf(sessionID)>-1)
            {
                sessionID = generate_session_key(120)
            }
            currentSessions.push(sessionID);
            res.send({sessionID: sessionID})
        }
    }
    else
    {
        res.send("nuh uh tell me the secret password!!!")
    }
})

/**
 * Check if the provided toek is the same as our actual token
 * @param {*} _token the token from the request
 * @returns true or false depending on if the token matches
 */
function verify_token(_token)
{
    return _token == "A92n5nIlklaPosfbngfbsYYhfkskaNuuHGFNJSA"
}

/**
 * verify if the session token and username match any of the other sessions, wip currently
 * @param {*} _token 
 * @param {*} _username 
 * @returns boolean of whether the session key is accurate or not
 */
function verify_session_key(_token,_username)
{
    currentSessions.forEach(element => {
        if(_token == element.token && _username == element.username)
        {
            return true
        }
    });
    return false
}

/**
 * Removes the password from all users returned in a list. Used so that you can't just get the passwords of every player.
 * @param {*} _users 
 */
function remove_passwords(_users)
{
    _users.forEach(element => {
        delete element.password
    });
}

/**
 * generates a random string based on length
 * @param {*} length how long the session key should be
 * @returns the session key
 */
function generate_session_key(length) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    let counter = 0;
    while (counter < length) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
      counter += 1;
    }
    return result;
}

app.listen(port,() => {
    console.log(`Listening on port ${port}`)
})