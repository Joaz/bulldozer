

//use <nema_motor.scad>
use <../postindustrial_automation/libs/tslot.scad>
include <shapes.scad>
use <coupling.scad>


$fn=64;


module carriage_bottom(w=53.5){
    difference(){
        #translate([-4,0,-5]) cube([70,w,10]);
        // smooth rod profile
        translate([6,80,5]) rotate([90,0,0]) cylinder(r=4.7,h=100);        
        translate([6+50,80,5]) rotate([90,0,0]) cylinder(r=4.7,h=100);        
        // lme8luus
        translate([6,50,5]) rotate([90,0,0]) cylinder(r=8.1, h=46.4);   
        translate([6+50,50,5]) rotate([90,0,0]) cylinder(r=8.1, h=46.4);   
        
        // axis
        translate([6+25,80,5]) rotate([90,0,0]) cylinder(r=3, h=100);   
        // trapped nut
        translate([6+25,25+4,5]) rotate([90,0,0]) cylinder(r=4.6, h=4.2, $fn=6);   
        
        // mounting holes
        translate([6+14,w/2,-25]) cylinder(r=2.6, h=42);   
        translate([6+14+22,w/2,-25]) cylinder(r=2.6, h=42);   

        translate([6+14,5,-25]) cylinder(r=1.7, h=42);   
        translate([6+14+22,5,-25]) cylinder(r=1.7, h=42);   
        translate([6+14,w-5,-25]) cylinder(r=1.7, h=42);   
        translate([6+14+22,w-5,-25]) cylinder(r=1.7, h=42);   
        
    }
      

}

// dc motor
module motor_mount(){
    union(){
        difference(){
            union(){
                translate([-22-15-35,-6,-28]) cube([90,25,8]);    
                translate([12.5,-6,-28]) cube([15,25,40]);    
            }
            translate([19,-0,4.5]) rotate([-90,0,0]) cylinder(r=4.05,h=20); // #pushfit_rod(8.0,22);
 
            // wood screws
            translate([-40,10,-20]) rotate([180,0,0]) screw(20);
            translate([-20,10,-20]) rotate([180,0,0]) screw(20);
            translate([-60,10,-20]) rotate([180,0,0]) screw(20);
        
        }
        rotate([90,0,0]) difference(){
            translate([-22,-28,0]) cube([40,58,6]);
	        // mount for DC gearbox motor PGM-37DC12/77 			
		    translate([0,5,0]) rotate([0,0,90]){
	            translate([0,2,-10]) cylinder(r=12.5/2,h=150);
	            // motor shaft is 7mm above center; lowering the mounting bolts
	            translate(v=[7,2,-5]){
		            for(i=[0:5]){						
			           rotate(a=60*i, v=[0,0,1]) translate([0,31/2,-1]) cylinder(r=2,h=15);	
		            }
	            } 
	        }

        }
    
    
    }
    
}

module idler_post(){

        difference(){
            union(){
                translate([-22-15,-6,-28]) cube([70,25,8]);    
                translate([-22-15,-6,-28]) cube([15+2,25,37]);    
                translate([15+3-2,-6,-28]) cube([15+2,25,37]);    
            }
            translate([-22-5,-10,0]) rotate([-90,0,0]) pushfit_rod(8.1,40);
            translate([23,-10,0]) rotate([-90,0,0]) pushfit_rod(8.1,40);
            // wood screws
            translate([10,6,-20]) rotate([180,0,0]) screw(20);
            translate([10-20,6,-20]) rotate([180,0,0]) screw(20);
        
        }

}


// taken from Prusa 3 repository
module pushfit_rod(diameter,length){
    cylinder(h = length, r=diameter/2, $fn=30);
    translate([0,-diameter/4,length/2]) cube([diameter,diameter/2,length], center = true);

    translate([0,-diameter/2-1.2,length/2]) cube([diameter,1,length], center = true);
}
// taken from Prusa 3 repository
module screw(h=20, r=2, r_head=3.5, head_drop=0, slant=true, poly=false, $fn=0){
    //makes screw with head
    //for substraction as screw hole
    if (poly) {
        cylinder_poly(h=h, r=r, $fn=$fn);
    } else {
        cylinder(h=h, r=r, $fn=$fn);
    }
    if (slant) {
        translate([0, 0, head_drop-0.01]) cylinder(h=r_head, r2=0, r1=r_head, $fn=$fn);
    }

    if (head_drop > 0) {
        translate([0, 0, -0.01]) cylinder(h=head_drop+0.01, r=r_head, $fn=$fn);
    }
}

// TODO: clean unused code up ^^
// new code


module supported_12mm_shaft(length){
    color("silver") union(){
        cylinder(r=6,h=length);
        // triangle: 50° top angle, 65° bottom angles, h=17 (center of the rod, 5mm above the bottom) 
        // using approximation here for simplicity
        translate([8.5,-17,length/2]) equiTriangle(17,length);
        translate([-20,-17-5,0]) cube([40,5,length]);       
        
    }
}

module lme12uuop(){
    difference(){
        cylinder(r=11,h=32);
        translate([0,0,-0.5]) cylinder(r=6,h=33);        
        translate([-4,-13,-0.5]) cube([8,10,33]);
        rotate([0,0,20]) translate([-2,-13,-0.5]) cube([4,10,33]);
        rotate([0,0,-20]) translate([-2,-13,-0.5]) cube([4,10,33]);
    }

}

module lme12uuop_bushing(){
    difference(){
        translate([-20,-8-2,0]) cube([40,28,42]);
        cylinder(r=9, h=40);
        translate([0,0,3]) cylinder(r=(22+0.15)/2, h=40);
        // cutout for rod support triangle 
        translate([-4,-15,-0.5]) cube([8,10,33]);
        rotate([0,0,20]) translate([-1,-15,-0.5]) cube([4,10,50]);
        rotate([0,0,-20]) translate([-3,-15,-0.5]) cube([4,10,50]);
        
        // top mount
        translate([15.1,8.5,36.4]) rotate([0,90,0]) cylinder(r=3.8,h=5); 
        translate([-25,8.5,36.4]) rotate([0,90,0]) cylinder(r=1.7,h=50); 
        translate([-20.1,8.5,36.4]) rotate([0,90,0]) rotate([0,0,30]) cylinder(r=3.3,h=5,$fn=6);
        
        // side mount
        translate([-21.1,0,3+16]) rotate([0,90,0]) cylinder(r=3.8,h=5); 
        translate([-25,0,3+16]) rotate([0,90,0]) cylinder(r=1.7,h=25); 
        translate([-14,0,3+16]) rotate([0,90,0]) rotate([0,0,30]) cylinder(r=3.3,h=5,$fn=6);
        
        
    }
}

module lme12uuop_bushing_with_tslot_mount(){
    union(){
       lme12uuop_bushing();
       difference(){
           translate([-20,18,0]) cube([40,20,12.6]);
           
           translate([-10,18+10,7.5]) cylinder(r=2.6,h=20);
           translate([-10,18+10,-0.1]) cylinder(r=4.5,h=7.5);

           translate([10,18+10,7.5]) cylinder(r=2.6,h=20);
           translate([10,18+10,-0.1]) cylinder(r=4.5,h=7.5);
       
       }
    }

}

module triple_rail(length){
    union(){
        tslot20(length);
        translate([0,20,0]) tslot20(length);
        translate([0,40,0]) tslot20(length);
    
    }
}

module lm8uu_holder_for_tslot(){

    difference(){
        union(){
            cube([28,18,16.4]);    
            translate([8,-7-12,0]) cube([10,18+14+12,16.1]);
            
        }    
        translate([1.9,9,8.5]) rotate([0,90,0]) cylinder(r=7.6,h=24.2);     
        translate([-1,9,8.5]) rotate([0,90,0]) cylinder(r=5,h=30);     
        
        translate([1.9,1.5,24]) rotate([0,90,0]) cube([15,15.2,24.5]);     
        
        // bolt mounting holes
        translate([13,-3,-1]) cylinder(r=2.7, h=30);
        translate([13,21,-1]) cylinder(r=2.7, h=30);

        // axis
        translate([0,-12,8.5]) rotate([0,90,0]) cylinder(r=3, h=100);   
        // m5 nut
        translate([11,-12,8.5]) rotate([0,90,0]) cylinder(r=4.6, h=4.2, $fn=6);   
        // yes, I'm lazy'
        translate([11,-12,8.5+4]) rotate([0,90,0]) cylinder(r=4.6, h=4.2, $fn=6);   
        translate([11,-12,8.5+8]) rotate([0,90,0]) cylinder(r=4.6, h=4.2, $fn=6);   
        

       
    }    

}

//translate([23,-200,5]) rotate([0,0,0]) idler_post();

//translate([19,0,5]) rotate([0,0,180]) motor_mount2();
//translate([-10,-120,0]) carriage_bottom();

//translate([-10,-120+53.5,10]) rotate([180,0,0]) carriage_bottom();

//translate([-10,-85,30]) rotate([0,90,0]) tslot20(100);
//translate([-10,-95+20,30]) rotate([0,90,0]) tslot20(100);

//translate([21,28,21]) color("silver") rotate([90,0,0]) nema();

// top plate of the printer

//#translate([0,0,3]) translate([-20,0,0]) lme12uuop();


%translate(){
    translate([13,-100,34]) rotate([90,0,0]){
        translate([0,0,3]) lme12uuop();
        lme12uuop_bushing_with_tslot_mount();

    }
    translate([13,-140,34]) rotate([90,0,0]){
        translate([0,0,3]) lme12uuop();
        translate([0,0,44]) rotate([0,180,0]) lme12uuop_bushing_with_tslot_mount();
    }

    translate([-160,-172,72]) rotate([0,90,0]) triple_rail(200);


    translate([-4,0,5]){
        translate([0,-474,-5]) cube([100,474,12]);
        // m5 
        color("silver") translate([-31+21,0,39.5]) rotate([90,0,0]) cylinder(r=2.5,h=300);
        // 8mm smooth support rod
        color("silver") translate([-31,0,39.5]) rotate([90,0,0]) cylinder(r=4,h=450);
        
        #translate([-22,-155,31]) rotate([0,0,90]) lm8uu_holder_for_tslot();

        
        
        translate([17,-12,29]) rotate([90,0,0]) supported_12mm_shaft(450); 
    }
    
   translate([-14,-25,40]) rotate([0,0,90]){
      coupling(0);
      translate([0,0,8]) rotate([0,180,0]) coupling(0);
   
   } 

}


// Printable parts
//
// LME12UUOP bearing holder (for testing)

//translate([-20,0,0]) lme12uuop_bushing();

// LME12UUOP bearing holder with mount
// translate([-50,0,0]) lme12uuop_bushing_with_tslot_mount();


// LM8UU holder for support shaft
//rotate([0,0,90]) lm8uu_holder_for_tslot();


translate([-16,-10,40]) rotate([0,0,180]) motor_mount();





