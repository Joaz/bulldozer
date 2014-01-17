class AluminiumCompositeSheet < CrystalScad::Assembly

	def initialize(args={})
		@x = args[:x] || 100				
		@y = args[:y] || 200				
		@z = args[:z] || 3				
		@bolt_size = args[:bolt_size] || 4		
		@bolt_length = args[:bolt_length] || 12
		@bolt_margin = args[:bolt_margin] || 0.3		
		@bolt_position = args[:bolt_position] || 15	
		@with_nut = args[:with_nut]
		@with_nut = true if @with_nut == nil	
		super	
	
	end
		
	def description
		desc = "Aluminium composite sheet, #{@x}x#{@y}mm thickness #{@z}mm"	
		if @bolt_size > 0
			desc += " with holes drilled #{@bolt_size+@bolt_margin}mm #{@bolt_position}mm from edges"
		end

		desc
	end

	def output
		res = square([@x,@y])
		return res if @bolt_size == 0
		bolt_positions.each do |i,f|
			res -= circle(d:@bolt_size+@bolt_margin).translate(x:i,y:f)
		end	
		res
	end

	def show
		res = cube([@x,@y,@z]).color("GhostWhite")
		return res if @bolt_size == 0
		
		bolt_positions.each do |i,f|
			bolt = Bolt.new(@bolt_size,@bolt_length,type:"7380")
			#washer = Washer.new(@bolt_size)
			res -= bolt.output.mirror(z:1).translate(x:i,y:f,z:@z)
			res += bolt.show.mirror(z:1).translate(x:i,y:f,z:@z)
			#res += washer.show.translate(x:i,y:f,z:@z)
			if @with_nut
			  # the orientation works for most of the plates. lets just ignore the other ones
			  nut = TSlotNut.new(bolt_size:@bolt_size)
			  res += nut.show.translate(nut.threads_top.position_on(bolt)).rotate(z:90).translate(x:i,y:f,z:0)
      end
      
		end	
		res		
	end

	def bolt_positions
		pos = @bolt_position
		[[pos,pos],[pos,@y-pos],[@x-pos,pos],[@x-pos,@y-pos]]
	end
	


end
