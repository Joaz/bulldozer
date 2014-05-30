class ZEndstop < CrystalScad::Printed


  def part(show)
 
    mount = TSlotMount.new
    res = mount
  
    
  
    switch = MicroswitchRrd.new
    res += switch.show.rotate(x:90,z:180).translate(x:31,y:30) if show

    res += cube([40,8,16]).translate(x:-9,y:22).color(@@printed_color)
    res -= cube([13,2.5,16]).translate(x:-2,y:28.5)
    res -= cube([9,2.5,16]).translate(x:16.5,y:28.5)
 
    res -= cylinder(d:3.5,h:20).rotate(x:90).translate(x:-5,y:33,z:13.5)
    res -= cylinder(d:3.5,h:20).rotate(x:90).translate(x:-5+19,y:33,z:13.5)
  
    res += cube([30,22,5]).color(@@printed_color)
 
 
  

    res
  end
    
end
