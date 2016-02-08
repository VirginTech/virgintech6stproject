/*========================
モーダルダイアログにデータを渡す
=========================*/
$(function() {
  $('#alert-user-logged-in').on('show.bs.modal', function(event) {
    
    var value = $(event.relatedTarget);
    
    //タイトル
    var title = value.data('title');
    var tag_title = document.getElementById("title");
    tag_title.innerHTML=title;
    
    //テキスト
    var text = value.data('text');
    var tag_text = document.getElementById("text-body");
    tag_text.innerHTML=text;

  });
});
