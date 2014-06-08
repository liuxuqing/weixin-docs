require 'pry-rails'

# module Foo
#   def foo
#     puts "foo"
#   end
# end

# class Object
#   include Foo
# end

# class Person; end

# Person.new.foo



module M
 def greet
   "hello from M"
 end
end

include M

class C; end

c = C.new

puts c.greet
puts C.greet
