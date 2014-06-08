require 'active_model'
class Person
  include ActiveModel::Model
  attr_accessor :id, :name, :omg

  def initialize(attributes={})
    super
    @omg ||= true
  end
end

person = Person.new(id: 1, name: 'bob')
p person.omg # => true
p person.instance_values