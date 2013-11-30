class Foot < CrystalScad::Assembly
  
  
  def show
    part(true)
  end
  
  def output
    part(false).mirror(z:1)
  end
  
  def part(show)
    res = cylinder(d:25,h:25)
    b = Bolt.new(4,25)
    res -= cylinder(d:12,h:7.1).translate(z:-0.1)        
    res -= b.output.translate(z:7)
    res += b.show.translate(z:7) if show
    
    res
  end

end
