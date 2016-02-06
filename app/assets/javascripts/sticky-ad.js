$(function(){
  $('.sticky-ad-left').each(function(){
    var $window=$(window);
    var $ad=$(this);
    var adOffsetTop=$ad.offset().top;
    var centerBoxLeft=$('.page-center').offset().left;

    var adSizeWidth;
    if ($ad.hasClass('width-160')){
      adSizeWidth=160;
    }else if($ad.hasClass('width-200')){
      adSizeWidth=200;
    }else if($ad.hasClass('width-300')){ 
      adSizeWidth=300;
    }

    $window.on('scroll',$.throttle(1000/15,function()
    {
      if($window.scrollTop()>adOffsetTop-70){
        $ad.addClass('sticky');
        $ad.css('left',centerBoxLeft - adSizeWidth - 40);
      }else {
        $ad.removeClass('sticky');
        $ad.css('left',centerBoxLeft - adSizeWidth - 40);
      }
    }));
    $window.trigger('scroll');
  });
});

$(function(){
  $('.sticky-ad-right').each(function(){
    var $window=$(window);
    var $ad=$(this);
    var adOffsetTop=$ad.offset().top;
    var adSizeWidth=160;
    var centerBoxLeft=$('.page-center').offset().left;
    var centerBoxWidth=$('.page-center').width();
    $window.on('scroll',$.throttle(1000/15,function()
    {
      if($window.scrollTop()>adOffsetTop-70){
        $ad.addClass('sticky');
        $ad.css('left', centerBoxLeft + centerBoxWidth + 40); //windowの絶対値
      }else {
        $ad.removeClass('sticky');
        $ad.css('left', 26); //なぜか相対位置からの絶対値
      }
    }));
    $window.trigger('scroll');
  });
});
