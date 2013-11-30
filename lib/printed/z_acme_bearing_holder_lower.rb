class ZAcmeBearingHolderLower < CrystalScad::Assembly
  
  def initialize(args={})
    super
    @args[:additional_endstop_height] ||= 32
  end
	
	def show(with_endstop_holder=true)
		part(true,with_endstop_holder)
	end
	
	def output
		res =	part
		res += part(false,false).mirror(x:1).translate(x:-2)
	end

  def tslot_mount(show, additional_wall_length=0)
    res = cube([30+additional_wall_length,5,30]).color(@@printed_color)	
    res += cube([8,5,5]).translate(x:11,y:-5).color(@@printed_color)	

		res -= long_slot(d:4.4,h:10,l:14).rotate(y:90,z:90).translate(x:15,y:-3,z:25)
		bolt = Bolt.new(4,12)
		washer = Washer.new(4.3)		
		res += bolt.show.rotate(x:90).translate(x:15,y:6,z:20) if show
		res += washer.show.rotate(x:90).translate(x:15,y:6,z:20) if show
    res
  end

	def part(show=false, with_endstop_holder=true)
    res = tslot_mount(show,5) 
    res += tslot_mount(show).rotate(z:-90).translate(x:30) 
     
		res += cube([50,38,6]).color(@@printed_color)	
		bearing = Bearing.new(:type => "625", :margin_diameter => 0.2, :outer_rim_cut=>5, :no_bom => true)
		res -= bearing.output.translate(x:26,y:27,z:2)			
		#res += bearing.show.translate(x:26,y:27,z:2) if show	
	


		# endstop
		if with_endstop_holder
			res += cube([30,2.9,30+@args[:additional_endstop_height]]).translate(x:20,y:35.1).color(@@printed_color)	
			res += cube([12,7,30+@args[:additional_endstop_height]]).translate(x:38,y:28.5).color(@@printed_color)	
			switch = MicroswitchD3V.new		
			res -= switch.show.rotate(z:180).translate(x:49,y:48.4,z:11+@args[:additional_endstop_height])
			res += switch.show.rotate(z:180).translate(x:49,y:48.4,z:11+@args[:additional_endstop_height]) if show
		end

		res
	end	

end
