const mongoose = require('mongoose');

const otpSchema = mongoose.Schema({
    email: {
        type: String,
        number:true
    },
    otp: {
        type: String,
        number:true
    },
    createdAt: {
        type: Date,
        default: Date.now,
        index: {
            expires:300
        }
    }
}, {
    timestamps: true
});

const OTP = mongoose.model("otp", otpSchema);
module.exports = OTP;