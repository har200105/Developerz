const { signUp, login, verifyOTP, sendForgetPasswordOTP, resetPassword } = require('../controllers/authController');
const router = require('express').Router();

router.post('/signup',signUp);
router.post('/login', login);
router.post('/verifyUser/:token', verifyOTP);
router.post('/forgotPassword', sendForgetPasswordOTP);
router.post('/resetPassword/:token', resetPassword);


module.exports = router;