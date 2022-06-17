const mongoose = require('mongoose');


const db = async () => {
    await mongoose.connect(process.env.DB_URL, () => {
        console.log("Database Connected");
    }); 
}

module.exports = db;