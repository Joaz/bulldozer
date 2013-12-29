class Door < CrystalScad::Assembly

	def initialize(args={})
		super
		@rotation = args[:rotation] || 0
		@max_rotation = 140	

#		@x = args[:x] || 300
#		@y = args[:y] || 200

#		@z1 = args[:z1] || 30
#		@z2 = args[:z2] || @y-70
		@sheet = args[:sheet]
		raise "door needs a :sheet in the arguments" if @sheet == nil
	
		@x = @sheet.x
		@y = @sheet.y
		@z = @sheet.z

		@h1,@h2 = Hinge.new,Hinge.new

		@z1 = 0
		@z2 = @y-@h1.y
		

	end

	def show
		res = door		
		res += @h1.part_left.translate(z:@z1)
		res += @h2.part_left.translate(z:@z2)

		res
	end

	def door

		@sheet.output -= @h1.output.translate(y:@z1)
		@sheet.output -= @h2.output.translate(y:@z2)
		
		res = @sheet.show.rotate(x:90).translate(x:0,y:@z+7)
		res += @h1.part_right.translate(z:@z1)
		res += @h2.part_right.translate(z:@z2)
		


		res.rotate(z:-@rotation)
			
	
	end

end
