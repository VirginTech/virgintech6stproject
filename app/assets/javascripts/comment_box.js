$(function(){

  var duration=300;
  var $window=$(window)
  var $commentBox=$('div#user-comment-box');
  
  $('.input-comment input').focus(function(){
      event.preventDefault();
      $commentBox.stop(true).animate({
        top: $window.height()-500
      },duration,'swing');
      $('.user-comment-form textarea').focus();
    });
    
  $('.comment-box-close').on('click',function(event){
      event.preventDefault();
      $commentBox.stop(true).animate({
        top: -500
      },duration,'swing');
  });

});