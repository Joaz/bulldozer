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
  
		res -= cylinder(d:8,h:20).rotate(x:90).translate(x:20,y:24,z:31)
		res -= bolt.output.rotate(x:90).translate(x:20,y:4,z:31)
		res += bolt.show.rotate(x:90).translate(x:20,y:4,z:31) if show

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
		
		motor =  Nema17.new.show.rotate(x:90).translate(x:32,y:102,z:25)
    motor +=  Pulley.new.show.rotate(x:90).translate(x:32,y:42.5,z:25)
    motor += Belt.new(longest_side_length:270,top_side_length:250,position:20).show.rotate(z:-90,y:180).translate(x:32,y:30,z:25-7)
 
 		res += motor.translate(x:-9,y:-41,z:33) if show
		
		res
	end	

end
