const { getDeveloperById, getDeveloperBySkill, getAllDevelopers, updateDeveloperProfile, getUserProfile } = require('../controllers/userController');
const reqAuth = require('../middleware/reqAuth');
const router = require('express').Router();


router.get('/getDeveloperById/:id', getDeveloperById);
router.get('/getDeveloperBySkill/:skill', getDeveloperBySkill);
router.get('/getAllDevelopers', getAllDevelopers);
router.put('/updateUserProfile', reqAuth, updateDeveloperProfile);
router.get('/getUser', reqAuth, getUserProfile);

module.exports = router;