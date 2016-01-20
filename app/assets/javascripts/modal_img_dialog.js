/*========================
モーダルダイアログにデータを渡す
=========================*/
$(function() {
  $('#modal-img-dialog').on('show.bs.modal', function(event) {
    
    var value = $(event.relatedTarget);
    
    //アプリ名
    var title = value.data('title');
    var tag_title = document.getElementById("modal-app-title");
    tag_title.innerHTML=title;
    
    //イメージ
    var img_url = value.data('imgurl');
    /*img srcを書き換える方法ならこちら*/
    $("#modal-img-disp img").attr("src",img_url);

    /*イメージを埋め込む方法ならこちら*/
    //var tag_img = document.getElementById("comment-img-disp");
    //tag_img.innerHTML="<img src=" + img_url + ">";
    //$("#comment-img-disp img").addClass("img-responsive");
    
  });
});
