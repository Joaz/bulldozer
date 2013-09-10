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


#puts @@bom.output
puts "$fn=64;"+assembly.output
#puts TSlot.new(size:40,configuration:2).output

