$(document).ready(function() {
  //load_editors();

 // tinymce-jquery 方式
  $('textarea').tinymce({
    theme: 'advanced',
    language: "zh-cn",
    plugins: "table",
    theme_advanced_buttons1 : "bold,italic,underline,separator,strikethrough,justifyleft,justifycenter,justifyright, justifyfull,bullist,numlist,undo,redo,link,unlink, image,table,removeformat,code",
    theme_advanced_buttons2 : "",
    theme_advanced_buttons3 : "",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    //theme_advanced_statusbar_location : "bottom",
  });
});

//no jquery 方式
  function load_editors(){
    tinyMCE.init({
      mode: 'textareas',
      language : "zh-cn",
      //theme: 'simple'
      theme: 'advanced'
  });
}

//教程：
//https://github.com/spohlenz/tinymce-rails