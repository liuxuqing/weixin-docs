class Person
end

Person.instance_eval do
  def human?
    true
  end
end

puts Person.human? # true

puts Person.new.human?