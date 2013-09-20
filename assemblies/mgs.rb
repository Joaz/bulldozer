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
	end	

	def show
		gear_distance = (@args[:big_gear]+@args[:small_gear])/2*@args[:gear_module]
		res = big_gear.translate(x:gear_distance).translate(z:4)		
		res += shaft.translate(x:gear_distance)
		res += cylinder(d:@args[:small_gear]*@args[:gear_module],h:7).translate(z:3.5)		
		res += Nema17.new.show.translate(z:-60)	

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
		res = cylinder(d:5,h:30).color("Gainsboro").translate(z:-12)
		res += drive_gear.translate(z:-9) #.rotate(x:180).translate(z:4)
	end

end
