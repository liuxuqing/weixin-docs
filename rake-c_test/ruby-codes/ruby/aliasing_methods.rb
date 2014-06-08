class AliasingMethods

  def the_first_method

  end

  def the_first_method(name)
    puts "#{name}"
  end

end

AliasingMethods.new.the_first_method :name


String.class_eval do
 def text_value
  puts "text value"
 end
end

"sss".text_value