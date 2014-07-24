class ZMotorMount < CrystalScad::Printed

	def initialize(args={})
		@motor_mount_thickness = 6
	end

	def show
		part(true).rotate(z:180).translate(x:30,y:3)
	end

	def output
	  res =	part(false)#.rotate(x:90,z:90)
		res+=	part(false).mirror(x:1).translate(x:-50)
		res
	end

  def motor_mount_base(show)
		motor = Nema17.new
    res = cube([46,46,@motor_mount_thickness]).center_xy.translate(x:1)
    
  	res -= cylinder(d:24,h:@motor_mount_thickness+0.2).translate(z:-0.1)		
    res = res.color(@@printed_color)	
  	res += motor.show.translate(z:-47) if show
		
		# screw holes
		[-1,1].each do |i|	
			[-1,1].each do |f|	
				bolt = Bolt.new(3,10)
				res -= bolt.output.translate(x:i*15.7,y:f*15.7)
				res += bolt.show.mirror(z:1).translate(x:i*15.7,y:f*15.7,z:@motor_mount_thickness) if show
		
			end
		end

	
    res
  end

	def part(show)
		res = motor_mount_base(show)
	
	  mount = TSlotMount.new(additional_wall_length:13)
	  res += mount.part(show).translate(x:-23,y:-28)
	  mount = TSlotMount.new(thickness:13,bolt_length:25)
	  res += mount.part(show).rotate(z:-90).translate(x:7,y:-28)
		
    # 10mm rod hole   
    res -= cylinder(d:10.4,h:@motor_mount_thickness+0.2).translate(x:17,y:-2,z:-0.1)


		res
	end

end
