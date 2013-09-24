class YBeltIdler < CrystalScad::Assembly
	def show
    idler
	end
	
	def output
	  idler(true).rotate(x:90)
	end
	
	def idler(output=false)			
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
			
		assembly = cube([24,8+10,60]).translate(y:-10)
		#assembly -= bolt_assembly.translate(x:12,z:20)
		assembly -= hull(bolt.output, bolt.output.translate(y:30)).translate(x:12,z:24,y:-2)
		assembly -= hull(nut.output, nut.output.translate(y:30)).translate(x:12,z:36,y:-2)

		assembly -= hull(cylinder(d:18,h:13),cylinder(d:18,h:13).translate(y:40)).translate(x:12,z:24,y:-20)
		assembly = assembly.color(@@printed_color)
		
		assembly += bolt_assembly_show.translate(x:12,z:22) if output == false

		# mounting holes
		bolts = [Bolt.new(4,25,additional_diameter:0.5),Bolt.new(4,25,additional_diameter:0.5)]


		assembly -= bolts[0].output.rotate(x:90	).translate(x:7,y:8,z:10)	
		assembly -= bolts[1].output.rotate(x:90	).translate(x:7,y:8,z:50)	
		
		assembly += bolts[0].show.rotate(x:90	).translate(x:7,y:8,z:10)	if output == false
		assembly += bolts[1].show.rotate(x:90	).translate(x:7,y:8,z:50)	if output == false


		assembly
  end
  
end
