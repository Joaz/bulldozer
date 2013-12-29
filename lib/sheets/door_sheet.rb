class DoorSheet < CrystalScad::Assembly
	attr_accessor :x,:y,:z

	def initialize(args={})
		@x = args[:x] || 300				
		@y = args[:y] || 200				
		@z = args[:z] || 5		

	end

	def output
		return @output unless @output == nil	
		res = square([@x,@y])
	end

	def output=(new_output)
		@output = new_output
	end

	def show
		res = output.linear_extrude(h:@z).color(r:255,g:255,b:255,a:160)
	end

end
