class ZLinearBearingHolder < CrystalScad::Assembly
	
	def show(with_motor=true)
		part(true, with_motor)
	end
	
	def output
		res = part(false)
		res += part(false,false).mirror(x:1).translate(x:77,y:-15)
	end

	def part(show=false, with_motor=true)
		res = cylinder(d:30,h:62).translate(y:50,x:3)
		
		res -= cube([60,30,60]).center_y.translate(x:-15,y:-29)
			
		res += cube([60,13,43]).center_x.translate(x:15,y:-14) 
		res = res.color(@@printed_color)
    
    # base wall going to the motor
		if with_motor
		  res += cube([42,13,60]).translate(x:-12,y:-14).color(@@printed_color)
      
      # motor mount
      motor_mount = MotorMount.new
      res += motor_mount.part(show).rotate(x:90).translate(x:9,y:-6,z:85-3.5)
    
      # connecting wall to the motor mount
      res += cube([42,6,65]).translate(x:-12,y:-12).color(@@printed_color)

			# x endstop
			switch = MicroswitchD3V.new(bolt_length:23.1)
			res -= switch.show.rotate(x:180,y:-90).translate(x:13,y:9,z:35-3.5) 
			res += switch.show.rotate(x:180,y:-90).translate(x:13,y:9,z:35-3.5) if show
	  else
	    res -= cube([18,15,50]).center_x.translate(x:-9,y:-15,z:-0.1).color(@@printed_color)
    end
    
		res += cube([30,78,20]).center_x.translate(x:15,y:-14).color(@@printed_color)
		res += cube([30,30,13]).center_xy.translate(x:15,y:-29).color(@@printed_color)

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

    motor = Belt.new(longest_side_length:258,top_side_length:257,position:30).show.rotate(z:-90,y:180).translate(x:32,y:45,z:19-3.5) if with_motor 
    motor += XBeltIdler.new.show.rotate(x:90,y:90).translate(x:290,y:59,z:34) if with_motor

		res += motor.translate(x:-24,y:-61,z:60) if show && with_motor
		
		res
	end	

end
