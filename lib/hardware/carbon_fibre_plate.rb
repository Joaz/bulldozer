class CarbonFibrePlate < CrystalScad::Assembly
	def initialize(args={})
		super
		@args[:x] ||= 200
		@args[:y] ||= 200
		@args[:z] ||= 3	
		
	end	

	def show
		cube([@args[:x],@args[:y],@args[:z]]).color("DimGray")
	end

end
