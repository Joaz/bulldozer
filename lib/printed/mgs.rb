class MGS < CrystalScad::Assembly
	def initialize(args={})
		super(args)

		#	FIXME: no bom for 
		# - gears
		# - filament drive gear
		# - shaft
		# - idler grub screw
	end	

	def part(show=false)
		g1 = Gear.new(module:0.5,teeth:14,bore:5,height:6,hub_dia:9,hub_height:6)
    g2 = Gear.new(module:0.5,teeth:80,bore:5,height:4,hub_dia:20,hub_height:4,output_margin_height:1.5)
    
		gear_distance = g1.distance_to(g2)

 		motor = Nema17.new(motor_flange_output_height:20)   
  
    motor_size = 42
		bottom = cube([main_x=70,main_y=42,bottom_z=9]).translate(x:-motor_size/2.0,y:-main_y/2.0).color(@@printed_color)
	
		middle_right = cube([middle_right_x=23.8,main_y,middle_z=27]).translate(x:motor_size/2.0+8,y:-main_y/2,z:bottom_z).color("orange")

		total_height = bottom_z

		bottom -= motor.output.translate(z:-motor.args[:length])
		
		bottom += motor.show.translate(z:-motor.args[:length]) if show
		
		bearing_bottom = Bearing.new(type:"625")
		
		bottom += g1.show.mirror(z:1).translate(z:9+10) if show
		
		# stuff on the second gear position
		if show
			shaft = cylinder(d:5,h:40).color("Gainsboro")
			shaft += Washer.new(5).show.translate(z:8)
			shaft += Washer.new(5).show.translate(z:9)
			shaft += Washer.new(5).show.translate(z:10)
			shaft += Washer.new(5).show.translate(z:11)
			
		  shaft += bearing_bottom.show.translate(z:3)
			shaft += g2.show.translate(z:9+3)
			shaft += drive_gear.translate(z:17+3)			
			shaft += Washer.new(5).show.translate(z:33)
			shaft += Washer.new(5).show.translate(z:34)
  		shaft += Bearing.new(type:"625").show.translate(z:35)
		
			bottom += shaft.translate(x:gear_distance,z:1)

		end

		left_bolts = create_bolts("top",bottom,motor,height:total_height,bolt_height:20)[0..1] # TODO: fix bolt_height when we have the top
		right_bolts = create_bolts("top",bottom,motor,height:bottom_z-3+0.01,bolt_height:10)[2..3] # TODO: fix bolt_height when we have the top
 
        
		bottom -= left_bolts
		bottom -= right_bolts
		
#		top -= bolts
		bottom += left_bolts if show
		bottom += right_bolts if show



		hotend = JHead.new.show
		distance_roll = DistanceRoll.new(height:16)
		distance_roll2 = DistanceRoll.new
	
		bottom += hotend.rotate(y:-90).translate(x:hotend_x=96,y:hotend_y=4,z:hotend_z=26.5+3)
    bottom += distance_roll.show.rotate(y:-90).translate(x:hotend_x-48,y:hotend_y,z:hotend_z)
    bottom += cylinder(d:2.9,h:100).color("red").rotate(y:-90).translate(x:hotend_x-48,y:hotend_y,z:hotend_z)

    bottom += distance_roll2.show.rotate(y:-90).translate(x:18-8,y:hotend_y,z:hotend_z)


		idler = Bearing.new(type:608).show
		bottom += idler.translate(x:gear_distance,y:16.5,z:26)

		#bottom += middle_right

	end		
	
	def idler
    idler = MGSIdler.new.show
		
	end


	def drive_gear
		res = cylinder(d:8,h:3)
		res += cylinder(d1:8,d2:6.1,h:1.5).translate(z:3)
		res += cylinder(d1:6.1,d2:8,h:1.5).translate(z:4.5)
		res += cylinder(d:8,h:7).translate(z:6)	
		res.mirror(z:1).translate(z:13)
	end


end
