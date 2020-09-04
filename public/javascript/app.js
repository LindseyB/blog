var grid = document.querySelector('.grid');
var msnry = new Masonry( grid, {
  itemSelector: '.grid-item',
  columnWidth: 50,
  fitWidth: true,
  gutter: 1,
  stagger: 30,
});

hljs.initHighlightingOnLoad();