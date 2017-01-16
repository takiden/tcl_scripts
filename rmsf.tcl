# this script is used to:
# 1. load the trajectory
# 2. evaluate the aver RMSD over time of pyrol-water 
# use: vmd -dispdev text -e rmsd_h2o.tcl -args "name of the directory"
mol load psf namd.psf
mol addfile reference_file 
mol addfile pdb_file
#set num [expr [molinfo top get numframes]-2]
#puts "num = $num"
#quit
proc rmsf {} {

#serials of atoms
#set rf 289
#set rl 336

set firstres num1
set lastres num2
set outfile2 [open "test.dat" w]
for {set i $firstres} {$i<=$lastres} {incr i} {
	
set sel [atomselect top "resid $i and name CA"]

#rmsf
set rmsf [measure rmsf $sel first 0 last 1]
puts $outfile2 "$i $rmsf"

}
close $outfile2

}
rmsf

quit
