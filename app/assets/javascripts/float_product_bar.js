$(function(){
  
  $('.sticky-product-bar').each(function(){
    
    var $window=$(window),
        $header=$(this),
        headerOffsetTop=$header.offset().top;

    $window.on('scroll',$.throttle(1000/15,function()
    {
      if($window.scrollTop()>headerOffsetTop){
        $header.addClass('sticky');
      }else {
        $header.removeClass('sticky');
      }
    }));
    
    $window.trigger('scroll');
    
  });
});
