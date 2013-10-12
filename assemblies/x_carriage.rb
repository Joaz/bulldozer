class XCarriage < CrystalScad::Assembly
  def initialize(args={})
		@side_thickness=3.5    
		super
  end
  
  def show
    res = part_left
    res += part_right(true).mirror(z:1).translate(z:67)
    res
  end
  
  def output
    #res = part_left(false)
    res += part_right(false)
  end
  
	def base
    res = cube([30,28,30+@side_thickness]).translate(x:30)
    res += cube([28,30-5,30+@side_thickness]).translate(y:30+2)
    res += hull(cube([30,5,@side_thickness]).translate(x:0,y:30),cube([5,30,@side_thickness]).translate(x:30,y:0))
    res -= cube([30,30,60]).translate(x:28,y:28,z:-0.1)
    res -= cylinder(d:5.5,h:60).translate(x:29,y:30,z:-0.1)    
      
    res -= cylinder(d:21.5,h:40).translate(x:15,y:45,z:15+@side_thickness)        
    res -= cylinder(d:14,h:40).translate(x:15,y:45,z:-0.1)  

    res -= cylinder(d:21.5,h:40).translate(x:45,y:15,z:@side_thickness)        
    res -= cylinder(d:14,h:40).translate(x:45,y:15,z:-0.1)  
		res
	end
	
	def part_left
	  base.color(@@printed_color)
	end
	
  def part_right(show)

		
		res = base
			

    # this wall will hit the x endstop
    res += cube([7,30,30+@side_thickness]).translate(y:55,x:15.5)
    


    bearings = [Lm_uu.new(inner_diameter:12),Lm_uu.new(inner_diameter:12),Lm_uu.new(inner_diameter:12)]

   # if show
	#	  res += bearings[0].show.translate(x:15,y:45,z:15+@side_thickness) 
	#	  res += bearings[1].show.translate(x:45,y:15,z:@side_thickness)
#	    res += bearings[1].show.translate(x:45,y:15,z:30+@side_thickness)
#		end
    res   
  end
  
end
