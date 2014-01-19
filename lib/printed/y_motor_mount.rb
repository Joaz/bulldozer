class YMotorMount < CrystalScad::Assembly
  
  
  def show
    part(true)
  end
  
  def output
    part(false)
  end
  
  def part(show)
    motor_mount = MotorMount.new(thickness:26,bolt_height:30)
    res += motor_mount.part(show)
		mount = TSlotMount.new(thickness:18,bolt_length:25)
   	
		res += mount.part(show).translate(x:-42-9).mirror(y:1)

			 
    res
  end

  
end
