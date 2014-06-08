require "active_support"
require 'pry-rails'

module Foo
  extend ActiveSupport::Concern
  included do
    def self.method_injected_by_foo
      puts "Foo: method_injected_by_foo"
    end
  end
end

module Bar
  extend ActiveSupport::Concern
  include Foo

  included do
    self.method_injected_by_foo
  end
end

class Host
  include Bar # works, Bar takes care now of its dependencies
  def test_pp
    binding.pry
    puts Time.now
  end
end

host = Host.new
host.test_pp


