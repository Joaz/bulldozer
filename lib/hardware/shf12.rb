class SHF12 < CrystalScad::Assembly

  def initialize(args={})
    @w=47 # width
    @b=36 # bolt width
    @height=13
    @height2=7
    @g=25
  end

  def show
    res = part(true)

    [0,1].each do |i|
      bolt = Bolt.new(5,16,washer:true)
      nut = TSlotNut.new(bolt_size:5)
      b = bolt.show.mirror(z:1)
      
      b += nut.show.translate(nut.threads_top.position_on(bolt)).translate(z:-6) 
      res += b.translate(threads_bottom[i].position_on(bolt)).translate(z:@height2)
    end
    res     
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
    res
  end
  
  def threads_bottom
    [
      ScrewThread.new(size:5,depth:@height2,x:-@b/2),
      ScrewThread.new(size:5,depth:@height2,x:@b/2)
    ]
  end

end
