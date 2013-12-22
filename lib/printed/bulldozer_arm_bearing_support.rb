class BulldozerArmBearingSupport < CrystalScad::Printed

	

	def part(show=false)
		x,y,z = 60,30,27		
		res = cube([x,y,z])


		linear = Lm_uu.new(inner_diameter:12)
			
		dia, length = linear.dimensions
		dia += 0.3
		length += 0.2

		cut = long_slot(d:dia, h:length, l:11)
		cut += long_slot(d:14, h:x+2,l:10).translate(z:-(x-length)/2-1)
	
		res-=cut.rotate(y:90,z:0).translate(x:(x-length)/2,y:y/2,z:dia*1.25)
		res+=linear.show.rotate(x:90,z:90).translate(x:(x-length)/2,y:y/2,z:dia-5) if show



	end


end
