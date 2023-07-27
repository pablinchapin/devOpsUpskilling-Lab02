const express = require('express');
const mysql = require('mysql2');
const path = require('path');
const app = express();

const connection = mysql.createPool({
    connectionLimit: 10,
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
});

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '/index.html'));
});

app.get('/dbtest', (req, res) => {
	connection.query('SELECT * FROM quotes' , (err, rows) => {
		if(err){
			res.json({
				success: false,
				err
				});
		}
		else{
			res.json({
				success: true,
				rows
				});
		}
	});
});

app.listen(5000, () => {
    console.log('Server is up and running');
});