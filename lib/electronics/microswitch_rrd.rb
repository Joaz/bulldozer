class MicroswitchRrd < CrystalScad::Assembly

  def part(show)
    res = cube([40,16,1.6]).color("white")
    # switch
    res += cube([13,6.5,6]).translate(x:20,y:10,z:1.6).color("black")
    
    res -= cylinder(d:3.5,h:2).translate(x:17,y:13.5,z:-0.1)
    res -= cylinder(d:3.5,h:2).translate(x:17+19,y:13.5,z:-0.1)
    res -= cylinder(d:3.5,h:2).translate(x:2,y:13.5,z:-0.1)
    
    res
  end
end
