#puts "your selection $sele"
mol new {$fn.psf} type psf
mol addfile ./$fn.pdb waitfor all
set id [molinfo top get id]
puts "first file got id = $id"
mol new {$fn.psf} type psf
mol addfile ./$fn_opt.pdb waitfor all
set id [molinfo top get id]
puts "second file got id = $id"

# compute the transformation matrix for the allignment
set reference [atomselect 0 "$allign_sel" ]
set compare [atomselect 1 "$allign_sel"]
set trans_mat [measure fit $compare $reference]

# apply the trans_mat to all of the molecule 1
set move_sel [atomselect 1 "all"]
$move_sel move $trans_mat

# set the selection for rmsd after the allignment
set rmsd1 [atomselect 0 "$rmsd_sel"]
set rmsd2 [atomselect 1 "$rmsd_sel"]
set rmsd [measure rmsd $rmsd2 $rmsd1]

# print the result 
puts "the rmsd value = $rmsd"

quit
