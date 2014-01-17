class BulldozerFrameAssembly < CrystalScad::Assembly

	def initialize
	  # tslot variable being the basic printer dimensions
		@tslot_x = 295	
		@tslot_y = 495
		@tslot_z = 453 
		
		@frame_x = 600			
		@frame_y = @tslot_y+60		

		@main_position = {x:240,y:30,z:360}
	  @z_tslot_position = 355 
	  @y_plate_inner_length = @tslot_y - 65
	
	  @bulldozer_position = 0
	  @y_plate_position = 0


		@show_side_plates = true
		@door_rotation = 135
	end
	
	def tslot_single
	  TSlot.new(size:30,configuration:1,simple:@tslot_simple)
	end
	
	def tslot_double
	  TSlot.new(size:30,configuration:2,simple:@tslot_simple)
	end
	
	def show
		res = part
		res+= ZAxisAssembly.new(tslot_simple:false,position:@z_tslot_position).show.translate(@main_position)
	
		res += YPlateAssembly.new(length:@y_plate_inner_length,rod_size:12,position:-20+@y_plate_position).show.translate(@main_position).translate(z:3.5,y:30,x:35)
		res += XAxisAssembly.new(position:15+200).show.translate(@main_position).translate(z:100+0,y:@z_tslot_position,x:-2.5).translate(z:30)

		res += BulldozerAssembly.new(position:5+@bulldozer_position).show.translate(@main_position)
		res += BulldozerRodHolder.new.show(:right).translate(@main_position).translate(x:330,y:-7,z:-75)
		res += BulldozerRodHolder.new.show(:left).translate(@main_position).translate(x:-35,y:-7,z:-75)


		# bottom sheet		
		res += AluminiumCompositeSheet.new(x:@frame_x,y:@frame_y).show.translate(z:30)
		if @show_side_plates
			# top sheet
			res += AluminiumCompositeSheet.new(bolt_size:8,with_nut:false,x:@frame_x+60,y:@frame_y).show.translate(x:-30,z:@frame_z+30)

			# back wall 
			res += AluminiumCompositeSheet.new(x:@frame_x+60,y:@frame_z-@container_z).show.mirror(z:1).rotate(x:90).translate(x:-30,y:@frame_y,z:@container_z+30)


		
			# left wall
			#res += AluminiumCompositeSheet.new(x:@frame_y-60,y:@frame_z+30).show.rotate(x:90,z:90).mirror(x:1).translate(y:30)
			# right wall
			res += AluminiumCompositeSheet.new(x:@frame_y-60,y:@frame_z+30).show.rotate(x:90,z:90).translate(x:@frame_x,y:30)
		end   
    # container back wall
    
    @container_back_wall_position = 170
		res += AluminiumCompositeSheet.new(bolt_size:8,bolt_margin:1,x:@frame_x-1,y:@container_z-3-2,with_nut:false).show.rotate(x:90).translate(x:0.5,y:@frame_y-@container_back_wall_position,z:30+3)
    
    res += tslot_single.length(@container_back_wall_position).thread.show.rotate(x:90).translate(x:0,y:@frame_y,z:30+3)
    res += tslot_single.length(@container_back_wall_position).thread.show.rotate(x:90).translate(x:@frame_x-30,y:@frame_y,z:30+3)
    

		# bottom doors
		res += Door.new(sheet:DoorSheet.new(x:@frame_x/2-1,y:@container_z-1),rotation:@door_rotation,z_offset:10).show.translate(x:-0,y:-10,z:30+0.5)
		res += Door.new(sheet:DoorSheet.new(x:@frame_x/2-1,y:@container_z-1),rotation:@door_rotation,z_offset:10).show.mirror(x:1).translate(x:@frame_x,y:-10,z:30+0.5)

		# upper doors
		res += Door.new(sheet:DoorSheet.new(x:@frame_x/2-1,y:@frame_z-@container_z-60-1),rotation:@door_rotation,z_offset:10).show.translate(x:-0,y:-10,z:@container_z+60+0.5)
		res += Door.new(sheet:DoorSheet.new(x:@frame_x/2-1,y:@frame_z-@container_z-60-1),rotation:@door_rotation,z_offset:10).show.mirror(x:1).translate(x:@frame_x,y:-10,z:@container_z+60+0.5)


		# FIXME: we need a new place for electronics
		
		# FIXME: where to put spool and how will spool mounting look like?
		spool = Spool300mm.new
		res += spool.rotate(y:90).translate(x:33,y:350,z:700)
		res
	end

	def output
		part	
	end

	def part
		container = Container.new
		container2 = Container.new

		res = main_rect.translate(z:z=0)
		# slot where the printer stands on	
		@container_z = container.z+15
		res += printer_stage_rect.translate(z:z+=@container_z+60)
	

		res += main_rect.translate(z:z+=540+10)
		
		@frame_z = z


		# lower base tslot
		res += printer_rect.translate(@main_position) 
		res += rubber_dampener.translate(@main_position) 
	
		# upper tslot
		res += tslot_single.length(@frame_y-60).show.rotate(y:90,z:90).translate(x:220-13,y:30,z:@frame_z+30)
	
		
		# left container: part container
		# right container: waste container
		res += container.show.translate(x:20,y:20,z:33)
		res += container2.show.translate(x:20+280,y:20,z:33)

		res += tslot_sides

		res
	end
	
	def printer_rect
		x,y=@tslot_x,@tslot_y
		size = 30
		# x 
		res = tslot_double.length(x-size*2).threads.show.rotate(x:-90,z:-90).translate(x:size,y:size)
		res += tslot_double.length(x-size*2).threads.show.rotate(x:-90,z:-90).translate(x:size,y:y)   

		# y
		res += tslot_double.length(y).holes(side:"y").show.rotate(x:-90)
		res += tslot_double.length(y).holes(side:"y").show.rotate(x:-90).mirror(x:1).translate(x:x)
		
		res		
	end
	
	def main_rect
		x,y=@frame_x,@frame_y
		size = 30
		# x 
		res = tslot_single.length(x-size*2).threads.show.rotate(x:-90,z:-90).translate(x:size,y:size)
		res += tslot_single.length(x-size*2).threads.show.rotate(x:-90,z:-90).translate(x:size,y:y)   

		# y
		res += tslot_single.length(y).holes(side:"y").show.rotate(x:-90)
		res += tslot_single.length(y).holes(side:"y").show.rotate(x:-90).mirror(x:1).translate(x:x)
		
		res.translate(z:30)	
	end

	def printer_stage_rect
		x,y = @frame_x,@frame_y
		size=30
		r = tslot_double.length(x-size*2).threads.show.rotate(x:-90,z:-90).rotate(x:90).translate(x:size,y:0)
		r += tslot_double.length(x-size*2).threads.show.rotate(x:-90,z:-90).rotate(x:90).translate(x:size,y:y-size*2)   

		# y
		r += tslot_single.length(y).holes(side:"y").show.rotate(x:-90)
		r += tslot_single.length(y).holes(side:"y").show.rotate(x:-90).mirror(x:1).translate(x:x)
		
	end

	def rubber_dampener
		res = CrystalScadObject.new
		[[0,0],[265,0],[0,@tslot_y-30+14],[265,@tslot_y-30+14]].each do |x,y|
			r= RubberDampener.new
			t = TSlotNut.new
			assembly += r.show
			assembly += t.show.mirror(z:1).translate(r.threads_top.position_on(t.threads_top)).translate(z:18)
			res += assembly.translate(x:15+x,y:8+y,z:-71)		
		end
		res	
	end

	def tslot_sides


		# right
		res += tslot_single.length(@frame_z+30).hole(side:"x",position:@container_z+45).hole(side:"x").hole(side:"x",position:"back").show.rotate(z:90)
		res += tslot_single.length(@frame_z+30).hole(side:"x",position:@container_z+45).hole(side:"x").hole(side:"x",position:"back").show.rotate(z:90).translate(y:@frame_y-30)

		# left 
		res += tslot_single.length(@frame_z+30).hole(side:"x",position:@container_z+45).hole(side:"x").hole(side:"x",position:"back").show.rotate(z:90).translate(x:@frame_x+30)
		res += tslot_single.length(@frame_z+30).hole(side:"x",position:@container_z+45).hole(side:"x").hole(side:"x",position:"back").show.rotate(z:90).translate(x:@frame_x+30,y:@frame_y-30)


		res.color("Silver")
	end
	

end
