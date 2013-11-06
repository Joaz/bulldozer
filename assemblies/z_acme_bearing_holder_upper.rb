class ZAcmeBearingHolderUpper < ZAcmeBearingHolderLower
	
	def show
		part(true)
	end
	
	def output
		res = part
		res += part.mirror(x:1).translate(x:-1)
	end

	def part(show=false)
    res = tslot_mount(show,5) 
    res += tslot_mount(show).rotate(z:-90).translate(x:30) 
    
		res += cube([40,40,9]).color(@@printed_color)	
		bearing = Bearing.new(:type => "61800", :margin => 4, :margin_diameter => 0.2, :outer_rim_cut=>8, :no_bom => true)
	
		res -= bearing.output.translate(x:26,y:27,z:4)			
		#res += bearing.show.translate(x:26,y:27,z:2) if show	

		
		res
	end	

end
