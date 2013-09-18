#!/usr/bin/ruby1.9.3

require "rubygems"
require "crystalscad"
require "require_all"

require_all "assemblies"




include CrystalScad



@@printed_color="Bisque"
@tslot_simple = true
 

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



#assembly+= YPlateAssembly.new(length:470,rod_size:12,position:100).show.translate(z:3.5,y:30,x:35)

assembly+=tslot_rectangle(225+60+10,520, TSlot.new(size:30,configuration:2,simple:@tslot_simple), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30,simple:@tslot_simple))    




#assembly += Nema17.new.show.rotate(y:90).translate(x:95,y:460,z:-7-14)
#assembly += Belt.new.show.translate(x:150,y:40,z:-14)
#assembly += YBeltHolder.new.show.translate(x:135,y:230,z:3)
#assembly += YBeltIdler.new.show.rotate(y:90).translate(x:123,y:40,z:-8)

# FIXME: YBeltHolder and BedPlateBearingMount are both missing wood screws 


assembly+= ZAxisAssembly.new(tslot_simple:true).show

class AcmeNut < CrystalScad::Assembly
  def initialize(args={})
    @args = args
    @args[:shape] = "cylinder"
    super
  end
  
  def show
    return cylinder_nut(false) if @args[:shape] == "cylinder"
    return hex_nut(false) if @args[:shape] == "hexagonal"
  end

  def output
    return cylinder_nut(true) if @args[:shape] == "cylinder"
    return hex_nut(true) if @args[:shape] == "hexagonal"
  end
  
  def cylinder_nut(output)
    nut = cylinder(d:22,h:20)
    if output == false
      nut -= cylinder(d:10,h:20.2).translate(z:-0.1)
    else
      nut += cylinder(d:12,h:30).translate(z:-5)
    end
    nut.color("Goldenrod")
  end
  
  def hex_nut
    # todo
  end
  
  
end

class XAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args=args
    @args[:position] ||= 15
  end
  
  def show
    # z bearings
    axis  = Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15,z:-50)
    axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15,z:35)
    
    axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15+270,z:-30)
    axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15+270,z:35)

    axis += TSlot.new(size:30).show(300).rotate(y:90).color("Silver")
    axis += Rod.new(length:300).show.rotate(z:-90).translate(y:15,z:15)
    axis += Rod.new(length:300).show.rotate(z:-90).translate(y:-10,z:-15)
    axis += Lm_uu.new(inner_diameter:12).rotate(y:90).translate(y:15,z:15,x:@args[:position]+20)
    axis += Lm_uu.new(inner_diameter:12).rotate(y:90).translate(y:-10,z:-15,x:@args[:position])
    axis += Lm_uu.new(inner_diameter:12).rotate(y:90).translate(y:-10,z:-15,x:@args[:position]+40)
    #axis += Belt.new(longest_side_length:280,top_side_length:250).show.rotate(z:-90,y:90).translate(x:13,y:-10,z:10)
    #axis += Nema17.new.show.rotate(x:180).translate(x:13,y:-5,z:75)
    axis += AcmeNut.new.show.translate(x:-23,y:15,z:-30)
    
    axis +=  Nema17.new.show.rotate(x:90).translate(x:30,y:95,z:25)
    axis += Belt.new(longest_side_length:270,top_side_length:250,position:20).show.rotate(z:-90,y:180).translate(x:30,y:30,z:25-7)
   
    # now need parts that fit into the t-slot on the ends and get tightened by M8
    # t-slot dimensions
    # opening = 8.1
    # wall 2.3
    # rectangular slot beind wall: 16.2x2.1-2.2
   
   end
end

assembly += Rod.new(length:370).show.rotate(x:90).translate(y:280,x:15,z:0)
assembly += Rod.new(length:370).show.rotate(x:90).translate(y:280,x:15+270,z:0)


#x_sketch += Bolt.new(4,20).rotate(x:90).translate(y:20,z:-35,x:45)
#x_sketch += Nut.new(4).rotate(x:90).translate(y:0,z:-35,x:45)

assembly += XAxisAssembly.new.show.translate(z:90+0,y:240)


file = File.open("bom.txt","w")
file.puts @@bom.output
file.close
puts "$fn=64;"+assembly.scad_output
#puts TSlot.new(size:40,configuration:2).output

