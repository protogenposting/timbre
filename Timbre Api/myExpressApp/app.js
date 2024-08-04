const Joi = require('joi');
const express = require('express');
const app = express();

app.use(express.json())

const userSchema = Joi.object({
  username: Joi.string().min(3).max(30).required(),
  password: Joi.string().min(3).max(30).required()
});

const users = [
  {id:0,username: "bob",password:"billybobjoe"},
  {id:1,username: "bob2",password:"billybobjoe2"},
  {id:2,username: "bob3",password:"billybobjoe3"}
]

app.get('/api', (req,res) => {
  res.send("Nuh uh!")
});

app.get('/api/users', (req,res) => {
  res.send(users)
});

app.post('/api/newUser', (req,res) => {
  const result = userSchema.validate(req.body);

  console.log(req.body)

  if(result.error)
  {
    res.status(400).send(result.error)
    return
  }
  
  if(users.find(c => c.username === req.params.username))
  {
    res.status(400).send("User exists already!")
    return
  }

  const user = {
    id: users.length,
    username: req.body.username,
    password: req.body.password,
  };

  users.push(user)
  res.send(user)
  console.log(users)
});

app.get('/api/users/:id', (req,res) => {
  const user = users.find(c => c.id === parseInt(req.params.id));
  if(!user)
  {
    res.status(404).send('no player with that id!')
  }
  res.send(user)
});

const port = process.env.PORT || 3000

app.listen(port, () => console.log(`Listening on port ${port}`))