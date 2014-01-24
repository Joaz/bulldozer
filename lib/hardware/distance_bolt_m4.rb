class DistanceBoltM4 < CrystalScad::Assembly

  # http://www.ettinger.de/Art_Detail.cfm?ART_ARTNUM=05.14.091
  def initialize(args={})
    @side_to_side = 7
    @height = 9
    @inner_thread_length = 4.5
    @outer_thread_length = 8
  end
  
  def part(show)
    nut = cylinder(d:(@side_to_side/Math.sqrt(3))*2,h:@height,fn:6)
    nut +=threads_top.show
    nut -=threads_bottom.show.translate(z:-0.01)
    nut.color(r:180,g:180,b:180)
  end

  def threads_top
    ScrewThread.new(x:0,y:0,z:@height,size:4,depth:@outer_thread_length)  
  end

  def threads_bottom
    ScrewThread.new(x:0,y:0,z:0,size:4,depth:@inner_thread_length)  
  end

end
