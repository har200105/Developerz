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
    console.log(skill);
    const developers = await User.find({ skills: { $in: skill } });
    return res.status(201).json(developers);
});

const getUserProfile = catchAsyncErrors(async (req, res) => {
    if (req.user) {
        res.status(201).json(req.user);
        console.log(req.user);
   } 
});


const getAllDevelopers = catchAsyncErrors(async (req, res) => {
    await User.find({}).sort("-createdAt").limit(10).then((data) => {
        res.status(201).json({ data });
    });
});


const updateDeveloperProfile = catchAsyncErrors(async (req, res) => {
    console.log(req.body);
    await User.findByIdAndUpdate(req.user._id, {
        $set: req.body
    }, {
        new: true
    });

    let user = await User.findById(req.user._id);
    
    if (req.body.github) {
        if (user.socialMediaLinks.length === 0) {
            user.socialMediaLinks.push({ github: req.body.github });
        } else {
            let findIndex = user.socialMediaLinks.findIndex((s) => s.github !== null);
            if (findIndex === null) {
                user.socialMediaLinks.push({ github: req.body.github });
            } else {
                user.socialMediaLinks[findIndex].github = req.body.github;
            }
        }
            await user.save();
    }

    //  if (req.body.linkedinurl) {
    //      if (user.socialMediaLinks.length === 0) {
    //         user.socialMediaLinks.push({ linkedin: req.body.linkedinurl });
    //     } else {
    //         let findIndex = user.socialMediaLinks.findIndex((s) => s.linkedin !== null);
    //         if (findIndex === null) {
    //             user.socialMediaLinks.push({ linkedin: req.body.linkedinurl });
    //         } else {
    //             user.socialMediaLinks[findIndex].linkedin = req.body.linkedinurl;
    //         }
    //      }
    //          await user.save();
    // }


    //  if (req.body.twitter) {
    //       if (user.socialMediaLinks.length === 0) {
    //         user.socialMediaLinks.push({ twitter: req.body.twitter });
    //     } else {
    //         let findIndex = user.socialMediaLinks.findIndex((s) => s.twitter !== null);
    //         if (findIndex === null) {
    //             user.socialMediaLinks.push({ twitter: req.body.twitter });
    //         } else {
    //             user.socialMediaLinks[findIndex].twitter = req.body.twitter;
    //           }
    //         }
    //         await user.save();
    // }
    //  if (req.body.website) {
    //       if (user.socialMediaLinks.length === 0) {
    //         user.socialMediaLinks.push({ website: req.body.website });
    //     } else {
    //         let findIndex = user.socialMediaLinks.findIndex((s) => s.website !== null);
    //         if (findIndex === null) {
    //             user.socialMediaLinks.push({ website: req.body.website });
    //         } else {
    //             user.socialMediaLinks[findIndex].website = req.body.website;
    //         }
    //      }
    //          await user.save();
    // }


    res.status(201).json({ success: true });

});

module.exports = {
    getDeveloperById,
    getDeveloperBySkill,
    getAllDevelopers,
    updateDeveloperProfile,
    getUserProfile
};