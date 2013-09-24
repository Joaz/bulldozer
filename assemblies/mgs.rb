class MGS < CrystalScad::Assembly
	def initialize(args={})
		super(args)
		@args[:gear_module] = 0.5
		@args[:big_gear] = 80
		@args[:small_gear] = 14
		#	FIXME: no bom for 
		# - gears
		# - filament drive gear
		# - shaft
		# - idler grub screw
	end	

	def show
		gear_distance = (@args[:big_gear]+@args[:small_gear])/2*@args[:gear_module]

    part = cube([50,64,2.5]).translate(x:-25,y:-38-4,z:-13)
    part += cube([21,64,6]).translate(x:4,y:-38-4,z:-13)
    part += cube([50,28,5]).translate(x:-25,y:-6,z:-13)
    
    # filament channel 
    part += cube([8,40,16]).translate(x:4,y:-12.3,z:-13)
    part += cube([8,13.6,16]).translate(x:4,y:-42,z:-13)

    part -= cylinder(d:3.25,h:150).translate(x:-2,y:7.5,z:-90).rotate(x:-30,y:-90).rotate(z:-60)

    # space for the switch
    part -= cube([5,10,7]).translate(x:2,y:12,z:-7)    
    
  

    # motor flangue
    part -= cylinder(d:22,h:10).translate(z:-16)
    # make more space for the motor gear
    part -= cylinder(d:11,h:20).translate(z:-5)

		res = big_gear.translate(x:gear_distance).translate(z:6).rotate(z:-60)		
    
    # lower shaft bearing
    bearing = Bearing.new(type:"625",margin:2,outer_rim_cut:2)
    
    part-= bearing.output.translate(x:gear_distance).rotate(z:-60).translate(z:-11.5) 
    res += bearing.show.translate(x:gear_distance).rotate(z:-60).translate(z:-11.5)

      
		res += shaft.translate(x:gear_distance).rotate(z:-60).translate(z:0.50)	
		res += motor_gear.translate(z:5.5)		
		res += Nema17.new.show.rotate(z:0).translate(z:-60)	

		hotend = JHead.new.show
	#	hotend += cylinder(d:3,h:150).color("Red")
	
		res += hotend.translate(x:-2,y:7.5,z:-90).rotate(x:-30,y:-90).rotate(z:-60)
		
		
		res += idler.rotate(z:90).translate(x:-5,y:-30,z:-11.5)

    filament_endstop = MicroswitchD3V.new
    res += filament_endstop.rotate(x:-90,z:-90).translate(x:-13,y:40,z:3)



    part+=res
   # res
		part
	end		
	
	def idler
    idler = MGSIdler.new.show
		
	end

	def motor_gear
		res = cylinder(d:@args[:small_gear]*@args[:gear_module],h:5)
		res += cylinder(d2:@args[:small_gear]*@args[:gear_module],d1:10,h:7.9).translate(z:-7.9)
		res.color("DarkGray")	
	end

	def big_gear
		res =	cylinder(d:@args[:big_gear]*@args[:gear_module],h:4)
		res += cylinder(d:20,h:8)		
		res-=cylinder(d:5,h:10).translate(z:-0.1)
		res.color("Silver")
	end

	def drive_gear
		res = cylinder(d:8,h:3)
		res += cylinder(d1:8,d2:6.1,h:1.5).translate(z:3)
		res += cylinder(d1:6.1,d2:8,h:1.5).translate(z:4.5)
		res += cylinder(d:8,h:7).translate(z:6)	
	end

	def shaft
		res = cylinder(d:5,h:30).color("Gainsboro").translate(z:-11.5)
	#	res += Washer.new(5.3).show.translate(z:5)
#		res += Washer.new(5.3).show.translate(z:4)
		res += drive_gear.translate(z:-7)
		
		#res += Bearing.new(type:"625").show.translate(z:-12)
		res += Washer.new(5.3).show.translate(z:14)
		res += Bearing.new(type:"625").show.translate(z:15)
		

	end

end
