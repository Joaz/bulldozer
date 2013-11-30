class XBeltIdler < CrystalScad::Assembly
	def show
    idler(true)
	end
	
	def output
	  idler(false).rotate(y:-90)
	end
	
	def idler(show)			
		parts = [ 
			Washer.new(4.3),
			Bearing.new(type:"624",flange:true),
			Washer.new(4.3),
			Bearing.new(type:"624",flange:true,transformations:[Rotate.new(x:180),Translate.new(z:5)]),
			Washer.new(4.3)		
		]

		bolt = Bolt.new(4,25,additional_length:2)
		x,y,z = position(bolt.show)

    
		bolt_assembly_show = bolt.show.translate(z:-3)
		bolt_assembly_show += stack({method:"show"}, *parts)
		bolt_assembly_show = bolt_assembly_show.translate(x:x*-1,y:y*-1,z:z*-1+5)
    nut = Nut.new(4)
		bolt_assembly_show += nut.show.translate(z:20) 

		nut = Nut.new(4, :no_bom => true) # we have it already in assembly 
			
		assembly = cube([16,14,19]).translate(x:3,y:-5,z:1)
		#assembly -= bolt_assembly.translate(x:12,z:20)
		#assembly -= long_slot(d:4.5,h:21,l:10).rotate(z:90).translate(x:12,z:-0.01,y:0)
		#assembly -= long_slot(d:7,h:15,l:16).rotate(z:90).translate(x:12,z:-0.01,y:0)
		#assembly -= hull(nut.output, nut.output.translate(y:30)).translate(x:12,z:16.9,y:0)
#
		
		assembly -= long_slot(d:28,h:13,l:40).rotate(z:90).translate(x:12,z:4,y:-20)
		assembly += cube([16,3,19]).translate(x:3,y:9,z:1)
		assembly += cube([18,30,16]).translate(x:3,y:9,z:2)
    
    assembly -= long_slot(d:4.5,h:21,l:15).rotate(x:90,z:90).translate(x:2,z:10.01,y:14)
    assembly = assembly.color(@@printed_color)
	
	#	assembly = assembly.color(@@printed_color)
	#	
		assembly -= bolt.translate(x:12,z:0.25)
 		assembly += bolt_assembly_show.translate(x:12,z:0.25) if show

    # guide bolt
    bolt = Bolt.new(4,25,additional_length:2)
		assembly+= bolt.show.rotate(y:90).translate(x:3,y:18.5,z:10) if show
    
    # tightener bolt & nut trap
		bolt = Bolt.new(4,20)
		nut = Nut.new(4)
  	assembly-= hull(nut.output,nut.output.translate(x:15)).rotate(x:90).translate(x:12,y:37,z:10)
  	assembly-= bolt.output.rotate(x:90).translate(x:12,y:39,z:10)
  	assembly+= bolt.show.rotate(x:90).translate(x:12,y:39,z:10) if show
 		
    
    
    assembly
   
  end
  
end
