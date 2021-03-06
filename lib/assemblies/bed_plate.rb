class BedPlate
	attr_accessor :size
	def initialize(args={})
		@size=args
		
		@bolt_positions = [{x:9,y:9},{x:9+206,y:9},{x:9,y:9+206},{x:9+206,y:9+206}]
	  
	  @@bom.add(description) unless args[:no_bom] == true
	  @bolt_height = @size[:z]
	end

  def description
    "laminated plywood cut #{@size[:x]}x#{@size[:y]}, thickness=#{@size[:z]}mm"
  end
  
	def output
		r = cube([@size[:x],@size[:y],@size[:z]])

		r = r-bolts		
		return r.color("SaddleBrown")	
	end
	
	def show
		output+bolts+nuts(3)+heatbed+nuts
	end

	def bolts
		@bolt_positions.each do |pos|
			@bolt += Bolt.new(3,25).output.translate(pos)		
		end
		@bolt
	end

	def nuts(count=1)
		@nut_height = Nut.new(3,no_bom:true).height + 0.05
	
		(1..count).each do |i| 		
			@bolt_positions.each do |pos|
				@nut += Nut.new(3).show.	translate(pos).translate(z:@bolt_height)
			end		
		  @bolt_height += @nut_height
		end

		@nut 
	end	
	
	def heatbed
	  bed = Heatbed.new
	  output = bed.show.translate(x:5,y:5,z:@bolt_height)
	  @bolt_height+= bed.size[:z]
	  output
	end
	

end
