const express = require('express');
const app = express();
const port = 3000;
const version = process.env.VERSION || 'green';

app.get('/', (req, res) => {
  res.send(`Hello from the ${version} version!`);
});

app.listen(port, () => {
  console.log(`App (${version}) is listening on port ${port}`);
});
