class Person
end

Person.class_eval do
  def say_hello
   "Hello!"
  end
end

Person.instance_eval do
  def say_hello
   "Hello!ss"
  end
end

class Object
  def hello_p
    "Hello p!!"
  end
end

jimmy = Person.new
puts jimmy.say_hello # "Hello!"
puts jimmy.hello_p()

puts Person.say_hello
p Person.ancestors