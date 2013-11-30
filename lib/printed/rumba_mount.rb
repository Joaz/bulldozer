class RumbaMount < CrystalScad::Assembly
  
  
  def show
    res = cube([75.2+15,135,3]).translate(x:-15)
    res += cube([30,135,15]).translate(x:-45)
    
    res -= long_slot(d:4.4,h:20,l:100).rotate(z:90).translate(x:-30,y:20)
    
    res -= cylinder(d:3.3,h:5).translate(x:3.6,y:3.6,z:-0.1)
    res -= cylinder(d:3.3,h:5).translate(x:3.6+67.4,y:3.6,z:-0.1)
    res -= cylinder(d:3.3,h:5).translate(x:3.6+67.4,y:3.6+127,z:-0.1)
    res -= cylinder(d:3.3,h:5).translate(x:3.6+32,y:3.6+127,z:-0.1)
    res = res.color(@@printed_color)
    
    
  end
  
  def output
    show
  end

end
