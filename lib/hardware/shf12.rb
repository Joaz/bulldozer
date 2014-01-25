class SHF12 < CrystalScad::Assembly

  def initialize(args={})
    @w=47 # width
    @b=36 # bolt width
    @height=13
    @height2=7
    @g=25
  end

  def part(show)
    cyl = cylinder(d:@g,h:@height2)
    wall = cube([1,10,@height2]).center_y.translate(x:@w/2-1)
    
    res = hull(cyl,wall)
    res += hull(cyl,wall).mirror(x:1)
    res += cylinder(d:@g,h:@height)

    
    res -= cylinder(d:12,h:@height+0.2).translate(z:-0.1)
    res = res.color(r:120,g:120,b:120)
    res -= threads_bottom
     
  end
  
  def threads_bottom
    [
      ScrewThread.new(size:4,depth:@height2,x:-@b/2),
      ScrewThread.new(size:4,depth:@height2,x:@b/2)
    ]
  end

end
