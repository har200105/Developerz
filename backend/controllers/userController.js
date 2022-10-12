const User = require('../models/user');
const Skill = require('../models/skills');
const catchAsyncErrors = require('../middleware/catchAsyncErrors');


const getDeveloperById = catchAsyncErrors(async (req, res) => {
    await User.findById(req.params.id).then((data) => {
        res.status(201).json({ data });
    });
});

const getDeveloperBySkill = catchAsyncErrors(async (req, res) => {
    const skill = await Skill.find({ name: req.params.skill }).select({ _id: 1 });
    const developers = await User.find({ skills: { $in: skill } });
    return res.status(201).json(developers);
});

const getUserProfile = catchAsyncErrors(async (req, res) => {
    if (req.user) {
        res.status(201).json(req.user);
        console.log(req.user);
   } 
});

const followUser = catchAsyncErrors(async (req, res) => {
    await User.findByIdAndUpdate(req.params.id, {
        $addToSet: {
            followers: req.user._id
        }
    });
    await User.findByIdAndUpdate(req.user._id, {
        $addToSet: {
            following: req.params.id
        }
    });
});

const unfollowUser = catchAsyncErrors(async (req, res) => {
    await User.findByIdAndUpdate(req.params.id, {
        $pull: {
            followers: req.user._id
        }
    });
    await User.findByIdAndUpdate(req.user._id, {
        $pull: {
            following: req.params.id
        }
    });
});


const getAllDevelopers = catchAsyncErrors(async (req, res) => {
    await User.find({}).sort("-createdAt").limit(10).then((data) => {
        res.status(201).json({ data });
    });
});


const updateDeveloperProfile = catchAsyncErrors(async (req, res) => {
    await User.findByIdAndUpdate(req.user._id, {
        $set: req.body
    }, {
        new: true
    });
    res.status(201).json({ success: true });
});




module.exports = {
    getDeveloperById,
    getDeveloperBySkill,
    getAllDevelopers,
    updateDeveloperProfile,
    getUserProfile,
    followUser,
    unfollowUser
};