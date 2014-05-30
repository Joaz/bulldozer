class YEndstop < CrystalScad::Printed
    def part(show)
 
    mount = TSlotMount.new
    res = mount.part(show).rotate(x:90).rotate(z:90)
  
    
  
    switch = MicroswitchRrd.new
    sw_mount = switch.show.rotate(x:90,z:180).translate(x:31,y:30) if show

    sw_mount += cube([40+10,8,16+4]).translate(x:-9-10,y:22).color(@@printed_color)
    sw_mount -= cube([13,2.5,16]).translate(x:-2,y:28.5)
    sw_mount -= cube([9,2.5,16]).translate(x:16.5,y:28.5)
 
    sw_mount -= cylinder(d:3.5,h:20).rotate(x:90).translate(x:-5,y:33,z:13.5)
    sw_mount -= cylinder(d:3.5,h:20).rotate(x:90).translate(x:-5+19,y:33,z:13.5)
  
    
    res += sw_mount.rotate(y:180).translate(x:-10,y:-4,z:20)
  

    res
  end
end
