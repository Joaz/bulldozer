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
		res = big_gear.translate(x:gear_distance).translate(z:6)		
		res += shaft.translate(x:gear_distance)
		res += motor_gear.translate(z:5.5)		
		res += Nema17.new.show.rotate(z:60).translate(z:-60)	

		hotend = JHead.new.show
		hotend += cylinder(d:3,h:150).color("Red")
	
		res += hotend.translate(x:-2.5,y:7.5,z:-80).rotate(x:-30,y:-90)
		
		
		res += idler.translate(x:15,y:-14,z:-6)

		res
	end		
	
	def idler
		idler = Bearing.new(type:"608").show
		idler += cylinder(d:8, h:16).translate(z:-5)

		idler.color("Tan")
		
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
		res += Bearing.new(type:"625").show.translate(z:-12)
		res += Washer.new(5.3).show.translate(z:14)
		res += Bearing.new(type:"625").show.translate(z:15)
		

	end

end
