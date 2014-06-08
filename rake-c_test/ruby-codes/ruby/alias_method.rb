class AliasMethod

  def user_name
    puts "user_name"
  end

  alias :name :user_name

  def user_name
    puts "redefine user_name method"
  end

end

AliasMethod.new.name
AliasMethod.new.user_name


class Fixnum

 alias :old_plus :+

 def +(value)
  self.old_plus(value).old_plus(1)
 end

end

puts 1+1