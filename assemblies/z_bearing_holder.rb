class ZBearingHolder < CrystalScad::Assembly
	
	def show
		part(true)
	end
	
	def output
		part
	end

	def part(show=false)
		res = cylinder(d:28.5,h:60)
		
		res += cube([30,24,46]).center_xy.translate(x:15)
		res += cube([30,30,16]).center_xy.translate(x:15,y:-27)

	  res -= cylinder(d:21.5,h:70).translate(z:-0.1)        
		# lm12uu/lm12luu will be glued inside		
	#  res -= cylinder(d:13.5,h:40)        
  
		bolt = Bolt.new(4,25)
  
		res -= cylinder(d:8,h:20).rotate(x:90).translate(x:20,y:24,z:35)
		res -= bolt.output.rotate(x:90).translate(x:20,y:4,z:35)
		res += bolt.show.rotate(x:90).translate(x:20,y:4,z:35) if show

		# lower bolt
		bolt = Bolt.new(4,25)  
#		res -= cylinder(d:8,h:20).rotate(x:90).translate(x:20,y:24,z:35)
		res -= bolt.output.translate(x:15,y:-27,z:0)
		res += bolt.show.translate(x:15,y:-27,z:0) if show

		# inserted for BOM
		# TODO: output them on show 
		Lm_uu.new(inner_diameter:12)
		Lm_uu.new(inner_diameter:12)
	
		# TODO: Add x motor holder to that
		
		res
	end	

end
