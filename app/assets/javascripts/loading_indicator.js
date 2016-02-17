$(function() {
  $("#loading-show").on("click", function(event) {
    $('#loading').show(); // インジケータ表示
  });
});    

$(function() {
  $(document).on("ajax:before", ".ajax-load", function(event) {
    $.ajax({
      url: "products/create",
      type: "POST",
      dataType: "html"
    });
    $("form").submit();
  })
  .on("ajax:complete", ".ajax-load", function(event) {
    $('#loading').hide(); //# インジケータ非表示
  });
});