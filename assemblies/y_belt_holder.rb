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
		# leave 0.6mm walls. those will crush once the belt tightening bolts are tighened
    base -= cube([28.8,12.2,1.7]).translate(x:3.6,y:-0.1,z:16)
		base = base.color(@@printed_color)		

		# FIXME: use self tapping one with hexagonal head
		# belt clamp bolt
		bolt = Bolt.new(4,16,additional_length:5)
	  base -= bolt.output.mirror(z:1).translate(y:6,x:25,z:22)
		base += bolt.show.mirror(z:1).translate(y:6,x:25,z:22) if with_hardware == true

		bolt = Bolt.new(4,16,additional_length:5)
	  base -= bolt.output.mirror(z:1).translate(y:6,x:10,z:22)
		base += bolt.show.mirror(z:1).translate(y:6,x:10,z:22) if with_hardware == true


		# this bolt needs a washer    
		#washer = Washer.new(3.2)		
		#base += washer.show.translate(y:6,x:25,z:21.0) if with_hardware == true

		# nut trap for belt clamp bolt
		#nut = Nut.new(4)
		#nut_cut = hull(nut.output.translate(y:0,x:25,z:10),nut.output.translate(y:6.4,x:25,z:10))
		#base -= nut_cut
		#base += nut.show.translate(y:6,x:25,z:10) if with_hardware == true

		base
  end

	def belt_holder(with_hardware=true)
		base = belt_holder_base(with_hardware)
		tensioner = belt_holder_base(with_hardware)	  
		
		# extend base for wood screws
		base += cube([60,12,10]).translate(x:-12).color(@@printed_color)		


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
