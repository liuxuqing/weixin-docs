module SuperWithInclude

  def initialize(params={})
    puts params
  end

end


class Person
 include SuperWithInclude

 def initialize(params={})
   puts "Person initialize"
   super
 end

end

Person.new(name: "Dylan Deng", age: 27)
