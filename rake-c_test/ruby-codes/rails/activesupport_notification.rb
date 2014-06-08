require "active_support"
require "pry-rails"

events = []

ActiveSupport::Notifications.subscribe('render') do |*args|
  events << ActiveSupport::Notifications::Event.new(*args)
end

ActiveSupport::Notifications.instrument('render', extra: :information) do
  puts "ssss"
end

event = events.first
event.name      # => "render"
event.duration  # => 10 (in milliseconds)
event.payload   # => { extra: :information }
binding.pry
