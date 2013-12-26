class BulldozerArmBearingSupport < CrystalScad::Printed

	

	def part(show=false)
		z_offset = 15
		x,y,z = 30,30,15+z_offset
		res = cube([x,y,z]).center_xy


		linear = Lm_uu.new(inner_diameter:12)
		res-=cylinder(d:21.4,h:15).translate(z:z_offset)
		res-=cylinder(d:13,h:z+0.2).translate(z:-0.1)		
		res+=linear.show.translate(z:z_offset) if show

		mount = TSlotMount.new(peg:false,thickness:10,bolt_size:8,bolt_length:25,slot_length:slot_length=40)
		res+= mount.show.rotate(y:-90).mirror(y:1).translate(x:x+slot_length,y:y/2)

	end


end
