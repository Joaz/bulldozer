class TSlotNut < CrystalScad::Assembly

  # this is a tslot nut for 8mm nut profile

  def initialize(args={})
    @bolt_size = args[:bolt_size] || 4
    super
  end
  
  def description
    "T-Slot nut for 8mm profiles and M#{@bolt_size} thread"
  end

  def show
    res = cube(x:16,y:16,z:4.3)
    res += cube(x:16,y:8,z:6).translate(y:4)
    res.color(r:205,b:200,g:200)
  end
  
  def threads_top
    ScrewThread.new(x:8,y:8,z:8,size:@bolt_size,depth:8)  
  end

end
