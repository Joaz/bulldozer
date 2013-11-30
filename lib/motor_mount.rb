class MotorMount < CrystalScad::Assembly
  
  
  def show
    part(true)
  end
  
  def output
    part(false)
  end
  
  def part(show)
  	motor =  Nema17.new
  	motor_model = motor.show.rotate(x:0).translate(z:-47)
    motor_model +=  Pulley.new.show.mirror(z:1).translate(z:17)
    
		res += cube([42,42,6]).center_xy
		# use only 3 bolts
  	res -= cube([42,42,6.2]).translate(x:-11,z:-0.1)
  	res -= cube([42,42,6.2]).translate(y:-11,z:-0.1)
  
  
    # flange hole
		res -= cylinder(d:24,h:20).translate(x:0,y:0,z:-0.1)		
     
    # FIXME: no bolts here in BOM
	  # screw holes
		[-1,1].each do |i|	
			[-1,1].each do |f|	
				res-= cylinder(d:3.2,h:20,center:true).translate(x:i*15.7,y:f*15.7,z:0)
			end
		end
    
    res = res.color(@@printed_color)
    
    res += motor_model if show
   
    res
  end
  
end
