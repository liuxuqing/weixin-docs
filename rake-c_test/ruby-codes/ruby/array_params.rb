class ArrayParams


  def test_array_params(*modules)
    p modules
  end

end

ap = ArrayParams.new
ap.test_array_params(:ss, :aaa)
