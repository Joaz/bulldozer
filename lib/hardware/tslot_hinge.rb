class TslotHinge < CrystalScad::Assembly

	# http://www.motedis.com/konfigurator/ScharnierS.php?lang=german
	
	attr_accessor :y

	def initialize(args={})
		@x = 30
		@y = 30.0
		@z = 9.0
		
		@a1 = @x/2 +2.5
		@a3 = @x
	
		@b2 = 28
		@b1 = @y

		@d1 = 6.6 # hole diameter
		@d3 = 14 # shaft outer dia		
	end
	
	def description
		"T-Slot hinge 30x30"
	end

	# 2d output for sheets
	def output
		res = circle(d:@d1).translate(x:@a3-@a1,y:(@b1-@b2)/2)
		res += circle(d:@d1).translate(x:@a3-@a1,y:(@b1-@b2)/2+@b2)			
		res.translate(x:4)
	end

	def show
		part_left+part_right
	end

	def part_left
		res = hinge_base
		res += cylinder(d:@d3,h:@y/4).rotate(x:-90).translate(x:@b2,z:@d3/2)		
		res += cylinder(d:@d3,h:@y/4).rotate(x:-90).translate(x:@b2,y:@y/2,z:@d3/2)		
		res.rotate(x:90).translate(x:-@b2,y:@d3/2).color("Gray")
	end

	def part_right
		res = hinge_base
		res += cylinder(d:@d3,h:@y/4).rotate(x:-90).translate(x:@b2,y:@y/4,z:@d3/2)		
		res += cylinder(d:@d3,h:@y/4).rotate(x:-90).translate(x:@b2,y:@y/4*3,z:@d3/2)		
		res.mirror(x:1).translate(x:@b2*2).rotate(x:90).translate(x:-@b2,y:@d3/2).color("DimGray")
	end

	def hinge_base

		res = cube([@x-@d3/2,@y,@z])
		
		# should use boltholes here
		res -= cylinder(d:@d1,h:@z+0.2).translate(x:@a3-@a1,y:@y/2, z:-0.1)
		res -= cylinder(d1:@d1,d2:@d1+5,h:@z-5).translate(x:@a3-@a1,y:@y/2, z:5.1)

	end
	

end
