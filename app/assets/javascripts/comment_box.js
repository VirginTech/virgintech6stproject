$(function(){

  $('.input-comment input').focus(function(){
    event.preventDefault();
    if($('#user-comment-box')[0]){
      $('.input-comment input').blur();//フォーカスを外す
      $('#user-comment-box').modal('show');
    }else{
      $('.input-comment input').blur();//フォーカスを外す
      $('#alert-login-dialog').modal('show');
    }
  });
  
});

/*
  var duration=300;
  var $window=$(window)
  var $commentBox=$('div#user-comment-box');
  
  $('.input-comment input').focus(function(){
    event.preventDefault();
    if($commentBox[0]){
      $commentBox.stop(true).animate({
        top: $window.height()-500
      },duration,'swing');
      $('.user-comment-form textarea').focus();
    }else{
      $('.input-comment input').blur();//フォーカスを外す
      $('#alert-login-dialog').modal('show');
    }
  });
    
  $('.comment-box-close').on('click',function(event){
      event.preventDefault();
      $commentBox.stop(true).animate({
        top: -500
      },duration,'swing');
  });

});
*/