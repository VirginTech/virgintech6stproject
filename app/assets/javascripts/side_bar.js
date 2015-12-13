$(function(){

  var duration=300;

  var $aside=$('aside');
  var $asideButton=$('.side-button').on('click',function(){
    
      $aside.toggleClass('open');

      if($aside.hasClass('open')){
        $aside.stop(true).animate({
          left:'-10px'
        },duration,'easeOutElastic');
      }else{
        $aside.stop(true).animate({
          left: -$aside.width()
        },duration,'easeOutElastic');
      }
    });
});
