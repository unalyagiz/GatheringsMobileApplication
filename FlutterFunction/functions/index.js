const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);



exports.messageTrigger = functions.firestore.document('messages/{idg}/{idh}/{ip}').onCreate(async (snap, context) => {
    if(snap.empty){
        console.log('no document found');
        return ;
    }
    var uids = [];
    var tokens = [];

    const newData = snap.data();
    const text = newData.text;
    const from = newData.from;
    const u = newData.uid;

    var payload = {
        notification: {title: 'New Message', body: `${from}: ${text}`, sound: 'default'},
        data: {click_action: 'FLUTTER_NOTIFICATION_CLICK' , message: text}
    };

    const posterid =context.params.idg;
    uids.push(posterid);

    const docc =  await admin.firestore().collection(`messages/${posterid}/${posterid}`).get();
    docc.forEach(doc=>{
        uids.push(doc.data().uid);
    });

    const acc =  await admin.firestore().collection('account').get();
    let uniqueIds = uids.filter(function (elem, pos) {
        return uids.indexOf(elem) === pos;
    });

        acc.forEach(doc=>{
            uniqueIds.forEach(us =>{
                if(doc.data().uid===us){
                tokens.push(doc.data().token);
                }
            })
        });
    let uniqueToken = tokens.filter(function (elem, pos) {
        return tokens.indexOf(elem) === pos;
    });


    try{
        const response = await admin.messaging().sendToDevice(uniqueToken,payload);
        console.log('Notification send successfully',response);
        console.log('uids',uids);
        console.log('tokens',tokens);
        console.log('accounts:',acc);
        console.log('messages:',docc);
    }catch (e) {
        console.log(e);
        console.log('uids',uids);
        console.log('tokens',tokens);
        console.log('accounts:',acc);
        console.log('messages:',docc);
    }
});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
