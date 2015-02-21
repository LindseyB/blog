---
title: Phasers set to kill
date: 2015-02-21
---

I like trying out a lot of different game frameworks and seeing how they stack up to each other. My current favorite is [LÖVE](http://love2d.org) which is really awesome for desktop games, but it's slightly more [challenging](https://github.com/TannerRogalsky/punchdrunk) for games in the browser. Which lead me to try out [Phaser](http://phaser.io/). For a company hackathon I had three days to put together a project and so I decided to make a Oregon Trail clone set in space.

While Phaser supports both JavaScript and TypeScript I decided to opt for JavaScript when writing my code. Phaser makes it extremely easy to create typical game elements and in about an hour or so I had a working asteroids clone. Their [examples](http://examples.phaser.io/) cover almost everything you can do with the library ([asteroids movement for example](http://examples.phaser.io/_site/view_full.html?d=arcade%20physics&f=asteroids+movement.js&t=asteroids%20movement)) and I found myself using the examples more for reference than the actual [documentation](http://docs.phaser.io/).

There were a couple pitfalls I encountered when messing with Phaser. For one the suggested method of handling input items is by floating some normal HTML controls over the canvas element. I didn't like how this look and even when styled properly it didn't feel like the right fit for my game. So I created custom methods for entering strings for the user and displaying a blinking cursor. Additionally, for number input I created two buttons for each number and added hover and click states and methods for each (in my code it's extremely messy, but it could easily be cleaned up and extracted).

I also encountered some difficulty likely caused by my own misunderstanding of how Phaser worked.

I had the following:

```
this.crew_statuses = [];
for(var i=0; i < crew.length; i++) {
	this.crew_statuses.push(...));
}
```

and then I was trying to update and draw each item iterating over that array. However, in Phaser the ideal method is to use a group and so with just my simple array it would update and draw with the updated data once, but never again. A quick change to the above code fixes it all up: 


```
this.crew_statuses = game.add.group();
for(var i=0; i < crew.length; i++) {
	this.crew_statuses.add(...);
}
```

All in all, Phaser is pretty awesome and easy to use and you can create something fairly awesome fairly quick. You can watch a video of the game I created below or you can go and [play it for yourself](http://lindseyb.github.io/kessel-run/).

<div class="youtube_resize">
	<img src="/images/youtube_placeholder.png">
	<iframe class="youtube_frame" src="http://www.youtube.com/embed/IOSKXpHCChQ?rel=0" frameborder="0" allowfullscreen></iframe>
</div>


