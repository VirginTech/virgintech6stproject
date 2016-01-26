$(function(){
  
  $('footer').each(function(){
    
    var $window=$(window),
        $footer=$(this),
        footerOffsetTop=$footer.offset().top + $footer.height();
        
        //console.log($window.scrollTop());
        
    $window.on('scroll',$.throttle(1000/15,function()
    {
      if($window.height()>footerOffsetTop){
        $footer.addClass('sticky');
        $footer.css('top',$window.height()-$footer.height());
      }else {
        $footer.removeClass('sticky');
      }
    }));
    
    $window.trigger('scroll');

  });
});