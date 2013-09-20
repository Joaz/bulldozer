class XAxisAcmeNutHolder < CrystalScad::Assembly
	
	def description
		"printed part: X axis acme nut holder"
	end	
	
	def main_part(output=false)
		assembly = cube([60,30,6]).translate(x:0,y:30)
		assembly += bolt_holder
		assembly += cube([30,30,17]).translate(x:0,y:30)
		
		
		
		nut = AcmeNut.new

    
		assembly += nut.show.rotate(y:90).translate(x:5,y:45,z:17) if output == false
		
		assembly -= nut.output.rotate(y:90).translate(x:5,y:45,z:17)
		
		
		
		b = Bolt.new(8,20,type:"7380",no_bom:true).output.translate(y:45,x:45,z:-6)
		# no bom here, because we're using the same bolt as in x_axis_mounting_part here
    assembly -= b
  
    # TODO: other part
    # TODO: more mounting points to the part on its back side. Maybe long bolts that go all the way through
    #       from the nut holder to the other part

    assembly
  end
  
  def bolt_holder(height=18,no_bom=true)
    res = cube([30,46,height]).translate(y:21)
    b = Bolt.new(4,40, no_bom:no_bom) 
    
    res -= b.output.translate(x:15,y:25,z:-1) 
    res -= b.output.translate(x:15,y:25+38.6,z:-1) 
    
  end
  
  def clamp(output=false)
    res = cube([30,30,12]).translate(x:0,y:30)
	  res+= bolt_holder(12)
	  
		nut = AcmeNut.new(no_bom:true)    	
		res -= nut.output.rotate(y:90).translate(x:5,y:45,z:12)
  end
  
  def output
    res = main_part(true)
    res += clamp(true).translate(y:-50)
  end
  
  def show
    res = main_part.rotate(y:90).mirror(x:1).color(@@printed_color)
    res+= clamp.rotate(y:90).translate(x:-30).color(@@printed_color)
    res += Bolt.new(4,40).show.rotate(y:90).translate(y:25,z:-15,x:-30) 
    res += Bolt.new(4,40).show.rotate(y:90).translate(y:63,z:-15,x:-30) 
  end
    
end
