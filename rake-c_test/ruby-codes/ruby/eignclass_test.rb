require "debugger"

class Person

end

person = Person.new
eigenclass = class << person
  self
end

superclass = class << Person
  self
end

puts Person
puts eigenclass
# puts eigenclass.class
debugger
puts superclass