class Belt
	def initialize(args={})
		@args=args
		@args[:belt_thickness] ||= 0.9
		@args[:width] ||= 6
		@args[:turn_diameter] ||= 13
		@args[:longest_side_length] ||= 420
		@args[:top_side_length] ||= 400
		@args[:position] ||= 200


		# TODO: BOM entry for this one
	end

	def show

		belt= turn_180(@args[:turn_diameter])
		belt+= turn_180(@args[:turn_diameter]).mirror(y:1).translate(y:420)
				
		belt+= line(@args[:longest_side_length]).translate(z:-@args[:turn_diameter]-@args[:belt_thickness])
		
		belt+= line(@args[:position])
		belt+= line(@args[:top_side_length]-@args[:position]).translate(y:@args[:position]+(@args[:longest_side_length]-@args[:top_side_length]))


		belt.color("DarkSlateGray")
	end
	
	def line(length)
		cube([@args[:width], length, @args[:belt_thickness]])
	end

	def turn_180(diameter)
		turn = cylinder(d:diameter+@args[:belt_thickness]*2,h:@args[:width])
		cut_cyl1 = cylinder(d:diameter,h:@args[:width]+0.2).translate(z:-0.1)
		cut_cyl2 = cylinder(d:diameter,h:@args[:width]+0.2).translate(z:-0.1, y:diameter/2)
		turn -= hull(cut_cyl1,cut_cyl2)

		turn.rotate(y:90).translate(z:-diameter/2+@args[:belt_thickness]/2)
	
	end	
	
end
