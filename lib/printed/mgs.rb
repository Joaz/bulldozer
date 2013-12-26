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

		bottom = cube([main_x=42,main_y=42,bottom_z=5]).translate(x:-main_x/2.0,y:-main_y/2.0).color(@@printed_color)
	
		total_height = bottom_z

		bottom -= motor.output.translate(z:-motor.args[:length])
		bottom += motor.show.translate(z:-motor.args[:length]) if show
		
		bolts = create_bolts("top",bottom,motor,height:total_height,bolt_height:20) # TODO: fix bolt_height when we have the top
		bearing_bottom = Bearing.new(type:"625")
		
		bottom += g1.show.mirror(z:0).translate(z:9) if show
		
		# stuff on the second gear position
		if show
			shaft = cylinder(d:5,h:40).color("Gainsboro")
		  shaft += bearing_bottom.show
			shaft += g2.show.translate(z:9)
			shaft += drive_gear.translate(z:18)			
			shaft += Washer.new(5).show.translate(z:17)
#		res += Bearing.new(type:"625").show.translate(z:15)
		
			bottom += shaft.translate(x:gear_distance,z:1)

		end

		bottom -= bolts
#		top -= bolts
		bottom += bolts if show



		hotend = JHead.new.show
		bottom += hotend.rotate(x:-90).translate(x:20,y:-55,z:27)


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
