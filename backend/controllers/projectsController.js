const catchAsyncErrors = require('../middleware/catchAsyncErrors');
const Project = require('../models/projects');
const User = require('../models/user');

const addProject = catchAsyncErrors(async (req, res) => {
    console.log(req.body);
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
              .sort("-createdAt")
        .populate("developer","name");
    const data = await User.find({ name: { $regex: pattern,$options:"i" } });
    res.status(201).json( { data:data, projects } );
});

const getMyProjects = catchAsyncErrors(async (req, res) => {
    await Project.find({ developer: req.user._id })
        .populate("developer","name")
        .then((projects) => {
        res.status(201).json({projects});
    });
});

const getProjectById = catchAsyncErrors(async (req, res) => {
    await Project.findById(req.params.id)
         .populate("developer","name")
        .then((data) => {
        res.status(201).json(data);
    });
});

const getAllProjects = catchAsyncErrors(async (req, res) => {
    await Project.find({})
        .sort("-createdAt")
        .limit(10)
        .populate("developer", "name")
        .then((projects) => {
            console.log(projects);
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
    await Project.findByIdAndDelete(req.params.id, { new: true }).then((data) => {
        res.status.json({ message: "Project Deleted" });
    });
});

const getProjectsByUser = catchAsyncErrors(async (req, res) => {
    console.log(req.params.id);
    console.log("gettt");
    await Project.find({ developer: req.params.id })
              .sort("-createdAt")
        .populate("developer","name")
        .then((projects) => {
            console.log(projects)
        res.status(201).json({projects});
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
    getSearchResults
}