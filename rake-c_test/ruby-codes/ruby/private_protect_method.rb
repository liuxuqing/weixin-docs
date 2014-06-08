class PrivateProtectMethod

  def hehe_one
    puts self
  end

  private
    def hehe
      puts self
    end

  protected
    def hehe_protected
      puts self
    end
end

class SubPrivateProtectMethod < PrivateProtectMethod
  def hehe_one
    hehe
  end

  def hehe_second
    hehe_protected
  end
end


PrivateProtectMethod.new.hehe_one # #<PrivateProtectMethod:0x007fc9f3025de0>
SubPrivateProtectMethod.new.hehe_one # #<SubPrivateProtectMethod:0x007fdaa4830258>
SubPrivateProtectMethod.new.hehe_second # #<SubPrivateProtectMethod:0x007ff99b886c28>