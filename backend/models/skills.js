const mongoose = require('mongoose');
const skillSchema = mongoose.Schema({
    name: String,
    addedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref:"User"
    },
 
}, { timestamps: true });


const Skill = mongoose.model('Skill', skillSchema);
module.exports = Skill;