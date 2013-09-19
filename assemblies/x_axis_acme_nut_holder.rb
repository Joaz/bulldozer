class XAxisAcmeNutHolder < CrystalScad::Assembly
	
	def description
		"printed part: X axis acme nut holder"
	end	
	
	def part(output=false)
		assembly = cube([60,30,6]).translate(x:0,y:30)
		assembly += cube([30,30,18]).translate(x:0,y:30)
		
		
		
		nut = AcmeNut.new

    
		assembly += nut.show.rotate(y:90).translate(x:5,y:45,z:18) if output == false
		
		assembly -= nut.output.rotate(y:90).translate(x:5,y:45,z:18)
		
		
		
		b = Bolt.new(8,20,type:"7380",no_bom:true).output.translate(y:45,x:45,z:-6)
		# no bom here, because we're using the same bolt as in x_axis_mounting_part here
    assembly -= b
  
    # TODO: other part
    # TODO: more mounting points to the part on its back side. Maybe long bolts that go all the way through
    #       from the nut holder to the other part

    assembly
  end
  
  def output
    part(true)
  end
  
  def show
   part.rotate(y:90).mirror(x:1)
  end
    
end
