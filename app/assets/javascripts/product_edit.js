/*========================
ストアURL切り替え(iPhone)
=========================*/
$(function(){
  $('#model-iphone').on('change',function(){
    if($('#store-iphone').prop('disabled')){
      $('#store-iphone').prop("disabled", false);
    }else{
      $('#store-iphone').prop("disabled", true);
    }
  });
});
/*========================
ストアURL切り替え(Android)
=========================*/
$(function(){
  $('#model-android').on('change',function(){
    if($('#store-android').prop('disabled')){
      $('#store-android').prop("disabled", false);
    }else{
      $('#store-android').prop("disabled", true);
    }
  });
});
/*========================
ストアURL切り替え(Web Game)
=========================*/
$(function(){
  $('#model-webgame').on('change',function(){
    if($('#store-webgame').prop('disabled')){
      $('#store-webgame').prop("disabled", false);
    }else{
      $('#store-webgame').prop("disabled", true);
    }
  });
});