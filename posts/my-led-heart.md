---
title: My LED Heart
date: 2015-02-28
---

I recently took my first dive into soldering with Adafruit's [MiniPOV 3 Kit](http://www.adafruit.com/product/20). To my surprise I got it working and also didn't burn myself in the process. 

![Device just after soldering](http://i.imgur.com/dQDNhAg.gif)

My next challenge was to actually get some of the example code running on the thing, which took grabbing [this](http://www.amazon.com/gp/product/B00425S1H8/) since I don't presently own a machine with a serial port anymore. Along with [these drivers](https://www.mac-usb-serial.com/dashboard/) and [CrossPack for AVR](http://www.obdev.at/products/crosspack/index.html) I was finally in business to get some code on the thing.

I decided I wanted to be able to quickly draw something in a BMP and generate a C file that would display the image using persistence of vision on the device. So I opened up paint and doodled the following:

![Source BMP](http://i.imgur.com/VEngO1X.png)

Using some of the example code provided by Adafruit I began to write some ruby code to generate the C file (which in turn would generate a hex file to actually flash the device with). I thought the hard part was going to be reading in the BMP pixel by pixel because I didn't want to require rmagick or imagemagick as a dependency (because both libraries are a pain for something so simple). Luckily, [Practicing Ruby](https://practicingruby.com/articles/binary-file-formats) has a really awesome article that goes through code to read a BMP. 

In the end the code itself is extremely simple. I read in the BMP and generate lines of the C file based on what I read in from the image. I assume the image is 8 pixels in height and N pixels in length. Though, technically it would be smart to verify which dimension is 8 pixels and adapt accordingly or throw and error if that isn't the case. 

```
require './BMP.rb'

bmp = BMP.new("heart.bmp")

File.open("bmp.c", 'w') do |file|
	start_file = File.open("start_c.txt")
	IO.copy_stream(start_file, file)
	for x in 0...bmp.width
		bitstr = ""
		for y in 0...bmp.height
			if bmp[x,y] == "000000"
				bitstr+="0"
			else
				bitstr+="1"
			end
		end
		file.puts("B8(#{bitstr}),")
	end
	end_file = File.open("end_c.txt")
	IO.copy_stream(end_file, file)
end
```

The other main assumption is that black is off and any other color is on, but other than that the code is fairly simple and straightforward. The C code it generates is a bit more complex, so I won't explain it in detail here, but you can look at it on [github](https://github.com/LindseyB/bmp-to-pov/blob/master/bmp.c).

You can see the results of this code below and you can view all of the code in the [repo](https://github.com/LindseyB/bmp-to-pov).

![Device in motion](http://i.imgur.com/TyRwDpM.gif)