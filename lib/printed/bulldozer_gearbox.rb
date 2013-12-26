class BulldozerGearbox < CrystalScad::Printed

  def part(show)
    motor = Nema17.new(motor_flange_output_height:20)   
    
    g1 = Gear.new(module:0.5,teeth:14,bore:5,height:6,hub_dia:9,hub_height:6)
    g2 = Gear.new(module:0.5,teeth:80,bore:5,height:4,hub_dia:20,hub_height:4,output_margin_height:1.5)
    

		motor_size_x=42
		bottom = cube([size_x=70+15,motor_size_y=44+16,bottom_z=17.5]).translate(x:-motor_size_x/2.0,y:-22).color(@@printed_color)
		top = cube([size_x,motor_size_y,top_z=9.5]).translate(x:-motor_size_x/2,y:-22,z:bottom_z).color(@@printed_color)
		
		bolts = create_bolts("top",bottom,motor,height:27,bolt_height:30)[0..1]
		
		bottom -= bolts
		top -= bolts
		bottom += bolts if show

		bottom -= motor.output.translate(z:-motor.args[:length]-1)
    bottom += motor.show.translate(z:-motor.args[:length]) if show
    
		mount = TSlotMount.new(peg:false)
		bottom+=mount.part(show).rotate(y:-90).translate(x:-size_x/2+22,y:-22)
		mount = TSlotMount.new(peg:false)
		bottom+=mount.part(show).rotate(y:-90).mirror(x:1).translate(x:size_x/2+22,y:-22)


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

		bpos1 = {x:15,y:motor_size_y/2-0}
		bpos2 = {x:30,y:-motor_size_y/2+20}
		total_height = bottom_z+top_z
		bolt = Bolt.new(3,30)	
		nut = Nut.new(3)
		nut_height = total_height-nut.height+0.05
		bottom -= bolt.output.translate(bpos1) 
		bottom += bolt.show.translate(bpos1) if show
		top -= bolt.output.translate(bpos1) 		
		top -= nut.output.translate(bpos1).translate(z:nut_height)		
		# support
		top += cylinder(d:8,h:0.3).translate(bpos1).translate(z:nut_height-0.3) if !show
		top += nut.show.translate(bpos1).translate(z:nut_height) if show		

		bolt = Bolt.new(3,30)	
		nut = Nut.new(3)
		bottom -= bolt.output.translate(bpos2) 
		bottom += bolt.show.translate(bpos2)	 if show
		top -= bolt.output.translate(bpos2) 
		top -= nut.output.translate(bpos2).translate(z:nut_height)		
		# support
		top += cylinder(d:8,h:0.3).translate(bpos2).translate(z:nut_height-0.3) if !show
		top += nut.show.translate(bpos2).translate(z:nut_height) if show		

		# rod holders
		rod_distance_x = 30 # from center
		rod_distance_y = 30

		bottom-= cylinder(d:12.4,h:total_height).translate(x:rod_distance_x,y:rod_distance_y,z:2.5) 		
		top-= cylinder(d:12.4,h:total_height).translate(x:rod_distance_x,y:rod_distance_y,z:2.5) 		
		
		bottom-= cylinder(d:12.4,h:total_height).translate(x:-rod_distance_x,y:rod_distance_y,z:2.5) 		
		top-= cylinder(d:12.4,h:total_height).translate(x:-rod_distance_x,y:rod_distance_y,z:2.5) 		


		if show
			bottom+top+parts
		else
			bottom + top.rotate(x:180).translate(y:motor_size_y+18,z:bottom_z+top_z)
		end		

  end
  


end
