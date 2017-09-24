 function rate() { 
  $('.rating-form span').click(function(){
    value = $(this).attr("data-score");
    $(".rating-value").val(value);
    $(this).siblings("span").removeClass("glyphicon glyphicon-star").addClass("glyphicon glyphicon-star-empty");
    $(this).removeClass("glyphicon glyphicon-star").addClass("glyphicon glyphicon-star-empty");
    $(this).prevAll(".star").removeClass("glyphicon glyphicon-star-empty").addClass("glyphicon glyphicon-star");
    $(this).removeClass("glyphicon glyphicon-star-empty").addClass("glyphicon glyphicon-star");
  });
}