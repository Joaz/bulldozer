class ZBearingHolder < CrystalScad::Assembly
	
	def show
		part(true)
	end
	
	def output
		res = part(false)
		res += part(false,false).mirror(x:1).translate(x:62)
	end

	def part(show=false, with_motor=true)
		res = cylinder(d:30,h:62).translate(y:50,x:3)
		
		res -= cube([60,30,60]).center_y.translate(x:-15,y:-29)
			
		res += cube([60,13,43]).center_x.translate(x:15,y:-14) 
    # base wall going to the motor
		if with_motor
		  res += cube([42,13,60]).translate(x:-12,y:-14)
      
      # motor mount
      motor_mount = MotorMount.new
      res += motor_mount.part(show).rotate(x:90).translate(x:9,y:-6,z:85-3.5)
    
      # connecting wall to the motor mount
      res += cube([42,6,65]).translate(x:-12,y:-12)

			# x endstop
			switch = MicroswitchD3V.new(bolt_length:23.1)
			res -= switch.show.rotate(x:180,y:-90).translate(x:13,y:9,z:35-3.5) 
			res += switch.show.rotate(x:180,y:-90).translate(x:13,y:9,z:35-3.5) if show
	
    end
    
		res += cube([30,78,20]).center_x.translate(x:15,y:-14)
		res += cube([30,30,13]).center_xy.translate(x:15,y:-29)

    # lm12(l)uu cut 
	  res -= cylinder(d:21.5,h:70).translate(y:50,x:3,z:2)        
	  res -= cylinder(d:18,h:70).translate(y:50,x:3,z:-1.5)        
		# the top lm12uu/lm12luu will be glued inside
		
		bolt = Bolt.new(4,20)
		washer = Washer.new(4.3)
		res -= long_slot(d:4.4,h:20,l:10).rotate(x:90).translate(x:30,y:0,z:28)
		res += bolt.show.rotate(x:90).translate(x:34,y:0,z:28) if show
		res += washer.show.rotate(x:90).translate(x:34,y:0,z:28) if show

		# lower bolt
		bolt = Bolt.new(4,20)  
		washer = Washer.new(4.3)
		res -= long_slot(d:4.4,h:20,l:15).translate(x:7.5,y:-29,z:-1)
		res += bolt.show.translate(x:15,y:-29,z:-1) if show
		res += washer.show.translate(x:15,y:-29,z:-1) if show


		# inserted for BOM
		# TODO: output them on show 
		Lm_uu.new(inner_diameter:12)
		Lm_uu.new(inner_diameter:12)

	#	motor =  Nema17.new.show.rotate(x:90).translate(x:32,y:102,z:26)
  #  motor +=  Pulley.new.show.rotate(x:-90).translate(x:32,y:38.5,z:26)
    motor += Belt.new(longest_side_length:258,top_side_length:246,position:20).show.rotate(z:-90,y:180).translate(x:32,y:45,z:19-3.5)
 
    motor += XBeltIdler.new.show.rotate(x:90,y:90).translate(x:290,y:59,z:34)
 	#	res += motor.translate(x:-9,y:-41,z:33) if show
		res += motor.translate(x:-24,y:-61,z:60) if show
		
		res
	end	

end
