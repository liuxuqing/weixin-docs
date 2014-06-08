require "active_support"

class Record
  include ActiveSupport::Callbacks
  # 定义一个callback为 +save_cb+
  define_callbacks :save_cb, :saved_cb

  def save
    # 在这个方法里调用+save_cb+方法
    run_callbacks :save_cb
    run_callbacks :saved_cb
  end
end

class PersonRecord < Record
  # 设置+save_cb+的类型以及对应的处函数
  set_callback :save_cb, :before, :saving_message

  set_callback :saved_cb, :after do |object|
    puts Time.now
  end

  def saving_message
    puts "saving..."
  end

  # 设置+save_cb+的类型以及对应的block
  set_callback :save_cb, :after do |object|
    puts "saved"
  end
end

person = PersonRecord.new
person.save

# saving...
# saved
#2014-02-27 23:40:14 +0800
