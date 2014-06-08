module Person
  def about_me_one
     puts "This is about me."
  end

  def self.included(c)
    puts "included_#{c}"
    class << c
      def student_class_evelt
        puts "student_class_evelt"
      end
    end
    def c.hello_me
      puts "hello me"
    end
    def about_me
      puts "hwhwh"
    end
  end

  def self.call_me
    puts self
  end
end

class Student
  include Person
end

student = Student.new
# student.about_me # puts "This is about me."
# Student.call_me # 没有定义此方法，抛出异常。
Person.call_me
# Student.hello_me
puts


puts Person.public_instance_methods

puts

puts Student.singleton_methods
