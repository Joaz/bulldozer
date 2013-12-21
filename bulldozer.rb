#!/usr/bin/ruby1.9.3

require "rubygems"
require "crystalscad"
require "require_all"

include CrystalScad
require_all "lib/**/*.rb"


@@printed_color="Bisque"
@tslot_simple = false
 



assembly=CrystalScadObject.new

assembly += BulldozerFrameAssembly.new.show
#assembly += BulldozerAssembly.new.show

#assembly+=YPlateAssembly.new(length:405,rod_size:12,position:-20+0).show.translate(z:3.5,y:30,x:35)




# TODO: move this stuff to the YPlateAssembly
#assembly += YMotorMount.new.show.rotate(z:-180).rotate(y:-90).translate(x:160,y:413,z:-32)

#assembly += Belt.new.show.translate(x:150,y:12,z:-14)
#assembly += YBeltHolder.new.show.translate(x:135,y:230,z:3)
#assembly += YBeltIdler.new.show.rotate(y:90).translate(x:123,y:40,z:-8)

#assembly += YRodHolder.new.show.rotate(x:90).translate(y:440,x:55,z:-8.5)
#assembly += YRodHolder.new.show.rotate(x:90).mirror(x:1).translate(y:440,x:55+185,z:-8.5)
#assembly += YRodHolder.new.show.rotate(x:90).mirror(y:1).translate(y:30,x:55,z:-8.5)
#assembly += YRodHolder.new.show.rotate(x:90).mirror(y:1).mirror(x:1).translate(y:30,x:55+185,z:-8.5)

#assembly += YEndstopHolder.new.show.translate(y:438,z:-5)



#assembly += XAxisAssembly.new.show.translate(z:100+0,y:240+48,x:-2.5)

#assembly +=RumbaMount.new.show.translate(x:45,y:300,z:-75)




#subassembly = MotorMount.new.show

#subassembly = YRodHolder.new.show
#subassembly = ZLinearBearingHolder.new.output
#subassembly = YBeltHolder.new.output
#subassembly = XBeltIdler.new.output
#subassembly = YBeltIdler.new.output

#subassembly = XCarriage.new.output
#subassembly = MGS.new.show
#subassembly = MicroswitchD3V.new.show
#subassembly = ZMotorMount.new.output
#subassembly = ZAcmeBearingHolderLower.new.output

#subassembly = ZAcmeBearingHolderUpper.new.output
#subassembly = ZRodHolder.new.output
#subassembly = XAxisMountingPart.new.output
#subassembly = XAxisAcmeNutHolder.new.output
#subassembly = JHead.new.show
#subassembly = BedPlateBearingMount.new.output
#subassembly = YMotorMount.new.output

#subassembly = YEndstopHolder.new

#subassembly = RumbaMount.new

#subassembly = Foot.new.output
#subassembly = BulldozerAxis.new.output
#subassembly = BulldozerFrameAssembly.new.output

subassembly = RubberDampener.new.show


#subassembly = PSU_sp320_12.new.show


def save(file,output,start_text=nil)
  file = File.open(file,"w")
  file.puts start_text unless start_text == nil
  file.puts output
  file.close
end

save("bom.txt",@@bom.output)
save("bulldozer.scad",assembly.scad_output,"$fn=64;") if assembly
save("part.scad",subassembly.scad_output,"$fn=64;") if subassembly rescue nil

parts = [RumbaMount,ZAcmeBearingHolderLower,ZAcmeBearingHolderUpper,XCarriage,ZLinearBearingHolder,YMotorMount,BedPlateBearingMount,XAxisAcmeNutHolder, XAxisMountingPart,YBeltHolder,YBeltIdler,YRodHolder,ZMotorMount,ZRodHolder,XBeltIdler, Foot]
unless Dir.exists?("output")
  Dir.mkdir("output")
end

parts.each do |part|
  name = part.to_s.downcase
  save("output/#{name}.scad",part.new.output.scad_output,"$fn=64;")
  if ARGV[0] == "build"
    puts "Building #{name}..."
    system("openscad -o output/#{name}.stl output/#{name}.scad")
    system("admesh output/#{name}.stl -b output/#{name}.stl")
  end

end

  
  



