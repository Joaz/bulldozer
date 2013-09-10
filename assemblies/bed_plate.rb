class BedPlate
	attr_accessor :size
	def initialize(size)
		@size=size		
		
		@bolt_positions = [{x:12.5,y:12.5},{x:12.5+200,y:12.5},{x:12.5,y:12.5+200},{x:12.5+200,y:12.5+200}]
		
	end

	def output
		r = cube([@size[:x],@size[:y],@size[:z]])
		@@bom.add("laminated plywood cut #{@size[:x]}x#{@size[:y]}, thickness=#{@size[:z]}mm")
	
		r = r-bolts		
		return r.color("SaddleBrown")	
	end	
	
	def show
		output+bolts+nuts
	end

	def bolts
		@bolt_positions.each do |pos|
			@bolt += Bolt.new(3,25).output.translate(pos)		
		end
		@bolt
	end

	def nuts
		nut_height = Nut.new(3,no_bom:true).height + 0.05
	
		(0..2).each do |i| 		
			@bolt_positions.each do |pos|
				@nut += Nut.new(3).show.	translate(pos).translate(z:@size[:z]+i*nut_height)
			end		
		end

		@nut 
	end	
	

end
