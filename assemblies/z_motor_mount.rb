class ZMotorMount < CrystalScad::Assembly

	def initialize(args={})
		super
		@args[:thickness] ||= 5
	end

	def show
		part.rotate(z:180).translate(x:30,y:3)
	end

	def output
	  res =	part(true).rotate(x:90,z:90)
		res+=	part(true).rotate(x:90,z:90).mirror(y:1).translate(y:-2)
		res
	end

	def part(output=false)
		motor_mount_thickness = 6
		motor_position = 67
		bearing_position = 102
		res = cube([30,@args[:thickness],bearing_position]).color(@@printed_color)	


		# tslot mounts

		2.times do |i|
			bolt = Bolt.new(4,12)
			washer = Washer.new(4.3)
		  res -= long_slot(d:4.4,h:10,l:14).rotate(x:90,y:90).translate(x:15,y:9,z:19+i*78)				
		
		#	res -= hull(cylinder(d:4.4,h:10),cylinder(d:4.4,h:10).translate(x:14)).rotate(x:90,y:90).translate(x:15,y:9,z:19+i*78)				
			unless output == true
				res += bolt.show.rotate(x:90).translate(x:15,y:@args[:thickness]+1,z:7+i*85) 
				res += washer.show.rotate(x:90).translate(x:15,y:@args[:thickness]+1,z:7+i*85) 
			end
			i+=1
		end

		# motor holder
		motor = Nema17.new
		
		res += cube([48,47+2,motor_mount_thickness]).translate(z:motor_position).color(@@printed_color)	
		res -= cylinder(d:24,h:motor_mount_thickness+0.2).translate(x:26,y:27,z:motor_position-0.1)		
		res += motor.show.translate(x:22+4,y:22+@args[:thickness],z:20) unless output == true
		
		# screw holes
		[-1,1].each do |i|	
			[-1,1].each do |f|	
				bolt = Bolt.new(3,10)
				res -= bolt.output.translate(x:26+i*15.7,y:27+f*15.7,z:motor_position)
				res += bolt.show.mirror(z:1).translate(x:26+i*15.7,y:27+f*15.7,z:motor_position+motor_mount_thickness) unless output == true
		
			end
		end



		res
	end

end
