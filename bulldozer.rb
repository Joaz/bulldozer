#!/usr/bin/ruby1.9.3

require "rubygems"
require "crystalscad"
require "require_all"

require_all "assemblies"

include CrystalScad

@@printed_color="Bisque"
@tslot_simple = true
 


# FIXME: update the mounting of the tslot
# FIXME: move this into an Assembly
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



assembly+= YPlateAssembly.new(length:470,rod_size:12,position:-30).show.translate(z:3.5,y:30,x:35)

assembly+=tslot_rectangle(225+60+10,520, TSlot.new(size:30,configuration:2,simple:@tslot_simple), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30,simple:@tslot_simple))    




#assembly += Nema17.new.show.rotate(y:90).translate(x:95,y:460,z:-7-14)
#assembly += Belt.new.show.translate(x:150,y:40,z:-14)
#assembly += YBeltHolder.new.show.translate(x:135,y:230,z:3)
#assembly += YBeltIdler.new.show.rotate(y:90).translate(x:123,y:40,z:-8)

# FIXME: YBeltHolder and BedPlateBearingMount are both missing wood screws 


assembly+= ZAxisAssembly.new(tslot_simple:true).show



subassembly = MGS.new.show
#subassembly = XAxisMountingPart.new.output
#subassembly = XAxisAcmeNutHolder.new.output
#subassembly = JHead.new.show

assembly += Rod.new(length:370).show.rotate(x:90).translate(y:280,x:15,z:0)
assembly += Rod.new(length:370).show.rotate(x:90).translate(y:280,x:15+270,z:0)


assembly += XAxisAssembly.new.show.translate(z:105+0,y:240,x:-2.5)


file = File.open("bom.txt","w")
file.puts @@bom.output
file.close

if assembly
  file = File.open("bulldozer.scad","w")
  file.puts "$fn=64;"+assembly.scad_output
  file.close
end

if subassembly
  file = File.open("part.scad","w")
  file.puts "$fn=64;"+subassembly.scad_output
  file.close
end


