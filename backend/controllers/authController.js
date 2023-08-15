const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const otpgen = require('otp-generator');
const OTP = require('../models/otp');
const catchAsyncErrors = require('../middleware/catchAsyncErrors');
const router = require('express').Router();
const jwt = require('jsonwebtoken');
const { sendVerificationEmail } = require('../utils/mailServices');


const signUp = catchAsyncErrors(async (req, res) => {
    const { email, password, name, image } = req.body;
    if (!email || !password || !name) {
        return res.status(401).json({ message: "Please Add All The Feilds", success: false })
    }
    try {
        const exist = await User.findOne({ email });
        
        if (exist) {
            return res.json({ success: false, message: "User Already Exists" });
        }
        
        
        else {
            const otp = otpgen.generate(6, {
                digits: true,
                lowerCaseAlphabets: false,
                upperCaseAlphabets: false,
                specialChars: false
            });
            bcryptjs.hash(password, 8)
                .then(async (hashedpassword) => {
                    const newUser = User({
                        email,
                        password: hashedpassword,
                        name,
                        image
                    });
                    await newUser.save();
                    return res.status(200).json({ message: "Signup Successfull", success: true });
                })
        }
    } catch (e) {
        console.log(e.message);
        res.status(500).json("Error :" + e.message);
    }
});

const login = catchAsyncErrors(async (req, res) => {
    const { email, password } = req.body;
    try {
        const exist = await User.findOne({ email });
        if (exist) {
            bcryptjs.compare(password, exist.password).then((matched) => {
                if (matched) {
                    const token = jwt.sign({ _id: exist._id }, process.env.JWT_SECRET);
                    return res.status(200).json({
                        name: exist.name,
                        image: exist.image, email: exist.email, token,
                        verified: true, success: true,
                        _id:exist._id
                    });
                } else {
                    return res.json({ message: "Invalid Email or Password", success: false, verified: true });
                }
            });
        }
        else {
            res.json({ message: "User Doesnt Exist", success: false, verified: false });
        }
    } catch (e) {
        console.log(e);
    }
});


const verifyOTP = async (req, res) => {
     const checkotp = await OTP.findOne({ otp: req.body.otp, email:req.body.email });
    if (!checkotp) {
        return res.json({message:"Not a Valid OTP",success:false});
    } else {
        await User.findOneAndUpdate({
            email: checkotp.email
        }, { 
            verified: true
        }, {
            new: true
        }).then(async (s) => {
            await OTP.findOneAndDelete({ email: checkotp.email });
        }).then(() => {
            res.status(200).json({
                message: "OTP Verified Successfully",
                success: false
            });
        })
    }
}


const resetPassword = async (req, res) => {
    const checkotp = await OTP.findOne({ otp: req.body.otp, email:req.body.email });
    if (!checkotp) {
        return res.status(401).json({message:"Not a Valid OTP",success:false});
    } else {
        const hashedpassword = b.hash(req.body.password,10);
        await User.findOneAndUpdate({
            email: checkotp.email,
            verifed:true
        }, {
            password:hashedpassword
        }, {
            new: true
        }).then(async () => {
            await OTP.findOneAndDelete({ email: checkotp.email });
        }).then(() => {
            res.status(200).json({
                message: "Password Changed Successfully",
                success:true                
            })
        })
    }
}

const sendForgetPasswordOTP = async (req, res) => {
    const { email } = req.body;
    const user = await User.find({ email });
    if (!user) {
       return res.status(201).json({
        success: false,
        message: "User not found"
     });
    }
    await OTP.findOneAndDelete({ email: user.email });
    const otp = otpgen.generate(6, {
            digits: true,
            lowerCaseAlphabets: false,
            upperCaseAlphabets: false,
            specialChars: false
        });
    const newOTP = await OTP({
        otp,
        email
    });
    await newOTP.save();
    sendOTP(email, otp);
    res.status(201).json({
        success: true,
        message: "Forgot Password OTP Sent"
    });
}





module.exports = {
    signUp,
    login,
    verifyOTP,
    sendForgetPasswordOTP,
    resetPassword
};