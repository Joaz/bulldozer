class ZRodHolder < CrystalScad::Assembly
	def initialize(args={})
		@motor_mount_thickness = 6
	end


	def output
		res = part(false)
	
		res+=	part(false).mirror(x:1).translate(x:-50)
	end

	def part(show)
    res = cube([46,46,@motor_mount_thickness]).center_xy.translate(x:1)
    res -= cube([46,46,@motor_mount_thickness+0.2]).center_xy.translate(x:-20,y:5,z:-0.1)
    	
    res = res.color(@@printed_color)	
    
	  mount = TSlotMount.new(additional_wall_length:13)
	  res += mount.part(show).translate(x:-23,y:-28)
	  mount = TSlotMount.new(thickness:13,bolt_length:25)
	  res += mount.part(show).rotate(z:-90).translate(x:7,y:-28)
		
    # 10mm rod hole   
    res -= cylinder(d:10.4,h:@motor_mount_thickness+0.2).translate(x:17,y:2,z:-0.1)


		res
	end

end

