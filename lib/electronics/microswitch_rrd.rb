class MicroswitchRrd < CrystalScad::Assembly

	def initialize(args={})
		@bolt_height = 16
 		@x = 40
		@y = 16
		@z = 1.6

		@height = 6+@z
	end

  def part(show)
    res = cube([@x,@y,@z]).color("white")
    # switch
    res += cube([13,6.5,6]).translate(x:20,y:10,z:@z).color("black")
    res += cube([1.5,1.5,3]).translate(x:22,y:16,z:3.2).color("blue")

    
    res -= cylinder(d:3.5,h:2).translate(x:17,y:13.5,z:-0.1)
    res -= cylinder(d:3.5,h:2).translate(x:17+19,y:13.5,z:-0.1)
    res -= cylinder(d:3.5,h:2).translate(x:2,y:13.5,z:-0.1)
    

		if !show
			# bolts coming through		  
			res += cylinder(d:3.5,h:@bolt_height).translate(x:17,y:13.5,z:-0.1-@bolt_height+@z)
		  res += cylinder(d:3.5,h:@bolt_height).translate(x:17+19,y:13.5,z:-0.1-@bolt_height+@z)
		  res += cylinder(d:3.5,h:@bolt_height).translate(x:2,y:13.5,z:-0.1-@bolt_height+@z)
		
			# additional cutouts for through hole component solder pins on the bottom of the pcb

	    res += cube([13,16,@solder_pin_cutout_height=1.8]).translate(x:20,z:-2)
	    res += cube([9,16,@solder_pin_cutout_height]).translate(x:5,z:-2)
			 

		end

    res
  end
end
