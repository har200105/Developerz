const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const bodyParser = require('body-parser');
const errorHandler = require('./middleware/error');
const app = express();
require('dotenv').config();
app.use(express.json());
app.use(errorHandler);
app.use(morgan('dev'));
app.use(bodyParser({ extended: true }));
app.use(cors());
require('./db')();

app.use('/api', require('./routes/auth'));
app.use('/api', require('./routes/projects'));
app.use('/api', require('./routes/skills'));
app.use('/api', require('./routes/user'));


const PORT = process.env.PORT || 5000;

app.listen(PORT, () =>{
    console.log("Server is Running --> akipiD"); 
});