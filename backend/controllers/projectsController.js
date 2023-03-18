const catchAsyncErrors = require('../middleware/catchAsyncErrors');
const Project = require('../models/projects');
const User = require('../models/user');

const addProject = catchAsyncErrors(async (req, res) => {
    const {name,github,live,techStacksUsed,about,image} = req.body;
    const newProject = new Project({
        name,
        codeUrl:github,
        liveUrl:live,
        techStacksUsed,
        about,
        image,
        developer:req.user._id
    });
    await newProject.save();
    res.status(201).json({
        success:true,
        message: "Project Saved Sucessfully"
    });
});

const getSearchResults = catchAsyncErrors(async (req, res) => {
    const { search } = req.query;
    let pattern = new RegExp('^' + search);
    const projects = await Project.find({ name: { $regex: pattern, $options: "i" } })
        .sort("-upvotes.length")
        .sort("-createdAt")
        .populate("developer", "name")
        .populate("upvotes", "name")
        .populate("downvotes", "name");
    const data = await User.find({ name: { $regex: pattern,$options:"i" } });
    res.status(201).json( { data:data, projects } );
});

const getMyProjects = catchAsyncErrors(async (req, res) => {
    await Project.find({ developer: req.user._id })
        .sort("-upvotes.length")
        .sort("-createdAt")
        .populate("developer", "name")
        .populate("upvotes", "name")
        .populate("downvotes","name")
        .then((projects) => {
        res.status(201).json({projects});
    });
});

const getProjectById = catchAsyncErrors(async (req, res) => {
    await Project.findById(req.params.id)
        .populate("developer", "name")
        .sort("-createdAt")
        .populate("upvotes", "name")
        .populate("downvotes","name")
        .then((data) => {
        res.status(201).json(data);
    });
});

const getAllProjects = catchAsyncErrors(async (req, res) => {
    await Project.find({})
        .sort("-createdAt")
        .sort("-upvotes.length")
        .limit(10)
        .populate("developer", "name")
        .populate("upvotes", "name")
        .populate("downvotes","name")
        .then((projects) => {
        res.status(201).json({projects});
    });
});

const updateProject = catchAsyncErrors(async (req, res) => {
    await Project.findByIdAndUpdate(req.params.id, {
        $set: req.body
    }).then((data) => {
        res.status(201).json(data);
    });
});

const deleteProject = catchAsyncErrors(async (req, res) => {
    await Project.findByIdAndDelete(req.params.id, { new: true })
        .then(() => {
        res.status.json({ message: "Project Deleted" });
    });
});

const getProjectsByUser = catchAsyncErrors(async (req, res) => {
    await Project.find({ developer: req.params.id })
        .sort("-upvotes.length")
        .sort("-createdAt")
        .populate("developer", "name")
        .populate("upvotes", "name")
        .populate("downvotes", "name")
        .then((projects) => {
        res.status(201).json({projects});
    });
});


const upVoteProject = catchAsyncErrors(async (req, res) => {
    const project = await Project.findById(req.params.id);
    if (!project.upvotes.includes(req.user._id)) {
        await Project.findByIdAndUpdate(req.params.id, {
            $push: {
                upvotes: req.user._id,
            },
            $pull: {                
                downvotes: req.user._id ,
            }
        });
    }
    res.status(201).json({
        success: true,
        message: "Project Upvoted"
    });
});


const downVoteProject = catchAsyncErrors(async (req, res) => {
    const project = await Project.findById(req.params.id);
    if (project.upvotes.includes(req.user._id)) {
        await Project.findByIdAndUpdate(req.params.id, {
        $pull: {
                upvotes: req.user._id,
            },
            $push: {                
                downvotes: req.user._id ,
            }
        });
    }
    res.status(201).json({
        success: true,
        message: "Project Downvoted"
    });
});


module.exports = {
    addProject,
    getAllProjects,
    getMyProjects,
    getProjectById,
    updateProject,
    deleteProject,
    getProjectsByUser,
    getSearchResults,
    upVoteProject,
    downVoteProject
}