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





assembly=CrystalScadObject.new



assembly+= YPlateAssembly.new(length:470,rod_size:12,position:100).show.translate(z:3.5,y:30,x:35)

assembly+=tslot_rectangle(225+60+10,520, TSlot.new(size:30,configuration:2), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30))    




assembly += Nema17.new.show.rotate(y:90).translate(x:95,y:460,z:-7-14)
assembly += Belt.new.show.translate(x:150,y:40,z:-14)
assembly += YBeltHolder.new.show.translate(x:135,y:230,z:3)
assembly += YBeltIdler.new.show.rotate(y:90).translate(x:123,y:40,z:-8)

#assembly = YBeltIdler.new.show
# FIXME: YBeltHolder and BedPlateBearingMount are both missing wood screws 



#assembly+= ZAxisAssembly.new.show 

#assembly += Bearing.new(:type => "624", :flange=>true).show.rotate(y:90)


file = File.open("bom.txt","w")
file.puts @@bom.output
file.close
puts "$fn=64;"+assembly.scad_output
#puts TSlot.new(size:40,configuration:2).output

