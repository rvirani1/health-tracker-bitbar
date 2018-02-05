#!/usr/bin/env /Users/riaznvirani/.nvm/versions/node/v8.9.4/bin/node

const bitbar = require('bitbar');
const moment = require('moment-timezone');
const firebase = require('firebase')
const firebaseConfig = require('../firebaseConfig')

const firebaseDatabase = firebase.initializeApp(firebaseConfig).database();

const currentDateFirebaseRef = (currentDateStr) => {
  return firebaseDatabase.ref('/calories').child(currentDateStr);
};

const currentDateFirebaseCalories = (currentDateStr) => {
  return currentDateFirebaseRef(currentDateStr).once('value')
};

const currentDateStr = moment().tz("America/New_York").format('YYYY-MM-DD');
currentDateFirebaseCalories(currentDateStr)
  .then(data => data.val() || 0)
  .then((calories) => {
    bitbar([{
      text: `Cals: ${calories.toString()}`
    }]);
    process.exit(0)
  })
