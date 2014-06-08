require "pry-rails"

class UseDefineMethodMissMethod

  def method_missing(method_name, *args, &block)
    if not self.class.singleton_methods.include?(method_name.to_s)
      puts "defining #{method_name} name: "
      self.class.send(:define_method, method_name) do |*args|
        return "#{method_name}: #{Time.now}, args: #{args.to_s}"
      end
    end
    self.send(method_name)
  end
end

test = UseDefineMethodMissMethod.new

puts test.age(1)

sleep 2

puts test.age(2)
