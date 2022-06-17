const { addProject, getProjectById, getAllProjects, getMyProjects, updateProject, deleteProject, getProjectsByUser, getSearchResults } = require('../controllers/projectsController');
const reqAuth = require('../middleware/reqAuth');
const router = require('express').Router();

router.post('/addProject',reqAuth,addProject);
router.get('/getProjectById/:id', getProjectById);
router.get('/getSearchResults', getSearchResults);
router.get('/getProjects', getAllProjects);
router.get('/getProjectsByUser/:id', getProjectsByUser);
router.get('/getMyProjects',reqAuth,getMyProjects);
router.put('/updateProject/:id',reqAuth,updateProject);
router.delete('/deleteProject/:id', reqAuth, deleteProject);

module.exports = router;