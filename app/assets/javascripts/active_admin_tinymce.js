$(document).ready(function() {
  //load_editors();

  //tinymce-jquery 方式
  // $('textarea').tinymce({
  //   theme: 'advanced',
  //   language : "zh-cn"
  // });
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