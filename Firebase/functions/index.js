const functions = require('firebase-functions');
const nodemailer = require('nodemailer');

const gmailEmail = functions.config().gmail.email;
const gmailPassword = functions.config().gmail.password;
const transportConfig = {
  service: 'gmail',
  auth: {
    user: gmailEmail,
    pass: gmailPassword
  }
};
const mailTransport = nodemailer.createTransport(transportConfig);
const ADMIN_EMAIL = 'kenta.nakai@urouro.net';

const sendEmail = (text) => {
  const email = ADMIN_EMAIL;
  const mailOptions = {
    from: 'サンプル <noreply@firebase.com>',
    to: email
  };
  mailOptions.subject = 'お問い合わせがありました';
  mailOptions.text = `お問い合わせ内容\n\n${text}`;

  return mailTransport.sendMail(mailOptions).then(() => {
    return console.log('Email sent to:', email);
  });
};

exports.contact = functions.firestore
  .document('/contacts/{id}')
  .onCreate(event => {
    const data = event.data.data();
    const text = `質問: ${data.category}\n内容: ${data.detail}\n日時: ${data.date}`;

    // メール送信処理
    return sendEmail(text);
  });

