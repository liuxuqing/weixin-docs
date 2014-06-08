PEOPLE = ["student", "teacher", "worker"]

PEOPLE.tap do |whitelist|
  p whitelist
  whitelist << "s"
end

p PEOPLE

# tap 与 each的区别
# tap 可以把当前对象以参数的形式传入到block，并且可以更改此参数的值，以最终值返回
#


# (1..10)                .tap {|x| puts "original: #{x.inspect}"}
#       .to_a                .tap {|x| puts "array: #{x.inspect}"}
#       .select {|x| x%2==0} .tap {|x| puts "evens: #{x.inspect}"}
#       .map { |x| x*x }     .tap {|x| puts "squares: #{x.inspect}"}