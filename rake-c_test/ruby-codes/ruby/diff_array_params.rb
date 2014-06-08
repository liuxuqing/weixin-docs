# 数组做参数，有两种方式

# 第一种，前面加*
def test_1(name, *infos)
end
# 这种传法应该是
test_1("Dylan Deng", "27", "Male", "Ruby")
# 而在方法 test_1中会把 "27", "Male", "Ruby" 这些参数自动包装成["27", "Male", "Ruby"]
#

# 第二种是， 前面后面=[]，比较普遍型
def test_2(name, infos=[])
end

# 这种传法应该是
test_2(name, ["27", "Male", "Ruby"])
