$(document).ready(() => {
  $(".match-notifications-submit").click(() => {
    event.preventDefault();
    var formData = $(".match-notifications-form").serializeArray();
    var match_id = $("#add-notifications-match-status").attr("data-match-id")
    return $.ajax({
      url: '/matches/'+match_id+'/create_notifications',
      method: "POST",
      data: $.param(formData),
      dataType: "json"
    });
  });
});
