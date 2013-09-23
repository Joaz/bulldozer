class YBeltHolder < CrystalScad::Assembly
  
  def show
		belt_holder(true)
  end

	def output
		belt_holder(false)
	end

	
	def belt_holder_base(with_hardware=false)
	  base = cube([45,10,16]).translate(x:-5)
    
    base += cube([30,10,5]).translate(z:16)
    base -= cube([20.2,10.2,1.2]).translate(x:15-0.1,y:-0.1,z:16)
		base = base.color(@@printed_color)		

		# belt clamp bolt
		bolt = Bolt.new(3,12,additional_length:5)
	  base -= bolt.output.mirror(z:1).translate(y:5,x:25,z:21.5)
		base += bolt.show.mirror(z:1).translate(y:5,x:25,z:21.5) if with_hardware == true
		# this bolt needs a washer    
		washer = Washer.new(3.2)		
		base += washer.show.translate(y:5,x:25,z:21.0) if with_hardware == true

		# nut trap for belt clamp bolt
		nut = Nut.new(3)
		nut_cut = hull(nut.output.translate(y:0,x:25,z:10),nut.output.translate(y:5,x:25,z:10))
		base -= nut_cut
		base += nut.show.translate(y:5,x:25,z:10) if with_hardware == true

		base
  end

	def belt_holder(with_hardware=true)
		base = belt_holder_base(with_hardware)
		tensioner = belt_holder_base(with_hardware)	  
		
		# extend base for wood screws
		base += cube([60,10,10]).translate(x:-12).color(@@printed_color)		


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
	    base += tensioner.rotate(x:-90).translate(y:22)
	  end
	  base
	end
	
end
