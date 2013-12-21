class XCarriage < CrystalScad::Assembly
  def initialize(args={})
		@side_thickness=3.5    
		super
    # initialize 2 long bolts
 		@bolts =[Bolt.new(4,70),Bolt.new(4,30)]
 		@nuts =[Nut.new(4),Nut.new(4)]

    @lm12uu_cut = 21.2

  end
  
  def show
    res = part_left(true)
    res += part_right(true).mirror(z:1).translate(z:67)
		res = res.color(@@printed_color)
		res += @bolts[0].show.translate(x:70,y:10,z:-0.1)
		res += @bolts[1].show.translate(x:-5,y:40,z:20-0.1)  

		res += @nuts[0].show.translate(x:70,y:10,z:67)
		res += @nuts[1].show.translate(x:-5,y:40,z:47)  

    
  end
  
  def output
    res = part_left(false)
    res += part_right(false).mirror(x:1).translate(x:105,y:-30)

		res
  end
  
	def base(show)
    res = cube([30,28,30+@side_thickness]).translate(x:30)

    res += cube([45,18,30+@side_thickness]).translate(x:30)

    res += cube([28,30-5,30+@side_thickness]).translate(y:30+2)
 
 
    res += hull(cube([30,5,@side_thickness]).translate(x:0,y:30),cube([5,30,@side_thickness]).translate(x:30,y:0))
    res -= cube([30,30,60]).translate(x:28,y:28,z:-0.1)
    res -= cylinder(d:5.5,h:60).translate(x:29,y:30,z:-0.1)    
      
    res -= cylinder(d:@lm12uu_cut,h:40).translate(x:15,y:45,z:1.5+@side_thickness)        
    res -= cylinder(d:14,h:40).translate(x:15,y:45,z:-0.1)  

    res -= cylinder(d:@lm12uu_cut,h:40).translate(x:45,y:15,z:1.5+@side_thickness)        
    res -= cylinder(d:14,h:40).translate(x:45,y:15,z:-0.1)  

		# extruder mount
    res -= cylinder(d:3.4,h:40).rotate(x:90).translate(x:65,y:20,z:@side_thickness+15)
		nut = Nut.new(3)    
		res -= nut.output.rotate(x:90).translate(x:65,y:18.1,z:@side_thickness+15)

    # for top screw mount
    top_bolt_mount = cube([12,15,10+@side_thickness]).translate(x:-12,y:32,z:20)
    # support wall
    top_bolt_mount += cube([0.8,15,30+@side_thickness]).translate(x:-12,y:32) unless show 

    res += top_bolt_mount
		
		# bolts to securely join the both halves together
		res -= @bolts[0].output.translate(x:70,y:10,z:-0.1)  
		res -= @bolts[1].output.translate(x:-5,y:40,z:20-0.1)  
		
		res
	end
	
	def part_left(show)
	  base(show)
	end
	
  def part_right(show)

		
		res = base(show)
			

    # this wall will hit the x endstop
    res += cube([7,30,30+@side_thickness]).translate(y:57,x:15.5)
    
    # wall for belt clamp
    res += cube([18,30,15+@side_thickness]).translate(y:57,x:-2,z:15)
	
		# extend bearing wall to the top
	  res += cube([2,10,30+@side_thickness]).translate(x:-2,y:32+15)

		# support wall
		res += cube([20,2,15]).translate(x:-2,y:85)

		# belt cutout
		res -= cube([1,6.5,60]).translate(x:-2.5,y:58).color("red")
	
		# belt clamp
	  clamp = cube([5,25,18]).translate(x:-8,y:48.5,z:15).color("yellow")
  		
		# FIXME no BOM entry for bolts
			  
		clamp_holes = cylinder(d:3.9,h:22).rotate(y:90).translate(x:-12,y:55,z:19)
	  clamp_holes += cylinder(d:3.9,h:22).rotate(y:90).translate(x:-12,y:55,z:29)

	  clamp_holes += cylinder(d:3.9,h:22).rotate(y:90).translate(x:-12,y:68,z:19)
	  clamp_holes += cylinder(d:3.9,h:22).rotate(y:90).translate(x:-12,y:68,z:29)
		
		res -= clamp_holes
		clamp -= clamp_holes
		
		if show
			res += clamp 
		else
			res += clamp.translate(z:-15)		
		end		
		


    bearings = [Lm_luu.new(inner_diameter:12),Lm_luu.new(inner_diameter:12)]

   # if show
	#	  res += bearings[0].show.translate(x:15,y:45,z:15+@side_thickness) 
	#	  res += bearings[1].show.translate(x:45,y:15,z:@side_thickness)
#	    res += bearings[1].show.translate(x:45,y:15,z:30+@side_thickness)
#		end
    res   
  end
  
end
