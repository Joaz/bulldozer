class BulldozerFrameAssembly < CrystalScad::Assembly

	def initialize
	  # tslot variable being the basic printer dimensions
		@tslot_x = 295	
		@tslot_y = 470	
		@tslot_z = 453 
		
		@frame_x = 640			
		@frame_y = 470+2*30			
		#@frame_z = 230

		@main_position = {x:280,y:30,z:370}
	
		@tslot_single = TSlot.new(size:30,configuration:1,simple:@tslot_simple)
		@tslot_double = TSlot.new(size:30,configuration:2,simple:@tslot_simple)

	end
	
	def show
		assembly = part
		assembly+= ZAxisAssembly.new(tslot_simple:false).show.translate(y:50).translate(@main_position)
	end

	def output
		part	
	end

	def part
		container = Container.new

		res = main_rect.translate(z:z=0)
		# slot where the printer stands on	
		res += printer_stage_rect.translate(z:z+=container.z+60+15)
	

		res += main_rect.translate(z:z+=540)
		
		@frame_z = z

		# lower base tslot
		res += tslot_rectangle(@tslot_x,@tslot_y, @tslot_double,@tslot_double).translate(@main_position) 
		res += rubber_dampener.translate(@main_position) 
	
		# upper tslot
		#res += @tslot_double.show(@frame_x-60).rotate(y:90).translate(x:30,y:370,z:@frame_z+30)
	
		
		res += container.show.translate(x:20,y:20,z:33)

		res += tslot_sides



		#spool = Spool300mm.new
		#res += spool.rotate(x:90).translate(x:-200,y:435,z:220)
		res
	end
	
	def main_rect
		tslot_rectangle(@frame_x,@frame_y, @tslot_single,@tslot_single).translate(z:30)	
	end

	def printer_stage_rect
		x,y = @frame_x,@frame_y
		size=30
		r = @tslot_double.show(x-size*2).rotate(x:-90,z:-90).rotate(x:90).translate(x:size,y:0)
		r += @tslot_double.show(x-size*2).rotate(x:-90,z:-90).rotate(x:90).translate(x:size,y:y-size*2)   

		# y
		r += @tslot_single.show(y).rotate(x:-90)
		r += @tslot_single.show(y).rotate(x:-90).mirror(x:1).translate(x:x)
		
	end

	def rubber_dampener
		res = CrystalScadObject.new
		[[0,0],[265,0],[0,440],[265,440]].each do |x,y|
			r= RubberDampener.new
			res += r.show.translate(x:15+x,y:15+y,z:-85)
		end
		res	
	end

	def tslot_sides


		# right
		res += @tslot_single.show(@frame_z+30).rotate(z:90)
		res += @tslot_single.show(@frame_z+30).rotate(z:90).translate(y:@frame_y-30)

		# left 
		res += @tslot_single.show(@frame_z+30).rotate(z:90).translate(x:@frame_x+30)
		res += @tslot_single.show(@frame_z+30).rotate(z:90).translate(x:@frame_x+30,y:@frame_y-30)


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
		
	end



end
