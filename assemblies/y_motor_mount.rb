class YMotorMount < CrystalScad::Assembly
  
  
  def show
    part(true)
  end
  
  def output
    part(false)
  end
  
  def part(show)
    motor_mount = MotorMount.new
    res += motor_mount.part(show).translate(x:-12)

   
    res += slot_mount(show).rotate(x:-90).translate(y:-27,z:50)
    res += slot_mount(show).rotate(x:-90).translate(x:-30,y:-27,z:50)
         
    res
  end

  def slot_mount(show)
  	mount = cube([30,50,6]).color(@@printed_color)
  	#.translate(x:-20,y:-25) 
    
    
		mount -= long_slot(d:4.4,h:10,l:30).rotate(z:90).translate(x:15,y:10,z:0)
		bolt = Bolt.new(4,12)
		washer = Washer.new(4.3)		
		mount += bolt.show.mirror(z:1).translate(x:15,y:15,z:7) if show
		mount += washer.show.mirror(z:1).translate(x:15,y:15,z:7) if show
    mount    
  end
  
end
