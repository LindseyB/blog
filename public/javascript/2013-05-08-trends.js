window.onload = function() {
  // just setting this style on this page
  $(".graph").css('float', 'left')
             .css('margin', '1em');

  var data = [
                [8.5, 9.8, 10.1, 9.9, 8.7, 6.5, 6.2, 6.2, 8.4, 7.0, 6.8], // Nonresident Alien
                [3.4,3.2,3.1,3.3,3.9,3.4,4,3.4,3.4,3.6,4.5], // African-American, Non-Hispanic
                [0.4,0.3,0.4,0.3,0.3,0.4,0.8,0.3,0.4,0.5,0.4], // Native American/Alaskan Native
                [21.7,24.5,23.1,20.9,17.4,14.6,15.4,15,15,15.1,16.4], // Asian/Pacific Islander
                [3.6,3.7,3.9,4.4,4.6,5.4,6.1,5.8,5.3,5.4,6.3], // Hispanic 
                [57.8,55.6,54.5,59.5,63.7,67.3,65.8,68.9,66.5,66.9,64], // White, Non-Hispanic
                [4.7,2.9,5,1.7,1.3,2.5,1.7,0.4,1,1.5,1.6] // Other/Not Listed
             ]
  , colors = ["#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854", "#FFD92F", "#E5C494"]
  , eth    = ["Nonresident Alien", "African-American, Non-Hispanic", "Native American/Alaskan Native",
              "Asian/Pacific Islander", "Hispanic", "White, Non-Hispanic", "Other/Not Listed"];

  for (var i = 1; i <= 7; i++){
    drawGraph(i, data[i-1])
  }

  // draw the barchart
  var r = Raphael("bars")
  r.barchart(0, 0, 300, 300, data, {
              stacked: true, 
              gutter: "5%",
              colors: colors
            });

  // draw the barchart color key
  for(i = 0; i < colors.length; i++){
    r.rect(305, 20+(i*30), 10, 10).attr({stroke: "none", fill: colors[i]});
    r.text(320, 25+(i*30), eth[i]).attr({'text-anchor': 'start'}); // without text-anchor text is centered
  }

  // draw the years for the barchat
  for (i = 0; i <= 10; i++){
    r.text(12+(i*26.5), 295, 2001+i).rotate(90);
  }

  function drawGraph(i, yVals){
    var r = Raphael("holder"+i, 200, 100);

    // creat the line chart
    r.linechart(0, 0, 200, 100,
      [2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011],
      yVals,
      {
        smooth: true,
        colors: ['#aeaeae'],
        symbol: 'circle',
        width: 1,
      });

    // draw the axis and set the color
    r.path("M0,0L0,100L200,100").attr({stroke:"#bbb"});
  }
}

Array.prototype.transpose = function() {

  // Calculate the width and height of the Array
  var a = this,
    w = a.length ? a.length : 0,
    h = a[0] instanceof Array ? a[0].length : 0;

  // In case it is a zero matrix, no transpose routine needed.
  if(h === 0 || w === 0) { return []; }

  /**
   * @var {Number} i Counter
   * @var {Number} j Counter
   * @var {Array} t Transposed data is stored in this array.
   */
  var i, j, t = [];

  // Loop through every item in the outer array (height)
  for(i=0; i<h; i++) {

    // Insert a new row (array)
    t[i] = [];

    // Loop through every item per item in outer array (width)
    for(j=0; j<w; j++) {

      // Save transposed data.
      t[i][j] = a[j][i];
    }
  }

  return t;
};