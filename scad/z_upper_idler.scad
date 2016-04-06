include <configuration.scad>
include <inc/functions.scad>
include <MCAD/bearing.scad>
include <MCAD/nuts_and_bolts.scad>

Q=25;
z_upper_idler();

module z_upper_idler(){
    
    bw = bearingWidth(z_idler_bearing);
    bi = bearingInnerDiameter(z_idler_bearing);
    bo = bearingOuterDiameter(z_idler_bearing);
    bt = 3; // Belt Thickness
    tolerance = 0.1; 
    cap_diameter = METRIC_NUT_AC_WIDTHS[z_guide_aluminium_fastener]+tolerance*2;

    bolt_length = 3*bw;
    
    idler_width = 2*z_plastic_thickness+bolt_length+2*cap_diameter;
    idler_height = max(alu_profile_side+z_plastic_thickness,2*z_plastic_thickness+bo+cap_diameter+2*bt);
    idler_depth = 2*z_plastic_thickness+bo+alu_profile_side+2*bt;
    
    difference(){
        cube_fillet([idler_width,idler_depth,idler_height],radius=-1, vertical=[0,0,5,5], top=[0,3,3,3], bottom=[3,3,3,3], center=false, $fn=0);
        
        translate([-1,idler_depth-alu_profile_side,idler_height-alu_profile_side])
            cube([idler_width+2,alu_profile_side+1,alu_profile_side+1]);
        
        translate([cap_diameter/2+z_plastic_thickness,-1,idler_height-alu_profile_side/2])
            rotate([-90,0,0])
                cylinder(r=cap_diameter/2,h=idler_depth-alu_profile_side-z_plastic_thickness+1,$fn=Q);
        translate([idler_width-cap_diameter/2-z_plastic_thickness,-1,idler_height-alu_profile_side/2])
            rotate([-90,0,0])
                cylinder(r=cap_diameter/2,h=idler_depth-alu_profile_side-z_plastic_thickness+1,$fn=Q);
                
        translate([cap_diameter/2+z_plastic_thickness,-1,idler_height-alu_profile_side/2])
            rotate([-90,0,0])
                cylinder(r=z_guide_aluminium_fastener/2,h=idler_depth,$fn=Q);
        translate([idler_width-cap_diameter/2-z_plastic_thickness,-1,idler_height-alu_profile_side/2])
            rotate([-90,0,0])
                cylinder(r=z_guide_aluminium_fastener/2,h=idler_depth,$fn=Q);

        translate([cap_diameter/2+z_plastic_thickness,idler_depth-alu_profile_side/2,-1])
                cylinder(r=cap_diameter/2,h=idler_height-alu_profile_side-z_plastic_thickness+1,$fn=Q);
        translate([idler_width-cap_diameter/2-z_plastic_thickness,idler_depth-alu_profile_side/2,-1])
                cylinder(r=cap_diameter/2,h=idler_height-alu_profile_side-z_plastic_thickness+1,$fn=Q);
                
        translate([cap_diameter/2+z_plastic_thickness,,idler_depth-alu_profile_side/2,-1])
                cylinder(r=z_guide_aluminium_fastener/2,h=idler_height,$fn=Q);
        translate([idler_width-cap_diameter/2-z_plastic_thickness,,idler_depth-alu_profile_side/2,-1])
                cylinder(r=z_guide_aluminium_fastener/2,h=idler_height,$fn=Q);
                
                
        translate([idler_width/2-(bw+tolerance*2)/2,z_plastic_thickness,-1])
            cube([bw+2*tolerance,2*bt+bo,z_plastic_thickness+bo+1]);
            
        translate([idler_width/2-(bw+tolerance*2)/2,z_plastic_thickness+(bo+2*bt)/2,z_plastic_thickness+bo])
            rotate([0,90,0])
                cylinder(r=(bo+2*bt)/2,h=bw+2*tolerance);

        translate([idler_width/2-(bolt_length)/2,z_plastic_thickness+(bo+2*bt)/2,z_plastic_thickness+bo])
            rotate([0,90,0])
                cylinder(r=bi/2,h=bolt_length);

        translate([-1,z_plastic_thickness+(bo+2*bt)/2,z_plastic_thickness+bo])
            rotate([0,90,0])
                cylinder(r=bi/2,h=idler_width/2);

//        translate([7,0,0]) cube([100,100,100]);
    }
    
    
}