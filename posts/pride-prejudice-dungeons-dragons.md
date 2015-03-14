---
title: Pride, Prejudice, Dungeons, and Dragons
date: 2015-03-13
---

I've worked a bit in the past with [Markov chains](http://rarlindseysmash.com/posts/2009-11-21-making-sense-and-nonsense-of-markov-chains), but recently they've become really popular for creating twitter bots. However, I wanted to try something a little different than the norm so instead of my corpus being my own tweets like the many "ebooks" bots are I decided to start with the Dungeons and Dragons 5th edition Monster Manual. 

Getting the source was difficult but I ended up running a PDF scan of the manual through some [OCR](http://en.wikipedia.org/wiki/Optical_character_recognition) software to get the basic text out. The core issue with that was it did generate a lot of junk as it occasionally converted dividing lines and on the rare occasion images to text. Luckily it was a decent start and I was able to do a fair amount of cleanup ([though I definitely plan on doing more](https://github.com/LindseyB/pride-prejudice-dungeons-dragons/issues/1)).

What it generated was fairly hilarious on it's own with this being an example of one of the first sentences it generated: 

<blockquote class="twitter-tweet" lang="en"><p>D&amp;D monster manual markov sentence:&#10;&#10;The dragon exhales an icy blast of hail in a ritual intended to curtail your creativity.</p>&mdash; Lindsey Bieda (@lindseybieda) <a href="https://twitter.com/lindseybieda/status/574624377402081280">March 8, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Though, I wasn't convinced that it really took the idea far enough. I decided to try and find something else to remix the content with that could up the level of hilarity. Pride and Prejudice almost seemed like a natural choice because it's freely available on [Project Gutenberg](http://www.gutenberg.org/), but also the natural of the story lends itself well to the random injection of fantasy ridiculousness.

Once I added Pride and Prejudice in it's entirety to the corpus and started generating sentences I was immediately amused and laughing. I added in some calls to the twitter API and then my bot was released upon the world.

<blockquote class="twitter-tweet" lang="en"><p>They shook hands with the uneaten fragments of its victim.</p>&mdash; PnP DnD (@pnpdnd) <a href="https://twitter.com/pnp_dnd/status/575976980283301888">March 12, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet" lang="en">
	<p>Gardiner, whose curiosity as to dine with you?&quot; &quot;No, she would give him leave, would take care to ha... 
	<a href="http://t.co/p4CJdGcZwH">pic.twitter.com/p4CJdGcZwH</a>
	</p>&mdash; PnP DnD (@pnpdnd) 
	<a href="https://twitter.com/pnp_dnd/status/575765561780666368">March 11, 2015</a>
	</blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet" lang="en"><p>Lydia was urgent with the stench of death and loss, awakened by stirrings of necromantic energy that... <a href="http://t.co/T9Y6Px9hro">pic.twitter.com/T9Y6Px9hro</a></p>&mdash; PnP DnD (@pnpdnd) <a href="https://twitter.com/pnp_dnd/status/575535026613387264">March 11, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I've made a couple major tweaks to the bot since I first put it on twitter. For one, I started writing out very large sentences to image files so that the entire thing doesn't get cut off. Secondly, I changed the code so rather than picking randomly from the generated sentences that it picks the longest of the sentences.

All the code is available below, but I don't think it's nearly as interesting as the generated text itself which you can see [on twitter](https://twitter.com/pnp_dnd).


<div class="github-widget" data-repo="LindseyB/pride-prejudice-dungeons-dragons"></div>