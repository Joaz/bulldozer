class BulldozerIdler < CrystalScad::Printed

  def part(show)
    g1 = Gear.new(module:0.5,teeth:14,bore:5,height:6,hub_dia:9,hub_height:6)
    g2 = Gear.new(module:0.5,teeth:80,bore:5,height:4,hub_dia:20,hub_height:4,output_margin_height:1.5)
   

		motor_size_x=42
		bottom = cube([size_x=70+15,motor_size_y=44+16,bottom_z=25]).translate(x:-motor_size_x/2.0,y:-22).color(@@printed_color)
#		top = cube([size_x,motor_size_y,top_z=9.5]).translate(x:-motor_size_x/2,y:-22,z:bottom_z).color(@@printed_color)
		
		mount = TSlotMount.new(peg:false)
		bottom+=mount.part(show).rotate(y:-90).translate(x:-size_x/2+22,y:-22)
		mount = TSlotMount.new(peg:false)
		bottom+=mount.part(show).rotate(y:-90).mirror(x:1).translate(x:size_x/2+22,y:-22)

		bottom = bottom.translate(x:-g1.distance_to(g2))
#		top = top.translate(x:-g1.distance_to(g2))

	  bearing = Bearing.new(type:"63800",outer_rim_cut:bottom_z-6,no_bom:true ) # bom covered by acme rod already
		bottom-= bearing.output.translate(z:bottom_z-bearing.height)
		#bottom+= bearing.show.translate(z:bottom_z-bearing.height) if show		

		# rod holders
		rod_distance_x = 30 # from center
		rod_distance_y = 30
		total_height = bottom_z
		
		bottom-= cylinder(d:12.4,h:total_height).translate(x:rod_distance_x,y:rod_distance_y,z:2.5) 		
#		top-= cylinder(d:12.4,h:total_height).translate(x:rod_distance_x,y:rod_distance_y,z:2.5) 		
		
		bottom-= cylinder(d:12.4,h:total_height).translate(x:-rod_distance_x,y:rod_distance_y,z:2.5) 		
#		top-= cylinder(d:12.4,h:total_height).translate(x:-rod_distance_x,y:rod_distance_y,z:2.5) 		


		bottom
  end
  


end
