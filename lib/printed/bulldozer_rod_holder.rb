class BulldozerRodHolder < CrystalScad::Printed

	def initialize
		@height = 110
		@rod_position = 92
	end	

	def part(show)
		res = tower	
		mount = TSlotMount.new(peg:false,thickness:10,bolt_length:16)
		res += mount.part(show).rotate(x:90).translate(y:40)
		res += mount.part(show).rotate(x:90,z:90).translate(x:-30,y:-23)

		res += cube([30,10,10]).translate(x:-0,y:-23).color(@@printed_color)
		
		res += hull(cube([30,10,10]).translate(x:-30,y:-0),cube([10,30,10]).translate(x:0,y:10)).color(@@printed_color)

	end	

	def tower
		res = cube([30,30,@height]).center_y.color(@@printed_color)
		res-= cylinder(d:12.4,h:20).rotate(y:90).translate(x:-0.01,z:@rod_position)
	end	

	def part_left(show)
		res = tower
				
		mount = TSlotMount.new(peg:false,thickness:10,bolt_length:16)
		res += mount.part(show).rotate(x:90,z:90).translate(y:10-3)
		res += mount.part(show).rotate(x:90,z:90).translate(x:-30,y:-23)

		res += cube([30,10,10]).translate(x:-0,y:-23).color(@@printed_color)
		
		res += hull(cube([30,10,10]).translate(x:-30,y:-0),cube([10,30,10]).translate(x:0,y:10-3)).color(@@printed_color)
		res.mirror(x:1)		
	end

	def show(which = :right)
		return part(true) if which == :right
		part_left(true)	
	end

end
