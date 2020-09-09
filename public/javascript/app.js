var grid = document.querySelector('.grid');
var msnry = new Masonry( grid, {
  itemSelector: '.grid-item',
  columnWidth: 50,
  fitWidth: true,
  gutter: 3,
  stagger: 30,
});

hljs.initHighlightingOnLoad();

function addDarkmodeWidget() {
  new Darkmode().showWidget({label: '🌓'});
}

window.addEventListener('load', addDarkmodeWidget);
