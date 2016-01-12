$(function(){

  var duration=300;
  var $window=$(window)
  var $searchBox=$('div#search-box');
  
  $('.search-box-open').on('click',function(event){
      event.preventDefault();
      $searchBox.stop(true).animate({
        top: $window.scrollTop()
      },duration,'easeOutElastic');
    });
    
  $('.search-box-close').on('click',function(event){
      event.preventDefault();
      $searchBox.stop(true).animate({
        top: -$searchBox.height()
      },duration,'easeOutElastic');
  });

});
