class BulldozerGearbox < CrystalScad::Printed

  def part(show)
    motor = Nema17.new(motor_flange_output_height:20)   
    
    g1 = Gear.new(module:0.5,teeth:14,bore:5,height:6,hub_dia:9,hub_height:6)
    g2 = Gear.new(module:0.5,teeth:80,bore:5,height:4,hub_dia:20,hub_height:4,output_margin_height:1.5)
    

		bottom = cube([size_x=70,motor_size=44,bottom_z=17]).center_y.translate(x:-motor_size/2.0).color(@@printed_color)
		top = cube([size_x,motor_size,top_z=10]).center_y.translate(x:-motor_size/2,z:bottom_z).color(@@printed_color)
		
		bolts = create_bolts("top",bottom,motor,height:27,bolt_height:30)[0..1]
		
		bottom -= bolts
		top -= bolts
		bottom += bolts if show

		bottom -= motor.output.translate(z:-motor.args[:length]-1)
    bottom += motor.show.translate(z:-motor.args[:length]) if show
    
    bottom += g1.show.mirror(z:1).translate(z:17) if show
		bottom = bottom.translate(x:-g1.distance_to(g2))
		top = top.translate(x:-g1.distance_to(g2))

		acme = AcmeRod.new
		bearing = Bearing.new(type:625,output_margin_height:1.1)
		bearing2 = Bearing.new(type:625,no_bom:true,outer_rim_cut:5)
		# we're using the bearing again, because acme output does not make any bearings (and it already adds to the bom)
	
		shaft = [bearing,Washer.new(5.3),g2,Washer.new(5.3),acme,bearing2]	
		offset = [-6,-1,0,8,-3,9]
		
		parts = CrystalScadObject.new
		shaft.each_with_index do |item,i|
			bottom -= item.output.translate(z:12+offset[i])
			top -= item.output.translate(z:12+offset[i])
			parts += item.show.translate(z:12+offset[i]) if show
		end		
		
	  # bolts on the other side

		bpos1 = {x:20,y:motor_size/2-5}
		bpos2 = {x:20,y:-motor_size/2+5}
		bolt = Bolt.new(3,30)	
		nut = Nut.new(3)
		bottom -= bolt.output.translate(bpos1) 
		bottom += bolt.show.translate(bpos1) if show
		top -= bolt.output.translate(bpos1) 		
		top -= nut.output.translate(bpos1).translate(z:bottom_z+top_z-nut.height+0.05)		
		top += nut.show.translate(bpos1).translate(z:bottom_z+top_z-nut.height+0.05) if show		

		bolt = Bolt.new(3,30)	
		nut = Nut.new(3)
		bottom -= bolt.output.translate(bpos2) 
		bottom += bolt.show.translate(bpos2)	 if show
		top -= bolt.output.translate(bpos2) 
		top -= nut.output.translate(bpos2).translate(z:bottom_z+top_z-nut.height+0.05)		
		top += nut.show.translate(bpos2).translate(z:bottom_z+top_z-nut.height+0.05) if show		

		# rod holders
		

		if show
			bottom+top+parts
		else
			bottom + top.rotate(x:180).translate(y:motor_size+1,z:bottom_z+top_z)
		end		

  end
  


end
