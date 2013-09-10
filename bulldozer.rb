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




class YPlateAssembly
  def initialize(args={})
    @args = args
    @args[:length] ||= 500
    @args[:rod_size] ||= 12    
    @args[:position] ||= 150 
    @args[:bed_size_x] ||= 225
    @args[:bed_size_y] ||= 225       
    @args[:bed_size_z] ||= 12
  end
  
  def show
    bed_plate=BedPlate.new(x:@args[:bed_size_x],y:@args[:bed_size_y],z:@args[:bed_size_z])
    holder_left=BedPlateBearingMount.new
    fixed = Rod.new().show.translate(x:holder_left.rod_position_x,z:holder_left.rod_position_z)   
    fixed += Rod.new().show.translate(x:@args[:bed_size_x]-holder_left.rod_position_x,z:holder_left.rod_position_z)      
    
    moving_table = holder_left.output.translate(x:0,z:-@args[:bed_size_z],y:(@args[:bed_size_x]-holder_left.holder_length)/2)          
    # holders on the right side
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_x]-holder_left.holder_length)/5)          
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_x]-holder_left.holder_length)/5*4)          
   
    moving_table += bed_plate.show
    assembly = fixed + moving_table.translate(y:@args[:position])
    
  end

end

assembly+= YPlateAssembly.new(length:500,rod_size:12,position:10).show.translate(z:0)
#assembly+=rod(500).translate(x:11.5,z:20.5)
#assembly+=rod(500).translate(x:200+10,z:20)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:100)

#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:200)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:210,z:20,y:150)
 
 
#assembly+=tslot_rectangle(225,500, TSlot.new(size:30,configuration:2), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30))    
#assembly+=Bolt.new(3,35).output
#assembly=TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8).show


#puts @@bom.output
puts "$fn=64;"+assembly.output
#puts TSlot.new(size:40,configuration:2).output

