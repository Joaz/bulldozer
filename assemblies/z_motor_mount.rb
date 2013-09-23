class ZMotorMount < CrystalScad::Assembly

	def initialize(args={})
		super
		@args[:thickness] ||= 3
	end

	def show
		part.rotate(z:180).translate(x:30,y:3)
	end

	def output
		part(true)
	end

	def part(output=false)
		motor_mount_thickness = 6
		motor_position = 67
		bearing_position = 105
		res = cube([30,@args[:thickness],120])	
		
		# motor holder
		motor = Nema17.new
		
		res += cube([48,47,motor_mount_thickness]).translate(z:motor_position)
		res -= cylinder(d:24,h:motor_mount_thickness+0.2).translate(x:26,y:25,z:motor_position-0.1)		
			
		res += motor.show.translate(x:22+4,y:22+@args[:thickness],z:20) unless output == true
		
		# screw holes
		[-1,1].each do |i|	
			[-1,1].each do |f|	
				bolt = Bolt.new(3,10)
				res -= bolt.output.translate(x:26+i*15.7,y:25+f*15.7,z:motor_position)
				res += bolt.show.mirror(z:1).translate(x:26+i*15.7,y:25+f*15.7,z:motor_position+motor_mount_thickness)
		
			end
		end

		# bearing holder

		res += cube([35,35,3]).translate(z:bearing_position)

		res
	end

end
