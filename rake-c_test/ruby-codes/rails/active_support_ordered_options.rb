# encoding: utf-8
# 改变Hash的取值方法
require "active_support"

# Usually key value pairs are handled something like this:
#
#   h = {}
#   h[:boy] = 'John'
#   h[:girl] = 'Mary'
#   h[:boy]  # => 'John'
#   h[:girl] # => 'Mary'
#
# Using +OrderedOptions+, the above code could be reduced to:

  h = ActiveSupport::OrderedOptions.new
  h.boy = 'John'
  h.girl = 'Mary'
  h.boy  # => 'John'
  h.girl # => 'Mary'
  p h

# +InheritableOptions+ provides a constructor to build an +OrderedOptions+
# hash inherited from another hash.
#
# Use this if you already have some hash and you want to create a new one based on it.
#
  h_1 = ActiveSupport::InheritableOptions.new({ girl: 'Mary', boy: 'John' })
  p h_1.girl # => 'Mary'
  p h_1.boy  # => 'John'

  h_1.girl = "Mary_2"
  p h_1.girl


# Example: https://github.com/facebook/react-rails/blob/master/lib/react/rails/railtie.rb#L6

