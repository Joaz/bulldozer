class RubberDampener < CrystalScad::Assembly
	attr_accessor :diameter,:height,:bolt_size,:bolt_length

	def initialize(args={})
		@diameter = args[:diameter] || 15
		@height = args[:height] || 8
		@bolt_size = args[:bolt_diameter] || 4
		@bolt_length = args[:bolt_length] || 8
		super
	end

	def show
		res = cylinder(d:@diameter,h:@height ).color("black")
	#	res+= cylinder(d:@bolt_diameter,h:@bolt_length).translate(z:@height ).color("Silver")
		res+=threads		
		res
	end

	def threads_top
		ScrewThread.new(x:0,y:0,z:@height,size:@bolt_size,depth:@bolt_length)  
	end

end
