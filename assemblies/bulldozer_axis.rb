class BulldozerAxis < CrystalScad::Assembly

  def show
    part(true).rotate(x:-90).translate(x:300,y:-70,z:60)
  end
  
  def output
    part(false)
  end

  def part(show)
    tslot = TSlot.new(size:30)
    res = tslot.show(300).color("silver") # currenly the length that we have on the X axis
    
    
  end
  
end
