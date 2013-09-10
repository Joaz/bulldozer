class AcmeRod
	  def initialize(args={})		
		@args=args			
		@args[:length] ||= 310
		@args[:diameter] ||= 10.0
		@args[:pitch] ||= 2.0
		# these shouldn't be default... 
		@args[:bottom_length] = 20
		@args[:bottom_diameter] = 5
		@args[:top_length] = 20
		@args[:top_diameter] = 5



		@@bom.add(description) unless args[:no_bom] == true
  end

	def description
		"ACME Rod"
	end

	def show
		acme
	end	

	def acme
		
		# while this will give a nice looking idea of an acme screw, it takes way too long time to render

		#rod =cylinder(d:@args[:diameter]-3,h:@args[:length])	
		#rod += circle(d:@args[:diameter]/2).translate(x:@args[:diameter]/4).linear_extrude(height:@args[:length],twist:@args[:length] * 360/@args[:pitch].to_f,convexity:1)

		rod = cylinder(d:@args[:diameter],h:@args[:length])
		if @args[:bottom_length] > 0
			rod+= cylinder(d1:@args[:bottom_diameter],d2:@args[:diameter],h:2).translate(z:-2)
			rod+= cylinder(d:@args[:bottom_diameter],h:@args[:bottom_length]).translate(z:-@args[:bottom_length])
		end
		if @args[:top_length] > 0
			rod+= cylinder(d2:@args[:top_diameter],d1:@args[:diameter],h:2).translate(z:@args[:length])
			rod+= cylinder(d:@args[:top_diameter],h:@args[:top_length]).translate(z:@args[:length])
		end
	
		rod.color("Gray").translate(z:@args[:bottom_length])
	end


end
