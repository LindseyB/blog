---
title: A Little Bit of Animated Sprite LÖVE
date: 2013-12-14
---

I've been playing around with [LÖVE](http://love2d.org) lately and making a game with it. One of first problems I decided to solve was animated sprites so I decided to make an "object" (well really a table) to handle the drawing and animating of my sprite. 

![TF2 Spy Animated Sprite](https://i.imgur.com/QUaEv5G.gif)

The first bit is the creation of my ```AnimatedSprite```:

```
AnimatedSprite = {}
AnimatedSprite.__index = AnimatedSprite

function AnimatedSprite:create(file, width, height, frames, animations)
	local object = {}

	setmetatable(object, AnimatedSprite)

	object.width = width
	object.height = height
	object.frames = frames
	object.animations = animations
	object.sprite_sheet = love.graphics.newImage(file)
	object.sprites = {}
	object.current_frame = 1
	object.current_animation = 1
	object.delay = 0.08
	object.delta = 0
	object.animating = false
	object.Directions = {
		["Down"] = 1,
		["Left"] = 2,
		["Right"] = 3,
		["Up"] = 4
	}

	return object
end
```

Most of the files that I am reading in are straight forward, but a couple of the special values are ```object.delay``` which is a constant I use to set the delay between updating frames of the animation. Down below you can see ```object.Directions``` which I use elsewhere as sort of like an enumerated type to be able to easily tell the code which animation to play. The numbers associated with each direction correlate for the animations for that direction on the sprite sheet. This is extremely useful and prevents me from passing around magic numbers. 

The next step is loading in the individual sprites from the sprite sheet into the ```sprites``` table. All of this happens within the ```load``` function:

```
function AnimatedSprite:load()
	for i = 1, self.animations do
		local h = self.height * (i-1)
		self.sprites[i] = {}
		for j = 1, self.animations do
			local w = self.width * (j-1)
			self.sprites[i][j] = love.graphics.newQuad(	w,
														h,
														self.width,
														self.height,
														self.sprite_sheet:getWidth(),
														self.sprite_sheet:getHeight())
		end
	end
end
```

Fairly straight forward looping over the animations and frames within an animation. Unfortunately, this only supports the same number of frames in each animation. However, just padding out some extra frames with nothing and having the code detect those frames you can easily make this support animations with different numbers of frames in each. One important note about Lua (that you may noticed in this code) is that it is a 1-indexed language. 

Next, we need a function to tell our animation how to update. 

```
function AnimatedSprite:update(dt)
	if self.animating then
		self.delta = self.delta + dt

		if self.delta >= self.delay then
			self.current_frame = (self.current_frame % self.frames) + 1
			self.delta = 0
		end
	end
end
```
This code checks if the sprite is animating and if it is it will update the frame. The passed in ```dt``` is the delta-time for the main game loop. The ```self.delta``` keeps track of the time passed and if it has passed ```self.delay``` and if it has the frame should update and the delta gets reset back down to zero. Note here the updating of the frames uses the modulos the current_frame with the number of frames which is so the frames wrap to the beginning. However, if you have a variable number of frames ```self.frames``` should probably instead be the length of the array here. 

The next few functions are fairly straight forward,

```
function AnimatedSprite:draw(x, y)
	-- note that drawq was removed in 0.9.0 and this should just be draw
	love.graphics.drawq(self.sprite_sheet, self.sprites[self.current_animation][self.current_frame], x, y, 0, 1, 1)
end

function AnimatedSprite:set_animation(animating)
	self.animating = animating

	if not animating then
		self.current_frame = 1
	end
end

function AnimatedSprite:set_animation_direction(direction)
	self.animating = true
	self.current_animation = direction
end
```

```draw``` will draw the sprite to the screen at the provided coordinates. ```set_animation``` is used to start and stop animation and most importantly ```set_animation_direction``` uses the enumerated directions from our create to set which animation to play and tell our code that we should play the animation. 

Actual usage of all of this looks something like the following,

```
require "animated_sprite"

function love.load()
	hero = {}
	hero.x = 300
	hero.y = 400
	hero.speed = 300
	animation = AnimatedSprite:create("sprites/hero.png", 32, 32, 4, 4)
	animation:load()
end

function love.update(dt)
	animation:update(dt)

	if love.keyboard.isDown("left") then
		hero.x = hero.x - hero.speed * dt
		animation:set_animation_direction(animation.Directions.Left)
	elseif love.keyboard.isDown("right") then
		hero.x = hero.x + hero.speed*dt
		animation:set_animation_direction(animation.Directions.Right)
	elseif love.keyboard.isDown("up") then
		hero.y = hero.y - hero.speed*dt
		animation:set_animation_direction(animation.Directions.Up)
	elseif love.keyboard.isDown("down") then
		hero.y = hero.y + hero.speed*dt
		animation:set_animation_direction(animation.Directions.Down)
	elseif love.keyboard.isDown("q") then
		love.event.push('quit')
	else
		animation:set_animation(false)
	end
end

function love.draw()
	animation:draw(hero.x, hero.y)
end
```

So once LÖVE is loaded up we create our hero and the ```AnimatedSprite``` associated with the hero. We then load the animation. In our ```love.update``` which is our primary game loop we check for which keyboard keys are down and then move the hero in that direction and set the animation direction to also be that direction. Note that our ```else``` statement just calls ```set_animation(false)``` to keep our hero where they currently are and stop the animation from playing. Last we have the ```draw()``` which just calls our animation's draw function. 

In the latest version of the [code](https://github.com/LindseyB/love/tree/d3147b368d716b427ab0f5c41d7f315fcacf3eff) most of this functionality has been moved into a separate ```Hero``` object that takes care of most of these concerns.

There you have it; animated sprites in Lua using LÖVE.



