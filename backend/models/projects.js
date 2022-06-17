const mongoose = require('mongoose');
const projectSchema = mongoose.Schema({

    name: String,
    image:String,
    codeUrl: String,
    liveUrl: String,
    developer: {
        type: mongoose.Schema.Types.ObjectId,
        ref:"User" 
    },
    techStacksUsed: Array,
    about: String,
    upvotes: [{
        type: mongoose.Schema.Types.ObjectId,
        ref:"User" 
    }],
    downvotes: [{
        type: mongoose.Schema.Types.ObjectId,
        ref:"User" 
    }]
}, {
    timestamps: true
});

const Project = mongoose.model("Project", projectSchema);
module.exports = Project;