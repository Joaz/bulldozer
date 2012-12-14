
//use <nema_motor.scad>
use <../postindustrial_automation/libs/tslot.scad>
use <../postindustrial_automation/libs/tslot.scad>

$fn=64;

module motor_mount(){

    difference(){
        union(){
            cube([42,4,42]);
            translate([0,-42+4,-4]) cube([42,42,4]);
        }    
        translate([21,5,21]) rotate([90,0,0]) cylinder(r=12,h=20);
        translate([5.2,5,5.2]) rotate([90,0,0]) cylinder(r=1.7,h=20);
        translate([31.5+5.2,5,5.2]) rotate([90,0,0]) cylinder(r=1.7,h=20);
        translate([5.2,5,31.5+5.2]) rotate([90,0,0]) cylinder(r=1.7,h=20);
        translate([31.5+5.2,5,31.5+5.2]) rotate([90,0,0]) cylinder(r=1.7,h=20);

    }        
        

}

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
module motor_mount2(){
    union(){
        difference(){
            union(){
                translate([-22-15,-6,-28]) cube([70,25,8]);    
                translate([-22-15,-6,-28]) cube([15+2,25,37]);    
                translate([15+3-2,-6,-28]) cube([15+2,25,37]);    
            }
            translate([-22-5,-2,0]) rotate([-90,0,0]) pushfit_rod(8.02,22);
            translate([23,-2,0]) rotate([-90,0,0]) pushfit_rod(8.02,22);
            // wood screws
            translate([10,10,-20]) rotate([180,0,0]) screw(20);
            translate([10-20,10,-20]) rotate([180,0,0]) screw(20);
        
        }
        rotate([90,0,0]) difference(){
            translate([-22,-28,0]) cube([40,53,6]);
	        // mount for DC gearbox motor PGM-37DC12/77 			
		    rotate([0,0,90]){
	            translate([0,2,0]) cylinder(r=12.5/2,h=150);
	            // motor shaft is 7mm above center; lowering the mounting bolts
	            translate(v=[7,2,-5]){
		            for(i=[0:5]){						
			            rotate(a=60*i, v=[0,0,1]) translate([0,31/2,0]) cylinder(r=2,h=15);	
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
//translate([23,-200,5]) rotate([0,0,0]) idler_post();

translate([19,0,5]) rotate([0,0,180]) motor_mount2();
//translate([-10,-120,0]) carriage_bottom();

//translate([-10,-120+53.5,10]) rotate([180,0,0]) carriage_bottom();

//translate([-10,-85,30]) rotate([0,90,0]) tslot20(100);
//translate([-10,-95+20,30]) rotate([0,90,0]) tslot20(100);

//translate([21,28,21]) color("silver") rotate([90,0,0]) nema();

// rods
%translate([-4,0,5]){
    // m5 
    color("silver") translate([25,0,0]) rotate([90,0,0]) cylinder(r=2.5,h=300);
    
    color("silver") rotate([90,0,0]) cylinder(r=4,h=300);
    color("silver") translate([50,0,0]) rotate([90,0,0]) cylinder(r=4,h=300);
}



