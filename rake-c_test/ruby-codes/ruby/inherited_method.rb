require "debugger"
require "pry-rails"
module InheritedMethod
  def text_pp
    puts "text"
  end
end

class Foo
  def self.inherited(subclass)
    puts "New subclass: #{subclass}"
    if subclass.name == "Bar"
      subclass.class_eval do
        include InheritedMethod
      end
      # puts Time.now
      # def subclass.people
      #   Time.now
      # end
    end
  end
end

class Bar < Foo
end

class Baz < Foo
end

puts __FILE__

bar = Bar.new

puts bar
