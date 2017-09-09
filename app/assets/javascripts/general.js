function applyToggleMethod() {
  $.ajax({
    url: $(this).attr("link")
  }).done(function(html) {
//    return $("#results").append(html);
  });
}

//$(document).ready (
//  function() {
//    $('.todo-toggle').click(
//      applyToggleMethod
//    )
//  }
//);

