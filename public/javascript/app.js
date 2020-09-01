$(document).ready(function(){
    // add prettyprint class to all <pre><code></code></pre> blocks
    var prettify = false;
    $("pre code").parent().each(function() {
      $(this).addClass('prettyprint');
      prettify = true;
    });

    // if code blocks were found, bring in the prettifier ...
    if ( prettify ) {
      $.getScript("/javascript/prettify.js", function() { prettyPrint() });
    }
});

$(".grid").masonry({
  itemSelector: '.grid-item',
  columnWidth: 400
});

$(window).on("resize", function () {
    width = parseInt($('#calc').css('width'));
    scale = width/552;
    $(".itch-wrapper iframe").css('transform-origin', '0 0')
                             .css('transform', 'scale('+scale+')');
    $(".itch-wrapper").css('height', (167*scale)+'px');
}).resize();


