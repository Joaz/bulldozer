class TSlotInsert < CrystalScad::Assembly
  
  def initialize(args={})
    args[:no_bom] = true
    super
    @args[:height] ||= 20
  end
  
  def show
    part
  end
  
  def output
    part
  end
  
  def part
    wall = cube([15.8,2,@args[:height]]).translate(x:7.1,y:2.4)
    wall += cube([8.6,4.6,@args[:height]]).translate(x:10.7,y:2.4+1.6)  
    wall += cube([7.4,2.5,@args[:height]]).translate(x:11.3,y:-0.1)  

  end

end
