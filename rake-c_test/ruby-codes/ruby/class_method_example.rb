class User

  def hello
    # puts self
    self.test_self
  end

  # def respond_to?(method)
  #   puts "Do you want to find #{method} methd?"
  #   super
  # end

  def self.test_self
    puts "test_self method"
  end

  # def method_missing(method, *args)
  #   puts "you call #{method}"
  # end

  class << self
    def hello_self
      puts self
    end

    # def method_missing(method, *args)
    #   puts "you call #{method}"
    # end
  end


end

# User.new.hello()
# User.hello_self
User.new.respond_to?(:hello)
# User.hehe