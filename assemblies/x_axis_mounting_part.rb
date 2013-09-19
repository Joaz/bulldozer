class XAxisMountingPart < CrystalScad::Assembly
	
	def description
		"printed part: X axis mount part"
	end	
	
	def part(output=false)
		assembly = cube([30,30,6]).translate(x:30,y:30)
		
		#assembly += cube([6,60,60]).translate(x:-6)
		b = Bolt.new(8,20,type:"7380").output.translate(y:45,x:45,z:-6)
    if output == true
      assembly -= b
    else
  		assembly += b
    end
    
    assembly += tslot_insert.translate(x:30,y:30)
#    assembly += TSlot.new(size:30).show(300).color("Silver").translate(x:30,y:30)
		
		assembly += rod_holder.translate(x:15,y:45)
		assembly += rod_holder.translate(x:45,y:15)

    assembly += hull(cube([10,1,20]).translate(x:30,y:20),cube([10,1,20]).translate(x:20,y:30))
		
		assembly	
	end
  
  def rod_holder
    res =cube([30,30,20]).translate(x:-15,y:-15)
    res -= cylinder(d:12,h:20).translate(z:2.5)
  end
  
  def tslot_insert_wall
    wall = cube([16,2,20]).translate(x:7,y:2.4)
    wall += cube([8.6,4.6,20]).translate(x:10.7,y:2.4+2)  
    wall += cube([8.1,2.5,20]).translate(x:10.95,y:-0.1)  

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
	  part(true)
	end
end

