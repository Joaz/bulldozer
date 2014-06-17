class LevelingEndstop < CrystalScad::Printed
  
  def part(show)
  
    res = cube([21,10,75])
    res += cube([31,10,20])
    
    b=Bolt.new(3,30)
    
    res -= b.output.rotate(x:90).translate(x:12,y:8,z:65)
    res += b.show.rotate(x:90).translate(x:12,y:8,z:65) if show
    
     
    switch = MicroswitchRrd.new
    res -= switch.output.rotate(x:-90,z:180).translate(x:40,y:18,z:16) 
    res += switch.show.rotate(x:-90,z:180).translate(x:40,y:18,z:16) if show
  
    if !show
      res.rotate(x:90)
    end
  
    res  
  end

end
