const { getDeveloperById, getDeveloperBySkill, getAllDevelopers, updateDeveloperProfile,
    getUserProfile, unfollowUser, followUser } =
    require('../controllers/userController');
const reqAuth = require('../middleware/reqAuth');
const router = require('express').Router();


router.get('/getDeveloperById/:id', getDeveloperById);
router.get('/getDeveloperBySkill/:skill', getDeveloperBySkill);
router.get('/getAllDevelopers', getAllDevelopers);
router.put('/updateUserProfile', reqAuth, updateDeveloperProfile);
router.put('/follow/:id', reqAuth, followUser);
router.put('/unfollow/:id', reqAuth, unfollowUser);
router.get('/getUser', reqAuth, getUserProfile);

module.exports = router;