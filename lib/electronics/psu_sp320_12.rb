class PSU_sp320_12 < CrystalScad::Assembly

  def initialize
    @x = 115
    @y1 = 32.5
    @y2= @y1+ 150
    @z1 = 13
    @z2 = @z1 + 25
  end

  def show
    # main body
    res = cube([@x,213,50]).color("Silver")
    # screw terminals
    res += cube([87,14.3,14.3]).translate(x:22.3,y:-14.3,z:9.4).color("black")

    res -= threads_left
    res -= threads_right

    res
    
  end

  def threads_left
    [ ScrewThread.new(size:4,depth:4,y:@y1,z:@z1,face:"left"),
      ScrewThread.new(size:4,depth:4,y:@y2,z:@z1,face:"left"),
      ScrewThread.new(size:4,depth:4,y:@y1,z:@z2,face:"left"),
      ScrewThread.new(size:4,depth:4,y:@y2,z:@z2,face:"left")
    ]
  end

  def threads_right
    [ ScrewThread.new(size:4,depth:4,y:@y1,z:@z1,x:@x,face:"right"),
      ScrewThread.new(size:4,depth:4,y:@y2,z:@z1,x:@x,face:"right"),
      ScrewThread.new(size:4,depth:4,y:@y1,z:@z2,x:@x,face:"right"),
      ScrewThread.new(size:4,depth:4,y:@y2,z:@z2,x:@x,face:"right")
    ]
  end

  
end
