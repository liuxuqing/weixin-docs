require "pry-rails"
class Kiwi
 include Enumerable

 attr_accessor :name, :age

 def initialize(msg, name=nil, age=nil)
  @msg = msg
  @name, @age = name, age
 end

 def each
  @msg.each { |msg| yield msg * 2 }
 end

 def test_block(&block)
  yield(@msg.size)
 end

 def self.new_with_block(array, &block)
    new_instance = new(array)
    yield new_instance if block_given?
    new_instance
 end

end

kiwi = Kiwi.new([1,2,3])
# p kiwi.collect {|num| num * 2}  #=> [2, 4, 6]

# kiwi.each do |item|
#   puts item
# end

# kiwi.test_block do |size|
#   puts size
# end

kw2 = Kiwi.new_with_block([1,2,3]) do |kw| 
  puts kw
  kw.name = "name"
  kw.age = "age"
end

puts kw2
