class YAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args = args
    @args[:length] ||= 430
    @args[:rod_size] ||= 12    
    @args[:position] ||= 150 
    @args[:bed_size_x] ||= 225
    @args[:bed_size_y] ||= 225       
    @args[:bed_size_z] ||= 12
		@args[:tslot_x] ||= 295
		@args[:tslot_y] ||= 495
		@tslot_x,@tslot_y = @args[:tslot_x],@args[:tslot_y]
  end
  
  def show
		fixed = printer_rect
    bed_plate=BedPlate.new(x:@args[:bed_size_x],y:@args[:bed_size_y],z:@args[:bed_size_z])
    holder_left=BedPlateBearingMount.new
    fixed += Rod.new(length:@args[:length]).show.translate(y:2,x:holder_left.rod_position_x,z:holder_left.rod_position_z)   
    fixed += Rod.new(length:@args[:length]).show.translate(y:2,x:@args[:bed_size_x]-holder_left.rod_position_x,z:holder_left.rod_position_z)      
    
    moving_table = holder_left.output.translate(x:0,z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/2)          
    # holders on the right side
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/5)          
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/5*4)          
   
    moving_table += bed_plate.show.translate(z:-1)
    moving_table += CarbonFibrePlate.new.show.translate(x:12,y:12,z:20)

		fixed += YMotorMount.new.show.rotate(z:-180).rotate(y:-90).translate(x:125,y:413,z:-32)

		fixed += Belt.new.show.translate(x:115,y:12,z:-14)
		moving_table += YBeltHolder.new.show.translate(x:100,y:@args[:position]-50,z:3)
		fixed += YBeltIdler.new.show.rotate(y:90).translate(x:88,y:40,z:-8)

		fixed += YRodHolder.new.show.rotate(x:90).translate(x:20,y:440,z:-12)
		fixed += YRodHolder.new.show.rotate(x:90).mirror(x:1).translate(x:20+185,y:440,z:-12)
		fixed += YRodHolder.new.show.rotate(x:90).mirror(y:1).translate(x:20,y:30,z:-12)
		fixed += YRodHolder.new.show.rotate(x:90).mirror(y:1).mirror(x:1).translate(x:20+185,y:30,z:-12)

		fixed += YEndstopHolder.new.show.translate(y:438,z:-5)

    

		assembly = fixed + moving_table.translate(y:@args[:position])
    
  end

	def tslot_double
	  TSlot.new(size:30,configuration:2,simple:@tslot_simple)
	end

	# ugly code ahead
	def printer_rect
		x,y=@tslot_x,@tslot_y
		size = 30
		# x 
		res = tslot_double.length(x-size*2).threads.show.rotate(x:-90,z:-90).translate(x:size,y:size)
		res += tslot_double.length(x-size*2).threads.show.rotate(x:-90,z:-90).translate(x:size,y:y)   

		# y
		res += tslot_double.length(y).holes(side:"y").show.rotate(x:-90)
		res += tslot_double.length(y).holes(side:"y").show.rotate(x:-90).mirror(x:1).translate(x:x)

		res += printer_bolts		
		res		
	end

	def printer_bolts
		# right side	
		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:90).translate(x:0,y:15,z:-15)
		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:90).translate(x:0,y:15,z:-15-30)

		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:90).translate(x:0,y:@tslot_y-15,z:-15)
		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:90).translate(x:0,y:@tslot_y-15,z:-15-30)
		# left side	
		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:-90).translate(x:@tslot_x,y:15,z:-15)
		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:-90).translate(x:@tslot_x,y:15,z:-15-30)

		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:-90).translate(x:@tslot_x,y:@tslot_y-15,z:-15)
		b =Bolt.new(8,50,washer:true)
		res += b.show.rotate(y:-90).translate(x:@tslot_x,y:@tslot_y-15,z:-15-30)

	end

end
