class XAxisMountingPart < CrystalScad::Assembly
	
	def description
		"printed part: X axis mount part"
	end	
	
	def part(output=false)
		assembly = cube([30,30,6]).translate(x:30,y:30)
		
   
    assembly += tslot_insert.translate(x:30,y:30)
#    assembly += TSlot.new(size:30).show(300).color("Silver").translate(x:30,y:30)
		
		assembly += rod_holder.translate(x:-45,y:15).rotate(z:-90)
		assembly += rod_holder.translate(x:45,y:15)

    assembly += nut_traps(8,output)
    
    assembly += hull(cube([10,1,20]).translate(x:30,y:20),cube([10,1,20]).translate(x:19,y:30))
		
		assembly = assembly.color(@@printed_color)	
		b = Bolt.new(8,20,type:"7380").output.translate(y:45,x:45,z:-6)
    if output == true
      assembly -= b
    else
  		assembly += b
    end
    assembly
	end
  
  def nut_traps(height=18,output=false)
    res = cube([30,46,height]).translate(x:0,y:21)

    # nut trap for idler
    bolt = Bolt.new(4,20,no_bom:true)
		nut = Nut.new(4)
		res-= bolt.output.rotate(y:90).translate(x:-11,y:62,z:4)
		res-= hull(nut.output.rotate(z:30).rotate(y:90),nut.output.rotate(z:30).rotate(y:90).translate(z:5)).translate(x:2.5,y:62,z:3.8)
 		
    res-= cube([30,20,height+0.2]).translate(x:-0.1,y:35,z:-0.1)
    b = Bolt.new(4,40, no_bom:true) 
    
    res -= b.output.translate(x:15,y:25,z:-1) 
    res -= b.output.translate(x:15,y:25+38.6,z:-1) 
    
    nuts = [Nut.new(4),Nut.new(4)]
    
    res-= nuts[0].output.translate(x:15,y:25,z:height-3) 
    res-= nuts[1].output.translate(x:15,y:25+38.6,z:height-3) 
    
    if output == false
      res+= nuts[0].show.translate(x:15,y:25,z:height-3) 
      res+= nuts[1].show.translate(x:15,y:25+38.6,z:height-3) 
    end
    res
    
    
  end

  def rod_holder
    res = cube([30,30,6]).translate(x:-15,y:-15)
    res = cube([30,15,20]).translate(x:-15,y:0)
    res += cylinder(d:30,h:20)
    res -= cylinder(d:12.7,h:20).translate(z:2.5)
  end
  
  def tslot_insert_wall
    TSlotInsert.new.output
  end
  
  def tslot_insert
    tslot_insert = tslot_insert_wall
    tslot_insert += tslot_insert_wall.rotate(z:-90).translate(y:30)
    tslot_insert += tslot_insert_wall.rotate(z:90).translate(x:30)
    tslot_insert += tslot_insert_wall.rotate(z:180).translate(y:30, x:30)

  end
		
	def show
    part.rotate(y:90)
	end
	
	def output
		res = part(true)
		res += part(true).mirror(x:1).translate(x:125)
	end
end

