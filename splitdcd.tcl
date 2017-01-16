# cut dcd trajectory file in (nf/ia) snapshots
# prodall.dcd namd.psf files are needed
# it produces prod0.coor to prod[(nf/ia)-1].coor files

resetpsf
set psfname [lindex $argv 0]
set dcdname [lindex $argv 1]
puts "$psfname"
mol load psf $psfname dcd $dcdname 
set nf [molinfo top get numframes]
set ia 10 

#set i 0
#if {$i == 0 } {
#[atomselect top all frame $i ] writepdb $i.pdb
#}

for {set i 10 } {$i <= $nf} {incr i $ia} {
set ir [expr "$i - 1"]
set num [expr "$i / $ia"]
[atomselect top all frame $ir ] writepdb $num.pdb
}

quit

# type in a console: vmd -dispdev text -e splitdcd.tcl -args psfname dcdname > splitdcd.out
