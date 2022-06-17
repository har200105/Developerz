const catchAsyncErrors = require('../middleware/catchAsyncErrors');
const Skill = require('../models/skills');

const addSkill = catchAsyncErrors(async (req, res) => {
    const newSkill = Skill(req.body);
    await newSkill.save();
    res.status(201).json({ message: "Skill Updated" });
});

const getSkills = catchAsyncErrors(async (req, res) => {
    await Skill.find({}).then((data) => {
        res.status(201).json(data);
    });
});



module.exports = {
    addSkill,
    getSkills
};
