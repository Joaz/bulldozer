class BulldozerFrameAssembly < CrystalScad::Assembly

	def initialize
	  # tslot variable being the basic printer dimensions
		@tslot_x = 295	
		@tslot_y = 470	
		@tslot_z = 453 
		
		@frame_x = 350			
		@frame_z = 230
	
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
		res  = tslot_rectangle_with_dampeners(@tslot_x,@tslot_y, @tslot_double,@tslot_double) 
		# upper tslot
		res += tslot_rectangle(@tslot_x,@tslot_y, @tslot_single,@tslot_single).translate(z:@tslot_z) 
	
		res += tslot_sides


		container = Container.new
		res += container.show.translate(x:-270,y:30,z:-280)

		spool = Spool300mm.new
		res += spool.rotate(x:90).translate(x:-200,y:435,z:220)
	end
	
	def tslot_sides
		# middle
		res = @tslot_single.show(@tslot_z+60+@frame_z).rotate(z:90).translate(z:-60-@frame_z)
		res += @tslot_single.show(@tslot_z+60+@frame_z).rotate(z:90).translate(y:@tslot_y-30,z:-60-@frame_z)

		# right
		res += @tslot_double.show(@tslot_z+60+@frame_z).rotate(z:90).translate(x:@tslot_x+60,z:-60-@frame_z)
		res += @tslot_double.show(@tslot_z+60+@frame_z).rotate(z:90).translate(x:@tslot_x+60,y:@tslot_y-30,z:-60-@frame_z)

		# left 
		res += @tslot_double.show(@tslot_z+60+@frame_z).rotate(z:90).translate(x:-@frame_x,z:-60-@frame_z)
		res += @tslot_double.show(@tslot_z+60+@frame_z).rotate(z:90).translate(x:-@frame_x,y:@tslot_y-30,z:-60-@frame_z)

		res.color("Silver")
	end
	

	def tslot_rectangle(x,y,tslot_type_x,tslot_type_y)
		size = tslot_type_x.args[:size]
		# x 
		r = tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:size)
		r += tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:y)   

		# y
		r += tslot_type_y.show(y).rotate(x:-90)
		r += tslot_type_y.show(y).rotate(x:-90).mirror(x:1).translate(x:x)
		
		r = r.color("Silver")
	end

	def tslot_rectangle_with_dampeners(x,y,tslot_type_x,tslot_type_y)
		size = tslot_type_x.args[:size]
		# x 
		r = tslot_type_x.show(x-size*2-30).rotate(x:-90,z:-90).translate(x:size+15,y:size)
		r += tslot_type_x.show(x-size*2-30).rotate(x:-90,z:-90).translate(x:size+15,y:y)   

		# y
		r += tslot_type_y.show(y).rotate(x:-90)
		r += tslot_type_y.show(y).rotate(x:-90).mirror(x:1).translate(x:x)
		
		r = r.color("Silver")
		# add the dampeners
		r += RubberDampener.new.show.rotate(y:90).translate(x:30,y:15,z:-15)	 
		r += RubberDampener.new.show.rotate(y:90).translate(x:30,y:15,z:-15-30)	 
		r += RubberDampener.new.show.rotate(y:90).translate(x:30,y:y-15,z:-15)	 
		r += RubberDampener.new.show.rotate(y:90).translate(x:30,y:y-15,z:-15-30)	 

		r += RubberDampener.new.show.rotate(y:-90).translate(x:x-30,y:15,z:-15)	 
		r += RubberDampener.new.show.rotate(y:-90).translate(x:x-	30,y:15,z:-15-30)	 
		r += RubberDampener.new.show.rotate(y:-90).translate(x:x-30,y:y-15,z:-15)	 
		r += RubberDampener.new.show.rotate(y:-90).translate(x:x-	30,y:y-15,z:-15-30)	 


		return r
	end


end
