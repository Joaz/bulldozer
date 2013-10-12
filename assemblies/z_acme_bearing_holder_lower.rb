class ZAcmeBearingHolderLower < CrystalScad::Assembly
	
	def show
		part(true)
	end
	
	def output
		res =	part
		res += part(false,false).mirror(x:1).translate(x:-2)
	end

	def part(show=false, with_endstop_holder=true)
		# bearing holder needs to be moved to a separate part to have a good 
		# tool access to the motor mounting bolts
		res = cube([30,5,30]).color(@@printed_color)	

		res += cube([50,38,6]).color(@@printed_color)	
		bearing = Bearing.new(:type => "625", :margin_diameter => 0.2, :outer_rim_cut=>5, :no_bom => true)
	
		res -= bearing.output.translate(x:26,y:27,z:2)			
		#res += bearing.show.translate(x:26,y:27,z:2) if show	

		res -= long_slot(d:4.4,h:10,l:14).rotate(y:90,z:90).translate(x:15,y:-3,z:25)

		bolt = Bolt.new(4,12)
		washer = Washer.new(4.3)		
		res += bolt.show.rotate(x:90).translate(x:15,y:6,z:20) if show
		res += washer.show.rotate(x:90).translate(x:15,y:6,z:20) if show

		# endstop
		if with_endstop_holder
			res += cube([30,2.9,30]).translate(x:20,y:35.1).color(@@printed_color)	
			res += cube([12,7,30]).translate(x:38,y:28.5).color(@@printed_color)	
			switch = MicroswitchD3V.new		
			res -= switch.show.rotate(z:180).translate(x:49,y:48.4,z:11)
			res += switch.show.rotate(z:180).translate(x:49,y:48.4,z:11) if show
		end

		res
	end	

end
