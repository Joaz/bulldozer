class Rumba < CrystalScad::Assembly
  
  def show
    res = cube([75.2,135,1.55])
    res -= cylinder(d:3.3,h:2).translate(x:3.6,y:3.6,z:-0.1)
    res -= cylinder(d:3.3,h:2).translate(x:3.6+67.4,y:3.6,z:-0.1)
    res -= cylinder(d:3.3,h:2).translate(x:3.6+67.4,y:3.6+127,z:-0.1)
    res -= cylinder(d:3.3,h:2).translate(x:3.6+32,y:3.6+127,z:-0.1)
    res = res.color("white")
    
    # usb jack
    res += cube([8,9,4.1]).translate(x:57.5,z:1.55).color("Silver")
    
    
    res
  end
  
end
