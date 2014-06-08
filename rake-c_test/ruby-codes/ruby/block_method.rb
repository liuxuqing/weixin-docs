require "pry-rails"
require "pry-debugger"

class Block
  def self.use_block(&block)
    yield block
  end

  def method_missing(method_id, *arguments, &block)
    puts "no method"
    if method_id =~ /find/
      self.class.class_eval do
        define_method(method_id) do |arg|
          arg
        end
      end
      arguments.first
    else
      super
    end
  end
end

# Block.use_block do
#   puts Time.now
# end

# pro = Proc.new {puts "proc test"}

# puts pro

# Block.use_block(pro)

puts Block.new.find(1)
binding.pry
puts Block.new.find(18888)
