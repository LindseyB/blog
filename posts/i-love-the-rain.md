---
title: I LÖVE the rain
date: 2014-02-11
---
**Note**: The following article is about love 0.9.0 which includes a couple changes to the particle system so the example code won't work anything below 0.9.0

One of the coolest things about [LÖVE](http://love2d.org) is that it makes it extremely easy to play with particle systems. If you're unfamiliar with particle systems they are simply a technique for creating different effects in graphics using many small images. So basically we take a single small sprite, say a small white circle, create a bunch of them apply some effects to them and we can get the following animation: 

![simple particle system](https://i.imgur.com/I0KcpNB.gif)

As you can see in that animation the particles are all being generated at a central point (the emitter) and then spiral outward. 

Particle systems are often used for things like fire, smoke, or fog, but they can also be used for things like weather which is exactly what I sought out to do.

For LÖVE we want to do most of our particle work inside the load, this can be handled by another class but we want to make sure it's setup here and all particle systems require an image that is used as the particle. 

```
function love.load()
	particle = love.graphics.newImage("snow.png")
	rain_system = love.graphics.newParticleSystem(particle, 1000)
end
```

Here **snow.png** is a sprite of a small white circle (the same sprite used in the system above). Creating the system we need to tell our particle to use and how big the buffer for the system will be which controls how many particles we can have at once for this system.

Now we want to set up a bunch of variables for the system to control how it produces particles and how they act. This first system we are trying to create should look like rain so we want to keep that in mind when we create it to make sure it acts like rain. This step is often a lot of tweaking and changing until you get the exact effect you are looking for.

```
rain_system:setPosition(400, 0)
```

We can set the position of our emitter on the screen and all of our particles will come out of this location. In this case I put the emitter on the top of the window in the middle. Though, it would be better to find the width of the window and divide it in half to position in the middle this works for our purposes. 

```
rain_system:setEmitterLifetime(-1)
```

```setEmitterLifetime``` allows us to set how long the emitter will produce particles in this case with -1 it will be infinite, but if we want a short effect like the one in the gif above we can set this to the number of seconds we want to use. 

The lifetime of the individual particles, which controls how long they are visible, is set similarly with:

```
-- how long the particles last min, max in seconds
rain_system:setParticleLifetime(2,3.5)
```


```
rain_system:setEmissionRate(100)
```

This emission rate is how many particles the emitter spits out per second. If we wanted the rain to look lighter we could reduce this number and increasing it would make it look heavier.

```
rain_system:setSizes(0.5,0.4,0.3)
```

```setSizes``` takes a list of up to 8 numbers that effect how big the particle is over it's lifetime note that because the numbers are decreasing the particle will look smaller and smaller over time.

We can control how fast the rain falls with ```setLinearAcceleration``` and ```setSpeed```. All of these take a min and a max value so we can have some variation in our particles so they don't all look uniform. 

```
-- gravity, xmin ymix xmax ymax
rain_system:setLinearAcceleration( 1, 500, 1, 600)

-- minimum linear speed, maximum linear speed
rain_system:setSpeed(1,3)
```

Since our sprite is a white circle and rain is usually blueish in color we want to change the color our our particles.

We can use ```setColors``` to set up to 8 different colors for our particles (including alpha).

```
rain_system:setColors(0,0,255,200, 0,0,255,250, 0,0,255,255)
```

Here we are setting three colors that are all blue, but have variations in the transparency.

Since we are trying to create rain that will fill quite a bit of screen we want to set an area for our emitter. This is probably the most important part of the weather emitter since without this we end up with a single line of rain rather than a screen filled with rain. 

```
-- maximum distance from emitter (distributon, x, y)
rain_system:setAreaSpread("normal",300,0)
```

The ```"normal"``` distribution here means it's using a [Gaussian distribution](http://en.wikipedia.org/wiki/Normal_distribution). 

We can also set the direction of our emitter emits particles with ``setDirection``` but since we are creating rain the direction doesn't really matter. 

The very last thing we want make sure we do inside of ```love.load``` is start our emitter: 

```
rain_system:start()
```

Now our emitter is started, but it's not drawing anything to the screen. We need to make sure that we update our emitter inside ```love.update``` and draw it inside of ```love.draw```. If you read my previous post on creating animated spites you'll remember that ```dt``` is delta time or how much time has passed since the function was last called we pass this into our system so it knows how to modify are particles based on how much time has passed so we get a smooth animation. 

```
def love.update(dt)
	rain_system:update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.draw(rain_system)
end
```

So now we have rain, but what about snow? Let's add the following code inside of ```love.load```:

```
snow_system = love.graphics.newParticleSystem(particle, 1000)
snow_system:setEmissionRate(100)
snow_system:setSpeed(1,3)
snow_system:setLinearAcceleration(-20, 50, 20, 100)
snow_system:setSizes(0.7,0.6,0.5)
snow_system:setPosition(400,0)
snow_system:setEmitterLifetime(-1)
snow_system:setParticleLifetime(3,5.5)
snow_system:setAreaSpread("normal",300,0)
snow_system:setColors(255,255,255,200)
snow_system:stop()
```

So what's different between the two systems? 

```
snow_system:setLinearAcceleration(-20, 50, 20, 100)
```
We changed how gravity is affecting the particles here the ```xmin``` and ```xmax``` vary between -20 and 20 to create a driting effect that the particles are falling at slightly different angles. Additionally the ```ymin``` and ```ymax``` are decreased so are particles fall slowly. 

```
snow_system:setSizes(0.7,0.6,0.5)
```

Our snow particles start bigger than our rain particles, but they still decrease in size at the same rate. 

```
snow_system:setParticleLifetime(3,5.5)
```

The lifetime of the particles has been increased which is a byproduct of reducing the speed at which the particles fall. If we kept these numbers the same all of our particles would disappear before reaching the bottom of the screen. 

```
snow_system:setColors(255,255,255,200)
```

Last, we're just using a single white color here as opposed to our multiple blues. 

The video below shows both of these particle systems at work starting out with the rain system, and then switching to the snow system, and switching back to the rain system. 


<div class="youtube_resize">
	<img src="/images/youtube_placeholder.png">
	<iframe class="youtube_frame" src="http://www.youtube.com/embed/-t1MwZ-wxNs?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

The code for the example can be found on [github](https://github.com/LindseyB/love_weather) and the documentation for LÖVE particle systems can be found [on their wiki](http://love2d.org/wiki/ParticleSystem).
