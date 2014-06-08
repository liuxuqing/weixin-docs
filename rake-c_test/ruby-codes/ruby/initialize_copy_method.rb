class Document    #Reopen the class
  attr_accessor :title, :text
  attr_reader :timestamp

  def initialize(title, text)
    @title, @text = title, text
    @timestamp = Time.now
  end

  def initialize_copy(other)
    @timestamp = Time.now
  end
end

doc3 = Document.new("More Stuff", "Haha")
sleep 2
doc4 = doc3.dup

puts doc3.timestamp == doc4.timestamp  #=> false

# initialize_copy 当对象进行dup或者clone时，会被调用
# clone 是会复制关联方法一个完整的结构

# user = User.first
#<User id: 1, email: "dylan@beansmile.com", encrypted_password: "$2a$10$o6/rpGbniA6WGaMcFqUpXOw3NDBCraki4XtaFC2pF66/...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2014-02-17 14:55:26", last_sign_in_at: "2014-02-14 16:24:04", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", created_at: "2014-02-07 18:05:39", updated_at: "2014-02-17 14:55:26">

# clone: user.clone
#<User id: 1, email: "dylan@beansmile.com", encrypted_password: "$2a$10$o6/rpGbniA6WGaMcFqUpXOw3NDBCraki4XtaFC2pF66/...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2014-02-17 14:55:26", last_sign_in_at: "2014-02-14 16:24:04", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", created_at: "2014-02-07 18:05:39", updated_at: "2014-02-17 14:55:26">

# dup: user.dup, 只是复制内容
#<User id: nil, email: "dylan@beansmile.com", encrypted_password: "$2a$10$o6/rpGbniA6WGaMcFqUpXOw3NDBCraki4XtaFC2pF66/...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2014-02-17 14:55:26", last_sign_in_at: "2014-02-14 16:24:04", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", created_at: nil, updated_at: nil>

