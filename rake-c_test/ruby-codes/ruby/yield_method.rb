# class MyClass
#   attr_accessor :name, :address

#   def initialize(attrs = {})
#     @name = attrs[:name]
#     @address = attrs[:address]

#     yield self if block_given?
#   end
# end

# a = MyClass.new(name: 'spirit1', address: 'china1')
# p a.name

# b = MyClass.new do |i|
#   i.name = 'spirit2'
#   i.address = 'china2'
# end
# p b.name

def yield_test
	[1,2,3,4,5,6,7].each_with_index do |item, index|
		yield(item, index)
	end
end

yield_test do |x, y|
  puts "The x value: #{x} and the y value: #{y}"
end
