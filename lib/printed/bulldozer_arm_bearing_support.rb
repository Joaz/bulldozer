class BulldozerArmBearingSupport < CrystalScad::Printed

	

	def part(show=false,show_bearing=false)
		z_offset = 15
		x,y,z = 28,28,15+z_offset
		res = cube([x,y,z]).center_xy.color(@@printed_color)


		linear = Lm_uu.new(inner_diameter:12)
		res-=cylinder(d:21.4,h:15).translate(z:z_offset)
		res-=cylinder(d:13,h:z+0.2).translate(z:-0.1)		
		res+=linear.show.translate(z:z_offset) if show_bearing

		mount = TSlotMount.new(peg:false,thickness:10,bolt_size:8,bolt_length:25,bolt_position:20,slot_length:slot_length=20)
		res+= mount.part(show).rotate(y:-90).mirror(y:1).translate(x:x+slot_length,y:y/2) 
		

	end

	def show
		res = part(true,true)
		res += part(true,false).mirror(z:1).translate(z:60)
		
		res += Rod.new(length:405).show.rotate(x:90).translate(x:0,y:0,z:-25)

	end

	def output
		part(false) + part(false).mirror(x:1).translate(x:63,y:-11)		
	end


end
