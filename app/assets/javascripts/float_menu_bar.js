$(function(){
  
  $('.sticky-menu-bar').each(function(){
    
    var $window=$(window),
        $header=$(this),
        headerOffsetTop=$header.offset().top;

    $window.on('scroll',$.throttle(1000/15,function()
    {
      if($window.scrollTop()+10>headerOffsetTop){
        $header.addClass('sticky');
      }else {
        $header.removeClass('sticky');
      }
    }));
    
    $window.trigger('scroll');
    
  });
});
