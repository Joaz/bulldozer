module CrystalScad
  class ScrewThread < Cylinder
    def initialize(args)
      args[:d] = args[:size]
      super
    end
    
  end
  
  def thread(args)
    ScrewThread.new(args)
  end
  
end

class PSU_sp320_12 < CrystalScad::Assembly

  def show
    # main body
    res = cube([width=115,213,50]).color("Silver")
    # screw terminals
    res += cube([87,14.3,14.3]).translate(x:22.3,y:-14.3,z:9.4).color("black")

    # bolt mounting holes on the sides
    res += thread(size:4,h:4).rotate(y:90).translate(y:y1=32.5,z:z1=13)
    res += thread(size:4,h:4).rotate(y:90).translate(y:y2=32.5+150,z:z1)

    res += thread(size:4,h:4).rotate(y:90).translate(x:width-4,y:y1,z:z1)
    res += thread(size:4,h:4).rotate(y:90).translate(x:width-4,y:y2,z:z1)
    res += thread(size:4,h:4).rotate(y:90).translate(x:width-4,y:y1,z:z2=z1+25)
    res += thread(size:4,h:4).rotate(y:90).translate(x:width-4,y:y2,z:z2)
  
  end
  
end
