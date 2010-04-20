$(document).ready(function() {
  brio.utility.register_date_picker([$('#birthday_date_picker')]);

  $("#show_password").change(function(){
      $("#password_container").toggle();
  });
});
