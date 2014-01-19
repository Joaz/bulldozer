class YRodHolder < CrystalScad::Assembly
	
	def initialize
		@height = 12
	end
	
	def show
		res = half(true)
		res += half(true).mirror(z:1).translate(z:12*2)
		
  	res = res.color(@@printed_color)  
		b = Bolt.new(4,30,washer:true)
		n = TSlotNut.new		

		res += b.show.mirror(z:1).translate(x:25,y:15,z:@height*2) 		
		res += n.show.translate(n.threads_top.position_on(b)).translate(x:25,y:15)		

	
		b = Bolt.new(4,30,washer:true)
		n = TSlotNut.new		
		res += b.show.mirror(z:1).translate(x:-30,y:15,z:@height*2) 		
		res += n.show.translate(n.threads_top.position_on(b)).rotate(z:90).translate(x:-30,y:15)		

		res
	end
	
	def output
		res = half(false)
		res += half(false).mirror(x:1).translate(y:-31)
	end

	def half(show)
		res = cube([90,30,@height]).center_x
  	res -= cylinder(d:12.2,h:30.2).rotate(x:-90).translate(y:5,z:12)
		res -= long_slot(d:4.4,h:@height+0.2,l:16).translate(x:17,y:15,z:-0.1) 		
		res -= long_slot(d:4.4,h:@height+0.2,l:15).rotate(z:90).translate(x:-30,y:7.5,z:-0.1) 		

	end

end

