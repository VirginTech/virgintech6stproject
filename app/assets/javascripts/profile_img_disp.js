//==============================
//ファイル選択ダイアログ
//==============================
function fileProfileImage(event,tag) 
{
  var file = event.target.files[0];
  var disp = document.getElementById(tag);
  disp.innerHTML ="";

  //FileReaderオブジェクトの生成
  var reader = new FileReader();

  //画像ファイルかテキスト・ファイルかを判定
  if (!file.type.match('image.*')) 
  {
    //alert("画像ファイル以外は表示できません。");
    disp.innerHTML = "<span style='color:#f00;'>読み取り時にエラーが発生しました。</span>";
    $('#alert-undefined-img').modal('show');
  }

  //エラー発生時の処理
  reader.onerror = function (evt) 
  {
    disp.innerHTML = "<span style='color:#f00;'>読み取り時にエラーが発生しました。</span>";
    $('#alert-undefined-img').modal('show');
  }

  //画像ファイルの場合の処理
  if (file.type.match('image.*')) 
  {
    //ファイル読取が完了した際に呼ばれる処理
    reader.onload = function (evt) 
    {
      var img = document.createElement('img');
      img.src = evt.target.result;
      img.width=100;
      img.height=100;
      disp.appendChild(img);
    }
    //readAsDataURLメソッドでファイルの内容を取得
    reader.readAsDataURL(file);
  }
}