class YEndstopHolder < CrystalScad::Assembly

  def show
    part(true)
  end


  def part(show)  
    
			switch = MicroswitchD3V.new(mirror_bolts:1)
#			res -= switch.show.rotate(z:180).translate(x:49,y:48.4,z:11+@args[:additional_endstop_height])
			res += switch.show.rotate(x:90).translate(x:49,y:48.4,z:11) if show

      res
  
  end

end
