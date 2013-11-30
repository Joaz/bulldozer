class YBeltHolder < CrystalScad::Assembly
  
  def show
		belt_holder(true)
  end

	def output
		belt_holder(false)
	end

	
	def belt_holder_base(with_hardware=false)
	  base = cube([45,12,16]).translate(x:-5)
    
		# belt clamp
    base += cube([30,12,6]).translate(x:3,z:16)
    # belt cut
    base -= cube([34,12.2,1.7]).translate(x:2,y:-0.1,z:16.5)
    base -= cube([6.5,13,1]).translate(x:14.5,y:-0.1,z:16)

		# now put a small wall down to hold the parts together.
		# it will crush once the belt tightening bolts are tighened
    # => that does not work
#    base += cube([1.5,3,2.7]).translate(x:3,y:9,z:16.5)


		base = base.color(@@printed_color)		

		# FIXME: use self tapping one with hexagonal head
		# belt clamp bolt
		bolt = Bolt.new(4,16,additional_length:5)
	  base -= cylinder(d:3.9,h:20).mirror(z:1).translate(y:6,x:25,z:22)
	
	#  base -= bolt.output.mirror(z:1).translate(y:6,x:25,z:22)
		base += bolt.show.mirror(z:1).translate(y:6,x:25,z:22) if with_hardware == true

		bolt = Bolt.new(4,16,additional_length:5)
	  base -= cylinder(d:3.9,h:20).mirror(z:1).translate(y:6,x:10,z:22)

#	  base -= bolt.output.mirror(z:1).translate(y:6,x:10,z:22)
		base += bolt.show.mirror(z:1).translate(y:6,x:10,z:22) if with_hardware == true   

		
		base
  end

	def belt_holder(with_hardware=true)
		base = belt_holder_base(with_hardware)
		tensioner = belt_holder_base(with_hardware)	  
		
		# extend base for wood screws
		base += cube([10,12,10]).translate(x:-15).color(@@printed_color)		
		base += cube([10,12,10]).translate(x:40).color(@@printed_color)		
    
    screw = WoodScrew.new(length:20)
    base -= screw.output.mirror(z:1).translate(x:-10,y:6,z:10.1)
    base += screw.show.mirror(z:1).translate(x:-10,y:6,z:10.1) if with_hardware


    screw = WoodScrew.new(length:20)
    base -= screw.output.mirror(z:1).translate(x:45,y:6,z:10.1)
    base += screw.show.mirror(z:1).translate(x:45,y:6,z:10.1) if with_hardware
    
	  # tensioner bolts & nut traps	
		[0,35].each do |x_pos|
			bolt = Bolt.new(4,40,additional_length:5,additional_diameter:0.5)
			washer = Washer.new(4.3)		
			nut = Nut.new(4)


			base -= bolt.output.rotate(x:90).translate(y:35,x:x_pos,z:10)
			tensioner -= bolt.output.rotate(x:90).translate(y:35,x:x_pos,z:10)
			
			# trap nut
			base -= nut.output.rotate(x:90).translate(y:nut.height-0.1,x:x_pos,z:10)
			
			if with_hardware == true		
				base += bolt.show.rotate(x:90).translate(y:35,x:x_pos,z:10)
				base += washer.show.rotate(x:90).translate(y:35,x:x_pos,z:10)
				base += nut.show.rotate(x:90).translate(y:nut.height,x:x_pos,z:10)
			end		
		end


    
		if with_hardware==true
  		base += tensioner.translate(y:23)
      base.mirror(z:1)
	  else
	    base = base.rotate(x:-90)
	    base += tensioner.rotate(x:-90).translate(y:23)
	  end
	  base
	end
	
end
