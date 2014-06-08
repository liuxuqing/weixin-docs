
3.times.each do |variable|
  begin
     1/0
  rescue => err
    raise err
  end
end

