include <configuration.scad>
include <inc/functions.scad>
include <MCAD/nuts_and_bolts.scad>


Q=25;
z_guide_frame_block();


module z_guide_frame_block(){
    
    tolerance                   =   0.1;
    z_block_wall                =   5; // mm
    cap_diameter                =   METRIC_NUT_AC_WIDTHS[z_guide_aluminium_fastener]+tolerance*2;
    cap_height                  =   METRIC_NUT_THICKNESS[z_guide_lid_fastener];
    d1                          =   2; // mm
    d2                          =   1; //mm
    nut_width                   =   METRIC_NUT_AC_WIDTHS[z_guide_lid_fastener]+tolerance*2;
    nut_height                  =   METRIC_NUT_THICKNESS[z_guide_lid_fastener]+tolerance*2;
    
    
    
    z_guide_block_length        =   2*(z_block_wall+cap_diameter+d1+
                                        z_guide_lid_fastener+2*tolerance+d2+z_guide_rod_diameter/2);
    z_guide_block_height        =   z_guide_rod_offset+z_guide_rod_diameter+2;
    z_guide_lid_length          =   z_guide_block_length-2*z_block_wall;
    z_guide_lid_height          =   z_guide_rod_diameter+2;

    
    difference(){
        intersection(){
            cube_fillet([z_guide_block_length,z_guide_block_height,alu_profile_side],radius=-1, vertical=[5,5,0,0], top=[3,3,0,3], bottom=[3,3,0,3], center=false, $fn=0);
            translate([(z_guide_block_length-z_guide_lid_length)/2,z_guide_block_height-z_guide_lid_height,-1])
                cube([z_guide_lid_length,z_guide_lid_height+1,alu_profile_side+2],center=false);
        }
        
        translate([z_guide_block_length/2,z_guide_block_height-z_guide_lid_height,-1])
            cylinder(r=z_guide_rod_diameter/2,h=alu_profile_side+2,$fn=Q);
        
        translate([cap_diameter+z_block_wall+d1+z_guide_lid_fastener/2,z_guide_block_height-cap_height+tolerance,alu_profile_side/2])
            rotate([90,0,0])
                boltHole(z_guide_lid_fastener, length=z_guide_lid_height+1,$fn=Q);
        translate([z_guide_block_length-(cap_diameter+z_block_wall+d1+z_guide_lid_fastener/2),z_guide_block_height-cap_height+tolerance,alu_profile_side/2])
            rotate([90,0,0])
                boltHole(z_guide_lid_fastener, length=z_guide_lid_height+1,$fn=Q);

    }
    
}