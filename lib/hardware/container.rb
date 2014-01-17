class Container < CrystalScad::Assembly
	# rough sketch of "Multi-Bo@x M" EAN 4001515272018
243
	def initialize()
		super()
		@x,@y,@z = [270,350,210]
	end

	def show
		t=3 # wall_thickness
		
		# building container side by side to show up okay in thrown-together renderer
		
		res = cube([@x,@y,t])
		# left and right
		res += cube([t,@y,@z])
		res += cube([t,@y,@z]).translate(x:@x)
		# front & back
		res += cube([@x,t,@z])
		res += cube([@x,t,@z]).translate(y:@y)
		
		res.color("white")

	end

end
