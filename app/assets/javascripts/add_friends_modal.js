$(function(){
  function addFriend(){
    var link = $(".add-friend").attr("href")
    $.getScript(link);
  }
  $(".add-friend").click(function(event){
    event.preventDefault();
    addFriend();
  })
})