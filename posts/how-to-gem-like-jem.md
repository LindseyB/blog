---
title: How to Gem like Jem
date: 2013-09-11
---
I've been looking around for a super quick start guide to first gem using bundler step-by-step. I haven't found one so I decided to document my own process. If you want the canonical and more detailed guide look here: [RubyGems Guides: Make your own gem](http://guides.rubygems.org/make-your-own-gem/).

First things first if you don't have bundler install it.

```
$ gem install bundler
```

Bundler is super awesome and will let us run a single command to generate the directory and all of the files we will need for creating our gem with the following command:

```
$ bundle gem [gemname]
```

I called my gem: Jem. 

![Jem](https://i.imgur.com/7Iyh1JW.gif)

The next thing you want to do is peek into the generated  **[gemname].gemspec** that was created when you generated your gem. You probably want to modify the description, summary, and homepage. 

```
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jem/version'

Gem::Specification.new do |gem|
  gem.name          = "jem"
  gem.version       = Jem::VERSION
  gem.authors       = ["Lindsey Bieda"]
  gem.email         = ["example@example.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
```

## Dependencies

This file also notes what the dependencies for the gem is. [RubyGems Guides: Declaring Dependencies](http://guides.rubygems.org/patterns/#declaring_dependencies) will give you more detail into what these mean, but the gist is you want to specify runtime dependencies with ```add_dependency```. These dependencies are anything that your code needs to run. Meanwhile, for gem development purposes you would specify those dependencies with ```add_development_dependency```. 

**PRO-TIP**: ```add_dependency``` is just an alias for ```add_runtime_dependency``` 

```
spec.add_dependency "rails"
spec.add_development_dependency "pry"
```

## Actual Gem Code

If your gem is super simple you can probably just dump all you code inside of the ```lib/[gemname].rb``` file. However, if you wanted multiple classes you would put those inside of the folder named for your gem inside the ```lib``` folder (e.g. ```lib/jem/```) and then make sure to require them from inside your ```lib/[gemname].rb``` file. 

If I have the file ```lib/jem/the_holograms.rb``` then my ```lib/jem.rb``` file would look something like:

```
require 'jem/version'
require 'jem/the_holograms'
```

```lib/jem/the_holograms.rb``` should look something kind of like this, depending on what you are doing, but the key thing to notice is the ```module``` line:

```
module Jem
  SONG = "Truly, Truly, Truly Outrageous"
end
```

Note: that ```require 'jem/version'``` is just requiring a file that's setting the version constant. See the first place we are using that constant? Right in the **.gemspec** file: ```gem.version       = Jem::VERSION```. 

Once you've gotten your gem where you want it you should commit your code and move on the playing with it locally. 

## Using the Gem Locally

If you want to test out your gem locally the easiest way to is create a new ruby (or rails) project and specify your gem inside the **Gemfile** like so: 

```
gem 'gem', :path => "/path/to/jem"
```

Then ```bundle``` to install the gem. 

## Going Further
- [Setting up easy to configure gems](http://robots.thoughtbot.com/post/344833329/mygem-configure-block)
- [Publishing a gem](http://guides.rubygems.org/publishing/)
- [Testing your gem](http://guides.rubygems.org/make-your-own-gem/#writing-tests)
