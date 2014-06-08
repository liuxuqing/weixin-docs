class Dht
  attr_accessor :age, :sex

end

dht = Dht.new#(age: 14, sex: "F")
dht.age = 15
dht.sex = "F"
puts dht.attributes
