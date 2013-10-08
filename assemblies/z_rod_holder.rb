class ZRodHolder < CrystalScad::Assembly

	def show
		part(true)
	end

	def output
		res = part(false)
		res+= part(false).mirror(x:1).translate(x:-20)
	end

	def part(show)
		res = cube([30,19,6]).center_x.translate(x:15,y:-19) 
		res += cube([19,15,20]).center_x.translate(y:-10)	
		res += cylinder(d:19,h:20).translate(y:-10)
	  
	  res -= cylinder(d:12.6,h:20).translate(y:-10,z:2.5)

		res += cube([30,5,40])	
		res = res.color(@@printed_color)


		res -= long_slot(d:4.4,h:10,l:14).rotate(y:90,z:90).translate(x:15-2,y:-3,z:35)

		bolt = Bolt.new(4,12)
		washer = Washer.new(4.3)		
		res += bolt.show.rotate(x:-90).translate(x:15-2,y:-1,z:30) if show
		res += washer.show.rotate(x:-90).translate(x:15-2,y:-1,z:30) if show

		res
	end
	

end

