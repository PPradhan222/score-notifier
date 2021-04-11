import consumer from "./consumer"

$(document).on('turbolinks:load', function () {
  consumer.subscriptions.create({
    channel: "ScoreboardChannel",
    match_id: $("#live-match-status").attr("data-match-id")
    }, {
    connected() {
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      var d = new Date();
      $("#live-match-status").text(d.toLocaleTimeString() + " " + data.match_result);
      data.innings.forEach(this.fill_innings);
    },

    fill_innings(inning) {;
      var $inning_element = $("#inning-"+inning["inning_number"]);
      $inning_element.children("p.inning-status").text(inning["name"]);
      var inning_number = inning["inning_number"];
      $(".inning"+inning_number+"-score").css("display", "table-cell");
      $("#inning"+inning_number+"-team").text(inning["name"].split("Innings")[0].trim());
      $("#inning"+inning_number+"-team-score").text(inning["runs"]+"/"+inning["wickets"]);
      $("#inning"+inning_number+"-team-overs").text(inning["overs"]);
      inning["batting_card"].forEach((batsman_data) => {
        var $ = jQuery.noConflict();
        var $batsman_row_element = $(".batsman-data[data-batsman-id='"+batsman_data["profile_url"]+"']");
        $batsman_row_element.children(".batsman-wicket-status").text(batsman_data["wicket_status"]);
        $batsman_row_element.children(".batsman-runs-scored").text(batsman_data["runs_scored"]);
        $batsman_row_element.children(".batsman-balls-faced").text(batsman_data["balls_faced"]);
        $batsman_row_element.children(".batsman-fours").text(batsman_data["fours"]);
        $batsman_row_element.children(".batsman-sixes").text(batsman_data["sixes"]);
        $batsman_row_element.children(".batsman-strike-rate").text(batsman_data["strike_rate"]);
      });
      inning["bowling_card"].forEach((bowler_data) => {
        var $ = jQuery.noConflict();
        var $bowler_row_element = $(".bowler-data[data-bowler-id='"+bowler_data["profile_url"]+"']");
        $bowler_row_element.children(".bowler-overs").text(bowler_data["overs"]);
        $bowler_row_element.children(".bowler-maiden-overs").text(bowler_data["maiden_overs"]);
        $bowler_row_element.children(".bowler-runs-conceded").text(bowler_data["runs_conceded"]);
        $bowler_row_element.children(".bowler-wickets-taken").text(bowler_data["wickets_taken"]);
        $bowler_row_element.children(".bowler-economy-rate").text(bowler_data["economy_rate"]);
      });
    }
  });
})

// $(document).ready(function(){
//   var $element = $('.live-match-status'),
//       match_id = $element.data('match-id');

//   consumer.subscriptions.create(
//     {
//         channel: "ScoreboardChannel",
//         match_id: match_id
//     },
//    {
//     received(data) {
//       var d = new Date();
//       $element.text(d.toLocaleTimeString() + " " + data.match_result);
//     }
//   });
// })
