$(function(){

  var duration=300;
  var $window=$(window);
  var $aside=$('aside#category-nav');
  var $asideButton=$('.side-button').on('click',function(event){
      
      event.preventDefault();
      $aside.toggleClass('open');
      
      if($aside.hasClass('open')){
        //Topをスクロール位置に合わせる
        $aside.css('top', $window.scrollTop() + 100);

        $aside.stop(true).animate({
          left:'-10px'
        },duration,'easeOutElastic');
        $asideButton.text(" CLOSE");//文字変更
        
      }else{
        $aside.stop(true).animate({
          left: -$aside.width()
        },duration,'easeOutElastic');
        $asideButton.text(" OPEN");//文字変更
      }
    });
    
});
