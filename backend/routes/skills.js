const { getSkills, addSkill } = require('../controllers/skillsController');
const reqAuth = require('../middleware/reqAuth');
const router = require('express').Router();

router.post('/addSkill',reqAuth,addSkill);
router.get('/getSkills', getSkills);


module.exports = router;