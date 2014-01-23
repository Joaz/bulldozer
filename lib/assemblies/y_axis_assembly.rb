class YAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args = args

    @args[:rod_size] ||= 12    
    @args[:position] ||= 240 
    @args[:bed_size_x] ||= 225
    @args[:bed_size_y] ||= 225       
    @args[:bed_size_z] ||= 12
		@args[:tslot_x] ||= 295
		@args[:tslot_y] ||= 495
		@tslot_x,@tslot_y = @args[:tslot_x],@args[:tslot_y]
		@bed_position_x = 34
		@bed_position_z = 30
    @args[:length] ||= @tslot_y-10
  end
  
  def show
		res = printer_rect
  	res += Rod.new(length:@args[:length]).show.translate(y:5,x:rod_position_left=45+30,z:12)   
  	res += Rod.new(length:@args[:length]).show.translate(y:5,x:rod_position_right=250-30,z:12)   
    

		res += YMotorMount.new.show.rotate(z:-90).rotate(y:90).translate(x:@args[:bed_size_x]/2+21,y:@tslot_y-60+9)

		res += Belt.new.show.translate(x:140,y:44,z:4)
		res += YBeltIdler.new.show.rotate(y:90).translate(x:88,y:40,z:-8)

		res += YRodHolder.new.show.translate(x:rod_position_left)
		res += YRodHolder.new.show.mirror(y:1).translate(x:rod_position_left,y:@tslot_y)

		res += YRodHolder.new.show.translate(x:rod_position_right)
		res += YRodHolder.new.show.mirror(y:1).translate(x:rod_position_right,y:@tslot_y)

		#fixed += YEndstopHolder.new.show.translate(y:438,z:-5)

    

		res + moving_table.translate(x:@bed_position_x,y:@args[:position],z:@bed_position_z)
  end

	def moving_table
    bed_plate=BedPlate.new(x:@args[:bed_size_x],y:@args[:bed_size_y],z:@args[:bed_size_z])
    holder_left=BedPlateBearingMount.new
    moving_table = holder_left.output.translate(x:0,z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/2)          
    # holders on the right side
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/5)          
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/5*4)          
   
    moving_table += bed_plate.show.translate(z:-1)
    moving_table += CarbonFibrePlate.new.show.translate(x:12,y:12,z:20)
		
		moving_table += YBeltHolder.new.show.translate(x:90,y:80,z:3)

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
