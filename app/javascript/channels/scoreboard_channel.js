import consumer from "./consumer"

// consumer.subscriptions.create("ScoreboardChannel", {
//   connected() {
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   received(data) {
//     var d = new Date();
//     $("#sample").text(d.toLocaleTimeString());
//   }
// });


$(document).ready(function(){
  var $element = $('.live-match-status'),
      match_id = $element.data('match-id');

  consumer.subscriptions.create(
    {
        channel: "ScoreboardChannel",
        match_id: match_id
    },
   {
    received(data) {
      var d = new Date();
      $element.text(d.toLocaleTimeString());
    }
  });
})
