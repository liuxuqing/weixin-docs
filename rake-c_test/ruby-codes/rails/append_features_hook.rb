# encoding: utf-8
require 'pry-rails'
module AppendFeaturesHook

  def self.append_features(base)
  	# puts "append_features"
  	@features = ["index", "add"]
  end

  def self.included(base)
  	puts "current subclass is: #{base}"
    puts "append_features: #{@features}"
  end
end

class TestAppendFeaturesHook
	include AppendFeaturesHook
  def test_pp
    binding.pry
    puts Time.now
  end
end

tfh = TestAppendFeaturesHook.new

tfh.test_pp

# include 执行 => append_features 执行 => included执行
# append_features 只是在做一个callback
