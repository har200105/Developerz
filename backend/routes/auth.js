const { signUp, login } = require('../controllers/authController');
const router = require('express').Router();

router.post('/signup',signUp);
router.post('/login', login);
// router.post('/verifyUser/:token', verifyUser);
// router.post('/forgotPassword', forgetPassword);
// router.post('/resetPassword/:token', resetPassword);


module.exports = router;