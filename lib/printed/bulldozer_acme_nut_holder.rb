class BulldozerAcmeNutHolder < CrystalScad::Printed

	def part(show=false,show_acme_and_rods=false)
		acme = AcmeNut.new
		res = cube([60,90,30]).center_y.translate(x:-45).color(@@printed_color)
		res -= cube([31,30.2,30.2]).center_y.translate(x:-45.1,z:-0.1)		

		tslot_mount = TSlotMount.new(peg:false,thickness:18,bolt_length:25)
		res+=tslot_mount.part(show).rotate(y:-90).translate(x:-40,y:15.1)
		res+=tslot_mount.part(show).rotate(y:-90).translate(x:-40,y:15.1).mirror(y:1)

		res -= acme.output.translate(z:20)
		res += acme.show.translate(z:20) if show_acme_and_rods
		
		linear_z = 1.5
		[-1,1].each do |i|	
			linear = Lm_luu.new(inner_diameter:12)
			res -= cylinder(d:21.5,h:30).translate(x:-30,y:30*i,z:linear_z)			
			res -= cylinder(d:14,h:linear_z+0.2).translate(x:-30,y:30*i,z:-0.1)
			res += linear.show.translate(x:-30,y:30*i,z:linear_z) if show_acme_and_rods
		end


		res		
	end

	def output
		part(false)+part(false).mirror(x:1).translate(x:35)
	end

	def show
		part(true)+part(true,false).mirror(z:1).translate(z:60)
	end

	
end	
