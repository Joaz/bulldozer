class BulldozerFrameAssembly < CrystalScad::Assembly

	def initialize
		@tslot_x = 295	
		@tslot_y = 470	
		@tslot_z = 453	
		@tslot_single = TSlot.new(size:30,configuration:1,simple:@tslot_simple)
		@tslot_double = TSlot.new(size:30,configuration:2,simple:@tslot_simple)

	end
	
	def show
		part
	end

	def output
		part	
	end

	def part
		# lower base tslot
		res  = tslot_rectangle(@tslot_x,@tslot_y, @tslot_double,@tslot_double) 
		# upper tslot
		res += tslot_rectangle(@tslot_x,@tslot_y, @tslot_single,@tslot_single).translate(z:@tslot_z) 
	
		res += tslot_sides

		res.color("Silver")
	end
	
	def tslot_sides
		res = @tslot_double.show(@tslot_z+60).rotate(z:90).translate(z:-60)
		res += @tslot_double.show(@tslot_z+60).rotate(z:90).translate(y:@tslot_y-30,z:-60)

		res += @tslot_double.show(@tslot_z+60).rotate(z:90).translate(x:@tslot_x+60,z:-60)
		res += @tslot_double.show(@tslot_z+60).rotate(z:90).translate(x:@tslot_x+60,y:@tslot_y-30,z:-60)

	end
	

	def tslot_rectangle(x,y,tslot_type_x,tslot_type_y)
		size = tslot_type_x.args[:size]
		# x 
		r = tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:size)
		r += tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:y)   
	 
		# y
		r += tslot_type_y.show(y).rotate(x:-90)
		r += tslot_type_y.show(y).rotate(x:-90).mirror(x:1).translate(x:x)
		
		return r.color("Silver")
	end


end
