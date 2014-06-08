require "active_support"
require 'debugger'
require 'pry-rails'

class Color
  def initialize(name)
    @name = name

    binding.pry

    # ActiveSupport.run_load_hooks(:instance_of_color, self)

  end
end

ActiveSupport.on_load :instance_of_color do
  puts "The color is #{@name}"
end

Color.new("yellow")
# => "The color is yellow"