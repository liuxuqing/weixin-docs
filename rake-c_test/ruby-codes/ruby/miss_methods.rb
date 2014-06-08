require "pry-rails"
class MissMethod

  attr_accessor :person

  def initialize
    @person = [
      { 
        "name" => "name1",
        "age"  => 12
      },

      { 
        "name" => "name1",
        "age"  => 12
      },

      { 
        "name" => "name1",
        "age"  => 12
      }
    ]
  end

  def method_missing(meth, *args, &block)
    if meth.to_s =~ /^find_by_(.+)$/
      run_find_by_method($1, *args, &block)
    else
      super # You *must* call super if you don't handle the
            # method, otherwise you'll mess up Ruby's method
            # lookup.
    end
  end

  def run_find_by_method(attrs, *args, &block)
    @person.each do |people|
      return people if people[attrs.to_s] == args.first
    end
  end

end

miss_method = MissMethod.new

puts miss_method.find_by_age(12)
