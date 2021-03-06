const mongoose = require('mongoose');
const userSchema = mongoose.Schema({

    name: {
        type: String,
        required:true
    },

    email: {
        type: String,
        required:true
    },

    password: {
        type: String,
        required: true
    },

    skills:Array,

    github: String,
    linkedin: String,
    twitter: String,
    website:String,

    image:String,

    bio: String,

  
    pic:String

}, {
    timestamps:true
});

const User = mongoose.model("User", userSchema);
module.exports = User;