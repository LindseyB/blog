---
title: Stupid Programmer Tricks and Star Wars Gifs
date: 2013-10-27
---

![Hard G vs Soft G](https://i.imgur.com/ns3sMmh.gif)

Gifs, I love gifs and ssome of you may also know that I love Star Wars. At some point I tried to make and subtitle a gif by hand since I was unable to find what I was looking for. This was the result of an hour of effort:

![I feel terrible.](http://i.imgur.com/B7n9Vos.gif)

Queue the informercial music and the "there must be an easier way". I'm a programmer, so naturally my solution to everything is to write some code to solve the problem for me. A simple way to get Star Wars gifs by the quote. After all, [it's been done before](http://wirescenes.tumblr.com/).

I opted to write the whole thing in Python since I rarely ever write Python and I would still very much so consider myself a Python novice. I also initially set out to write it in Python 3 on Windows and I threw out both of those ideas when it ended up being way more of a challenge than it was worth.

The first step of capturing the frames from the movies is where the post gets it's name. I have a tendency to misuse VLC in code. In the command line based game [Ascii Ascii Revolution](https://github.com/LindseyB/AsciiAsciiRevolution) all the audio/music playing is done via cvlc.  I love vlc for this kind of thing because you can do almost anything in it by just passing in a bunch of command line arguments.

If you're curious this is what the command looks like in the code to tell VLC to capture frames in a movie for a duration:

```
cmd = '"{0}" -Idummy --video-filter scene -V dummy --no-audio --scene-height=256 --scene-width=512 --scene-format=png --scene-ratio=1 --start-time={3} --stop-time={4}  --scene-prefix=thumb --scene-path="{1}"  "{2}" vlc://quit'.format(vlc_path, screencap_path, video_path, start, end)
```

It's long and it's ugly, but it works like a damn charm. VLC takes care of pretty much the most difficult part and then you can start mashing all the files into a gif. [Images2gif.py](https://code.google.com/p/visvis/source/browse/images2gif.py?r=d82415598349aa47ba3d5b226124fc9b6ba72353) makes this next part dead simple. It is slower than doing it with ImageMagick, but the pro is that you don't have to deal with ImageMagick.

The next step was getting a listing of quotes. Luckily, the pirate community loves sharing subtitle files online, which makes this also simple. Well... what about the UI? UI is hard. I originally wanted to do the UI with just ncurses, but then I discovered [Urwid](http://excess.org/urwid/) which is awesome and easy to use and the following interface was born:

<div class="youtube_resize">
	<img src="/images/youtube_placeholder.png">
	<iframe class="youtube_frame" src="http://www.youtube.com/embed/n387eBqnw1o?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

Nothing about any of the pieces to get this code working was hard. It was just a matter of finding the correct pieces, leveraging VLC to do the hard work, and mashing it all together.

![Generated Star Wars Gif](star_wars.gif)

I wanted to take it further and so for a company hack-a-thon I did. Not everyone was going to download the code and get it running (it can be a pain in the ass). So, I decided to make a twitter bot that would tweet a random gif every hour. Sharing Star Wars gifs for the betterment of humanity.

<blockquote class="twitter-tweet"><p>&quot;Let the hate flow through you.&quot; <a href="http://t.co/OPlgJwqKfl">http://t.co/OPlgJwqKfl</a> <a href="https://twitter.com/search?q=%23starwarsgif&amp;src=hash">#starwarsgif</a></p>&mdash; Star Wars Gifs (@StarWarsDotGif) <a href="https://twitter.com/StarWarsDotGif/statuses/393818442673168384">October 25, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

If tumblr is more your speed I've rolled out a [tumblr bot](http://starwarsgifsasaservice.tumblr.com/).

You can check out all of the code on [Github](https://github.com/LindseyB/starwars-dot-gif).



