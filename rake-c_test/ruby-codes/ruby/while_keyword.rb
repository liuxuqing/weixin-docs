retry_count = 0
begin
  puts "#{retry_count}"
  # raise "Raise Exception if retry_count <= 2 " if retry_count < 2
  retry_count = 3
rescue Exception => e
  puts e
  retry_count += 1
end while retry_count < 3
