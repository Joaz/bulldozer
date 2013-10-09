class XBeltIdler < CrystalScad::Assembly
	def show
    idler(true)
	end
	
	def output
	  idler(false).rotate(x:90)
	end
	
	def idler(show)			
		parts = [ 
			Washer.new(4.3),
			Bearing.new(type:"624",flange:true),
			Washer.new(4.3),
			Bearing.new(type:"624",flange:true,transformations:[Rotate.new(x:180),Translate.new(z:5)]),
			Washer.new(4.3),
			Nut.new(4)		
		]

		bolt = Bolt.new(4,16,additional_length:2)
		x,y,z = position(bolt.show)
		bolt_assembly = bolt.output
  	bolt_assembly += stack({method:"output"}, *parts)
		bolt_assembly = bolt_assembly.translate(x:x*-1,y:y*-1,z:z*-1)

    
		bolt_assembly_show = bolt.show
		bolt_assembly_show += stack({method:"show"}, *parts)
		bolt_assembly_show = bolt_assembly_show.translate(x:x*-1,y:y*-1,z:z*-1)

		nut = Nut.new(4, :no_bom => true) # we have it already in assembly 
			
		assembly = cube([18,14,20]).translate(x:3,y:-5)
		#assembly -= bolt_assembly.translate(x:12,z:20)
		#assembly -= long_slot(d:4.5,h:21,l:10).rotate(z:90).translate(x:12,z:-0.01,y:0)
		#assembly -= long_slot(d:7,h:15,l:16).rotate(z:90).translate(x:12,z:-0.01,y:0)
		#assembly -= hull(nut.output, nut.output.translate(y:30)).translate(x:12,z:16.9,y:0)
#
		
		assembly -= long_slot(d:28,h:13,l:40).rotate(z:90).translate(x:12,z:4,y:-20)
		assembly += cube([18,30,20]).translate(x:3,y:9)
    
    assembly -= long_slot(d:4.5,h:21,l:15).rotate(x:90,z:90).translate(x:2,z:10.01,y:13)
	
	#	assembly = assembly.color(@@printed_color)
	#	
		assembly += bolt_assembly_show.translate(x:12,z:0.25) if show

    
   
  end
  
end
