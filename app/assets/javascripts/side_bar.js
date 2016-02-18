$(function(){

  var duration=300;
  var $window=$(window);
  var $aside=$('aside#category-nav');
  //フッター
  var $footer=$('footer');
  var footerOffsetTop=$footer.offset().top;

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
        
        //フッター位置変更
        //footerOffsetTop=$footer.offset().top;
        if($aside.offset().top+$aside.height() > $footer.offset().top){
          $footer.css('top',$aside.offset().top + $aside.height() + 50);
        }
        
      }else{
        $aside.stop(true).animate({
          left: -$aside.width()
        },duration,'easeOutElastic');
        $asideButton.text(" OPEN");//文字変更
        
        //フッター位置を元に戻す
        //$footer.css('top',footerOffsetTop);
      }
    });
    
});
