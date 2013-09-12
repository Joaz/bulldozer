#!/usr/bin/ruby1.9.3

#while inotifywait -e close_write bulldozer.rb; do ./bulldozer.rb > bulldozer.scad; done


require "rubygems"
require "crystalscad"
require "require_all"

require_all "assemblies"

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





assembly=ScadObject.new



assembly+= YPlateAssembly.new(length:470,rod_size:12,position:100).show.translate(z:3.5,y:30,x:35)
#assembly+=rod(500).translate(x:11.5,z:20.5)
#assembly+=rod(500).translate(x:200+10,z:20)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:100)

#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:200)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:210,z:20,y:150)
 
assembly+=tslot_rectangle(225+60+10,520, TSlot.new(size:30,configuration:2), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30))    
#assembly+=Bolt.new(3,35).output
#assembly=TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8).show

#sketch
# y motor sketch
#assembly += Nema17.new.show.rotate(y:90).translate(x:100,y:445)



assembly+= ZAxisAssembly.new.show 


class Belt
	def initialize(args={})
		@args=args
		@args[:belt_thickness] ||= 0.9
		@args[:width] ||= 6
		# TODO: BOM entry for this one
	end

	def show

		
		belt = line(200)
		belt+= turn_180(13)
		belt+= line(420).translate(z:-13-@args[:belt_thickness])
		belt+= turn_180(13).mirror(y:1).translate(y:420)
		belt+= line(200).translate(y:220)


		belt.color("DarkSlateGray")
	end
	
	def line(length)
		cube([@args[:width], length, @args[:belt_thickness]])
	end

	def turn_180(diameter)
		turn = cylinder(d:diameter+@args[:belt_thickness]*2,h:@args[:width])
		cut_cyl1 = cylinder(d:diameter,h:@args[:width]+0.2).translate(z:-0.1)
		cut_cyl2 = cylinder(d:diameter,h:@args[:width]+0.2).translate(z:-0.1, y:diameter/2)
		turn -= hull(cut_cyl1,cut_cyl2)

		turn.rotate(y:90).translate(z:-diameter/2+@args[:belt_thickness]/2)
	
	end	
	
end

assembly += Belt.new.show.translate(x:150,y:40)




#puts @@bom.output
puts "$fn=64;"+assembly.output
#puts TSlot.new(size:40,configuration:2).output

