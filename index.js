const express = require('express');
const os = require('os');

const app = express();

app.get('/', (req, res) => {
    res.send('Aplikacja Node.js działa poprawnie! 🚀');
});

app.listen(8080, () => {
    console.log('Serwer Express słucha na porcie 8080');
});
