

module pusher(length){
	union(){
		cube([length, 10, 20]);	
		translate([length-10,0,0]) rotate(a=-60,v=[0,0,1]) cube([25,10,20]);
		translate([10,0,0]) mirror([1,0,0]) rotate(a=-60,v=[0,0,1]) cube([25,10,20]);


	}
}

pusher(100);