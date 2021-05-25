var toUint8Array = require('urlb64touint8array');

$(document).on('turbolinks:load',() => {
  $(".submit-notification-btn").click(() => {
    event.preventDefault();
    checkPermission();
  });
});

function checkPermission() {
  if('Notification' in window){
    if(Notification.permission == 'granted'){
      console.log('permission granted already');
      getSubscribtion();
    }else{
      Notification.requestPermission(status => {
        console.log('Notification permission status:', status);
        if(status == 'granted'){
          getSubscribtion();
        }else{
          console.log('permission not available!');
          return
        }
      });
    }
  }else{
    console.log('Notification not supported');
    return
  }
}

function getSubscribtion() {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/service-worker.js').then(function(reg) {
      console.log('Service Worker Registered!', reg);

      reg.pushManager.getSubscription().then(function(sub) {
        if (sub === null) {
          console.log('Not subscribed to push service!');
          subscribeUser();
        } else {
          console.log('Subscription object: ', sub);
          updateDatabase(sub);
        }
      });
    })
     .catch(function(err) {
      console.log('Service Worker registration failed: ', err);
    });
  }
};

function subscribeUser() {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.ready.then(function(reg) {
    const applicationServerKey = toUint8Array("BNcKm1rpLWr8i2yApnjeMa4CzzARgCqe4rLgEtpCJvuNWxSg5E047lIdTGNGjTWtBd4b6AhValuNvOoCup1CpFA=");
      reg.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: applicationServerKey
      }).then(function(sub) {
        console.log('Endpoint URL: ', sub.endpoint);
        updateDatabase(sub);
      }).catch(function(e) {
        if (Notification.permission === 'denied') {
          console.warn('Permission for notifications was denied');
        } else {
          console.error('Unable to subscribe to push', e);
        }
      });
    })
  }
}

function updateDatabase(subscription_object) {
  // var formData = $(".match-notifications-form").serializeArray();
  // var match_id = $("#add-notifications-match-status").attr("data-match-id");
  subscription_object = subscription_object.toJSON();
  $("#user_endpoint").val(subscription_object?.endpoint);
  $("#user_p256dh").val(subscription_object?.keys?.p256dh);
  $("#user_auth").val(subscription_object?.keys?.auth);
  $(".match-notifications-form").submit();
  // debugger;
  // return $.ajax({
  //   url: '/matches/'+match_id+'/create_notifications',
  //   method: "POST",
  //   data: {subscription: subscription_object.toJSON(), formData},
  //   dataType: "json"
  // });
}
