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
});
