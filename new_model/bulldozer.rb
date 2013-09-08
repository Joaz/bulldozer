#!/usr/bin/ruby1.9.3

#while inotifywait -e close_write bulldozer.rb; do ./bulldozer.rb > bulldozer.scad; done


require "rubygems"
require "crystalscad"

include CrystalScad




def tslot_rectangle(x,y,tslot_type_x,tslot_type_y)
	size = tslot_type_x.args[:size]
	# x 
	r = tslot_type_x.output(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:size)
	r += tslot_type_x.output(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:y)   
 
  # y
	r += tslot_type_y.output(y).rotate(x:-90)
	r += tslot_type_y.output(y).rotate(x:-90).translate(x:x-size)
  
  return r.color("Silver")
end


class BedPlate
	attr_accessor :size
	def initialize(size)
		@size=size		
	end

	def output
		r = cube([@size[:x],@size[:y],@size[:z]])
		@@bom.add("laminated plywood cut #{@size[:x]}x#{@size[:y]}, thickness=#{@size[:z]}mm")
	
		r = r-bolts		
		return r.color("SaddleBrown")	
	end	
	
	def show
		output+bolts
	end


	def bolts
		bolts =  Bolt.new(3,25).output.translate(x:12.5,y:12.5)
		bolts += Bolt.new(3,25).output.translate(x:12.5+200,y:12.5)
		bolts += Bolt.new(3,25).output.translate(x:12.5,y:12.5+200)
		bolts += Bolt.new(3,25).output.translate(x:12.5+200,y:12.5+200)
		bolts
	end
	

end

def rod(length,size=12)
	cylinder(d:size,h:length).rotate(x:-90)
end
bed_plate=BedPlate.new(x:225,y:225,z:12)


assembly=ScadObject.new
assembly+=bed_plate.show.translate(z:20)

#assembly+=bed_plate.output.translate(z:20)

#assembly+=rod(500).translate(x:15,z:10)
#assembly+=rod(500).translate(x:200+10,z:10)

assembly+=tslot_rectangle(225,500, TSlot.new(size:30,configuration:2), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30))    
#assembly+=Bolt.new(3,35).output
#assembly=TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8).show

#puts @@bom.output
puts "$fn=64;"+assembly.output
#puts TSlot.new(size:40,configuration:2).output

