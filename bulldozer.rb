#!/usr/bin/ruby1.9.3

#while inotifywait -e close_write bulldozer.rb; do ./bulldozer.rb > bulldozer.scad; done


require "rubygems"
require "crystalscad"

include CrystalScad

@@printed_color="Bisque"


def tslot_rectangle(x,y,tslot_type_x,tslot_type_y)
	size = tslot_type_x.args[:size]
	# x 
	r = tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:size)
	r += tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:y)   
 
  # y
	r += tslot_type_y.show(y).rotate(x:-90)
	r += tslot_type_y.show(y).rotate(x:-90).mirror(x:1).translate(x:x)
  
  return r.color("Silver")
end

 
class BedPlate
	attr_accessor :size
	def initialize(size)
		@size=size		
		
		@bolt_positions = [{x:12.5,y:12.5},{x:12.5+200,y:12.5},{x:12.5,y:12.5+200},{x:12.5+200,y:12.5+200}]
		
	end

	def output
		r = cube([@size[:x],@size[:y],@size[:z]])
		@@bom.add("laminated plywood cut #{@size[:x]}x#{@size[:y]}, thickness=#{@size[:z]}mm")
	
		r = r-bolts		
		return r.color("SaddleBrown")	
	end	
	
	def show
		output+bolts+nuts
	end

	def bolts
		@bolt_positions.each do |pos|
			@bolt += Bolt.new(3,25).output.translate(pos)		
		end
		@bolt
	end

	def nuts
		nut_height = Nut.new(3,no_bom:true).height + 0.05
	
		(0..2).each do |i| 		
			@bolt_positions.each do |pos|
				@nut += Nut.new(3).show.	translate(pos).translate(z:@size[:z]+i*nut_height)
			end		
		end

		@nut 
	end	
	

end

class BedPlateBearingMount
    
    def show
      output
    end
    
    def output
      side_thickness_x = 1
      side_thickness_y = 2
      side_thickness_base = side_thickness_x
      side_thickness_screw_wall = 3
      rod_diameter=12
      plate_thickness=12
      length_margin=0.2
      diameter_margin=0.05
      
      bearing=Lm_uu.new(inner_diameter:rod_diameter)
      diameter, length = bearing.dimensions
      length+=length_margin
      diameter+=diameter_margin
         
      holder_length = length+side_thickness_y*2
      holder_height = diameter+side_thickness_base
      
      base = cube([diameter+side_thickness_x*2, holder_length, holder_height])      
      
      part = base 
      
      bearing_cut = cylinder(d:diameter,h:length).rotate(x:90).translate(x:base.x/2,y:base.y-side_thickness_y)
      bearing_cut2 = cylinder(d:diameter,h:length).rotate(x:90).translate(x:base.x/2,y:base.y-side_thickness_y,z:diameter/2)
    
      part -= hull(bearing_cut,bearing_cut2).translate(z:side_thickness_base+diameter/2)
      part -= rod(length+side_thickness_y*2+0.2,size=rod_diameter*1.2).translate(x:base.x/2,y:-0.1,z:side_thickness_base+diameter/2) 
      # side mount wall
      part += cube([side_thickness_screw_wall, holder_length, plate_thickness+holder_height]).translate(x:-side_thickness_screw_wall)
      part -= Bolt.new(3,20).output.rotate(y:90).translate(x:-side_thickness_screw_wall,y:holder_length/3,z:holder_height+plate_thickness/2)
      part -= Bolt.new(3,20).output.rotate(y:90).translate(x:-side_thickness_screw_wall,y:holder_length/3*2,z:holder_height+plate_thickness/2)
      
      assembly = bearing.show.rotate(x:90).translate(x:base.x/2,y:base.y-side_thickness_y,z:side_thickness_base+diameter/2)
      assembly+=part.color(@@printed_color)
      
    end
    
end

def rod(length,size=12)
	cylinder(d:size,h:length).color("GhostWhite").rotate(x:-90)
end
bed_plate=BedPlate.new(x:225,y:225,z:12)


assembly=ScadObject.new
assembly+=bed_plate.show.translate(z:31)

#assembly+=bed_plate.output.translate(z:20)

assembly+=rod(500).translate(x:11.5,z:20.5)
assembly+=rod(500).translate(x:200+10,z:20)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:100)
assembly += BedPlateBearingMount.new.output.translate(x:0,z:9,y:100)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:200)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:210,z:20,y:150)
 
 
assembly+=tslot_rectangle(225,500, TSlot.new(size:30,configuration:2), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30))    
#assembly+=Bolt.new(3,35).output
#assembly=TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8).show


#puts @@bom.output
puts "$fn=64;"+assembly.output
#puts TSlot.new(size:40,configuration:2).output

