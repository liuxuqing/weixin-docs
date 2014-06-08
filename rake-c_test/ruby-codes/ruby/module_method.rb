module Forem
  # mattr_accessor :user_class
  def user_class
    puts "This is using module_function to define user_class method"
  end

  def self.test_user
    puts self#.user_class
  end
  module_function :user_class
  # class << self
  #   def user_class
  #     puts Time.now
  #   end
  # end
end

# Forem.user_class

# Forem.test_user

puts Forem.ancestors