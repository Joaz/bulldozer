class Door < CrystalScad::Assembly

	def initialize(args={})
		super
		@rotation = args[:rotation] || 0
		@max_rotation = 140	

		@x = args[:x] || 300
		@y = args[:y] || 200

		@z1 = args[:z1] || 30
		@z2 = args[:z2] || @y-70

		@h1 = Hinge.new
		@h2 = Hinge.new
	end

	def show
		res = door		
		res += @h1.part_left.mirror(y:0).translate(z:@z1)
		res += @h2.part_left.mirror(y:0).translate(z:@z2)

		res
	end

	def door
		# FIXME: use a more suitable material for the door
		# FIXME: make the rest of the door configuratble			
		sheet = AluminiumCompositeSheet.new(x:@x,y:@y)
		
		res = sheet.show.rotate(x:90).translate(x:1,y:10)
		res += @h1.part_right.mirror(y:0).translate(z:@z1)
		res += @h2.part_right.mirror(y:0).translate(z:@z2)



		res.rotate(z:-@rotation)
			
	
	end

end
