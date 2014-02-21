class YzBracket < CrystalScad::Printed
	def initialize
		@base_thickness = 14
		@wall_thickness = 8
		@wall_height	 = 60
	end
	
	def part(show)
		# base		
		res = cube([60,30,@base_thickness])
		res -= long_slot(d:4.4,l:15,h:@base_thickness+0.2).translate(x:7,y:15,z:-0.1)
		res -= long_slot(d:4.4,l:15,h:@base_thickness+0.2).translate(x:7+30,y:15,z:-0.1)

		# wall to the y axis
		
		wall = cube([60,@wall_thickness, @wall_height])
		wall -= long_slot(d:4.4,l:40,h:@wall_thickness+0.2).rotate(y:90,z:90).translate(x:15,y:-0.1,z:50)	
		wall -= long_slot(d:4.4,l:40,h:@wall_thickness+0.2).rotate(y:90,z:90).translate(x:45,y:-0.1,z:50)	

		res += wall.translate(z:@base_thickness)
		res.color(@@printed_color)
	

	end

end
