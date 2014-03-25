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


$("h1").fitText(0.8, { minFontSize: '20px', maxFontSize: '100px' });

// google analytics
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-4723762-1', 'rarlindseysmash.com');
ga('send', 'pageview');
