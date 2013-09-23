class MicroswitchD3V < CrystalScad::Assembly

	def initialize(args={})
		super
		@args[:bolt_length] ||= 20
	end

	def description
		"microswitch D3V-165M-3C5"
	end

	def show
		switch(false)
	end

	def output
		switch(true)	
	end
	
	def terminal(with_angle=false)
		base = cube([10-6.35,8,0.5])
		# c2 type 	
#		base+= cube([10,4.75,0.5]).translate(y:8-6.35)
		# c5 type		
		base+= cube([10,6.35,0.5]).translate(y:1)
	
		base-= cylinder(d:1.6,h:0.7).translate(x:10-6.35+3.2,y:4,z:-0.1)
		if with_angle
			base += cube([0.5,8,5])
			
		end	
		base.color("Silver").translate(y:1).mirror(x:1)	
	end

	def switch(output)
		height = 15.9
		thickness=10.3
		res = cube([27.8,thickness,height])	
		res+= cube([1.6,thickness,7.2]).translate(x:-1.6,z:height-7.2-4)	
		res = res.color("Gray")		
		res += terminal.translate(z:height-5.5-0.5)
		res += terminal.translate(z:height-5.5-6.5-0.5)
		res += terminal(true).translate(x:10+2.8,z:-2.9)
		
		button = hull(cylinder(d:2.8,h:4.2), cylinder(d:2.8,h:4.2).translate(y:4)).color("Red")
		res += button.rotate(x:-90).translate(x:2.8+20.2,y:2.8,z:height+1.2)

		bolt = [Bolt.new(3,@args[:bolt_length]),Bolt.new(3,@args[:bolt_length])]
		res -= bolt[0].output.rotate(x:-90).translate(x:2.8,z:2.8+10.3)
		res -= bolt[1].output.rotate(x:-90).translate(x:2.8+22,z:2.8)

		if output == false	
			res += bolt[0].show.rotate(x:-90).translate(x:2.8,z:2.8+10.3)
			res += bolt[1].show.rotate(x:-90).translate(x:2.8+22,z:2.8)
		end

		
		res
	end

end
