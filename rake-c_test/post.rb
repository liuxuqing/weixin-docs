class Post
  attr_accessor :title

  def test(a)
    [self.title,a].join(" = ")
  end
end


