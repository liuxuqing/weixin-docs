# module ExtendMethod
#   module ClassMethods
#     def pp
#       puts Time.now.to_s + "  ClassMethods"
#     end
#   end

#   module InstanceMethods
#     def pp
#       puts Time.now.to_s + "  InstanceMethods"
#     end
#   end

#   def self.included(receiver)
#     receiver.extend         ClassMethods
#     receiver.send :include, InstanceMethods
#   end
# end

# class User
#   include ExtendMethod
# end

# User.new.pp

# User.pp

# Time.now.utc.strftime("%Y%m%d%H%M%S")

require 'pry-rails'

module Foo
  # extend self
  def self.foo
    puts "foo"
  end
end

Foo.foo
# puts Foo.instance_methods
