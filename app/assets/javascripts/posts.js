/* 各ページでの実装jquery */
$( document ).on('turbolinks:load', function() {

 /* 投稿画像のプレビュー （new,edit）*/
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        var formData = new FormData();
        formData.append("image_cache", input.files[0]);
        $.ajax({
          url: "check_cache_image",
          type: "POST",
          data: formData,
          dataType: "json",
          processData: false,
          contentType: false,
        }).done(function(data){
          console.log("done");
          console.log(data);
           var tag_list = data.data.tag_list
           var image_flag = data.data.image_flag
           console.log(tag_list);
           console.log(image_flag);

           if(image_flag == true){
             $('#image_isnot_sky').removeClass('hidden');
             console.log("done flag");
           }else{

             $('#image_isnot_sky').addClass('hidden');

             $("#post-tags").tagit("removeAll");

             $.each(tag_list, function(index, tag){
               $('#post-tags').tagit('createTag', tag);
               console.log(tag);
             })
             console.log("finish done");
           }

        }).fail(function(){
          console.log("fail");
          alert('画像の読み込みに失敗しました');
        })

        $('#image_img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#post_img").change(function(){
    $('#image_img_prev').removeClass('hidden');
    $('.avatar_present_img').remove();
    readURL(this);
  });

  /* 投稿一覧画面 */

  //空の写真一覧を順番に浮かび上がって出す
  $('.days-images  li').each(function(i){
      $(this).delay(i * 100).css({visibility:'visible',opacity:'0'}).animate({opacity:'1'},1000);
  });

  /* tag-itの挙動管理 */
  $('#post-tags').tagit({
    fieldName:   'tag_list',
    singleField: true
  });

  $('#post-tags').tagit();

  var tag_string = $("#tag_hidden").val();
  var tag_list = tag_string.split(',');

  $.each(tag_list, function(index, tag){
    $('#post-tags').tagit('createTag', tag);
  })

});