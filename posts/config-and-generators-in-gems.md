---
title: Config and Generators in Gems
date: 2013-09-12
---

If you've written a gem at some point you might want to have configuration options for those people using the gem. Luckily, this is relatively easy to do with a configure block. 

The code inside your ```lib/[gemname].rb``` should look something like this:

```
module Jem
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :option

    def initialize
      @option = 'default_option'
    end
  end
end
```

The gist is here all we do is add a configure method that allows us to store whatever options we want inside of the of the Configuration class. In this case, we only have one thing to configure: **option**. However, if we were to add more, we simple just add an **attr_accessor** for each of the configuration options. 

Now from anywhere in our gem we can look at ```Jem.configuration.option``` if we want to see what that value is set to. 

Additionally, this allows us to do something like the following in our ```config/initializers/jem.rb``` to configure our gem before we use it: 

```
Jem.configure do |config|
  config.option = 'different_option'
end
```
![Jem and the Holograms](https://i.imgur.com/4pIarqZ.gif)

## Generators

Well, that's nice, but what if we want to generate the ```config/initializers/jem.rb``` for those that use our gem. Luckily, Rails provides us with [generators](http://guides.rubyonrails.org/generators.html).

Inside our **lib** folder we should create a **generators** folder and inside of that two new folders: **[gem_name]** and **templates**. 

Inside the templates folder we should put our default initializer file, such that ```lib/generators/templates/jem_initializer.rb``` looks something like the following: 

```
Jem.configure do |config|
  # Set this options to what makes sense for you
  # config.option = 'different_option'
end
```

Note that it's extremely helpful to those using your gem to have comments about what certain options do right inside the generated initializer file. 

Now we can write or generator to copy over the file when someone runs:

```
$ rails g [gemname]:install
```

We create a ```lib/generators/jem/install_generator.rb``` file to do so and it should look something like: 

```
module Jem
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates Jem initializer for your application"

      def copy_initializer
        template "jem_initializer.rb", "config/initializers/jem.rb"
        
        puts "Install complete! Truly Outrageous!"
      end
    end
  end
end
```

Every single public method inside of this class will be executed as part of the generator process. The magic line that you really care about is this one here:

```
template "jem_initializer.rb", "config/initializers/jem.rb"
```

This is what copies the contents of our initializer template over to the application's initializers. 

