$(function(){
	$('#content').infinitescroll({
    loading:{
      img: "http://www.virgintech.co.jp/images/loader_32.gif",
      msgText: 'ロード中・・・',
      finishedMsg: "読み込みが終了しました。これが最後です。"
    },
    navSelector  : ".pagination",
    nextSelector : ".pagination a[rel=next]",
    itemSelector : ".product-list",
    //maxPage      : 5 //反映されない
	});
});

$(function(){
	$('#user-comments').infinitescroll({
    loading:{
      img: "http://www.virgintech.co.jp/images/loader_32.gif",
      msgText: 'ロード中・・・',
      finishedMsg: "読み込みが終了しました。これが最後です。"
    },
    navSelector  : ".pagination",
    nextSelector : ".pagination a[rel=next]",
    itemSelector : ".comment-list",
    //maxPage      : 5 //反映されない
	});
});
