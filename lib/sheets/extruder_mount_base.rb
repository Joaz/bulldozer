class ExtruderMountBase < CrystalScad::LasercutSheet

	def initialize(args={})
	
		@x = 65
		@y = 40
	end

	def part(show)
		res = square(x:@x,y:@y)

		@bottom_wide = 15
		@top_extend = 15
		@height = 30

		polygon_base = polygon(points:[
						[0,0],[@bottom_wide,0], # bottom points
						[@bottom_wide+@top_extend,@height],[-@top_extend,@height] # top points

					]).translate(x:@top_extend)

		@x_tolerance=0.2
		@y_tolerance_top=5
		@y_tolerance_bottom = 1
		polygon_insert = polygon(points:[
						[@x_tolerance,0],[@bottom_wide-@x_tolerance,0], # bottom points
						[@bottom_wide+@top_extend-@x_tolerance,@height],[@x_tolerance-@top_extend,@height] # top points

					]).translate(x:@top_extend)
		# cut bottom
		polygon_insert -= square(x:@bottom_wide+@top_extend*2,y:@y_tolerance_bottom)
	

		# cut top
		polygon_insert -= square(x:@bottom_wide+@top_extend*2,y:@y_tolerance_top+1).translate(y:@height-@y_tolerance_top)
	
		res -= polygon_base.translate(x:10,y:5)
		res += polygon_insert.translate(x:10,y:5-0.4).color("red")

	end


end
