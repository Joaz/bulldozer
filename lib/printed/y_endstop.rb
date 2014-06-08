class YEndstop < CrystalScad::Printed
    def part(show)
 
    mount = TSlotMount.new(peg:false)
    switch = MicroswitchRrd.new
    res = mount.part(show).rotate(x:90).translate(x:40,y:30)
  
    res += cube([switch.x,switch.y,@height=4]).color(@@printed_color)
  

    res -= switch.output.translate(z:@height+switch.height)

    res += switch.show.mirror(z:1).translate(z:@height+switch.height) if show

  

    res
  end
end
