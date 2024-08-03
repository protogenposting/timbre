const Joi = require('joi');
const express = require('express');
const app = express();

app.use(express.json())

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

app.post('/api/users', (req,res) => {
  const schema = Joi.object({
    username: Joi.string().min(3).max(30).required()
  });

  const result = schema.validate(req.body);

  console.log(result)

  if(!req.body.username)
  {
    res.status(400).send("Name required!!!")
    return
  }

  const user = {
    id: users.length + 1,
    username: req.body.username,
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