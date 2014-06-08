# http://www.kuqin.com/rubycndocument/man/built-in-class/module_marshal.html
# The marshaling library converts collections of Ruby objects into a byte stream, allowing them to be stored outside the currently active script. This data may subsequently be read and the original objects reconstituted.

class User
  def initialize(name)
    @name = name
  end

  def say_hello
    p @name
  end
end

o = User.new("hello\n")
data = Marshal.dump(o)
obj = Marshal.load(data)
puts obj.say_hello  #=> "hello\n"
