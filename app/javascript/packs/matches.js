$(document).on('turbolinks:load', function () {
  $(".custom-control-input").on('click', function() {
    const match_format = $(this).data("format-id");
    const match_cards = $("."+match_format+"-match");
    if(this.checked){
      match_cards.show();
    }else{
      match_cards.hide();
    }
  });

  $(".match-status-link").on('click', function(){
    const match_status = $(this).data("status-id");
    const status_element = $("#q_status_eq");
    status_element.val(match_status);
    $(".matches-filters-form").submit();
  });
});
