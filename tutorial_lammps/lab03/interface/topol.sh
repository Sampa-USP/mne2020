#!/bin/bash
# input paramters
xyzfile="water_heptane.xyz"          # <- arquivo da posições da interface
files=("water.top" "heptane.top")    # <- nomes dos arquivos topologicos das moléculas serem usados
types=${#files[@]}
molecules=("619" "76")            # <- número de moléculas, compativel com arquivo xyzfile 
lammpsfile="water_heptane.top"       # <- arquivo de saida lammps
inputfile="input.dat"            
coeffsfile="interface_coeffs.dat"   # <- coeficentes do campo de força a serem usados
# box dimensions
xlo="0.00"                     
xhi="21.00"
ylo="0.00"
yhi="21.00"
zlo="0.00"
zhi="84.00"

# creating lammps topolfile

echo "xyzfile $xyzfile" > $inputfile
echo "xlo xhi $xlo $xhi" >> $inputfile
echo "ylo yhi $ylo $yhi" >> $inputfile
echo "zlo zhi $zlo $zhi" >> $inputfile
echo "molecules types $types" >> $inputfile
for (( i=0;i<$types;i++)); do

let j=$i+1

echo "file$j ${files[$i]}" >> $inputfile
echo "molecules ${molecules[$i]}" >> $inputfile
atoms=`grep "atoms" ${files[$i]} | awk '{print $1}'`

echo "atoms $atoms" >> $inputfile

string=`grep "bonds" ${files[$i]}`

if [ -n "$string" ];
then
bonds=`grep "bonds" ${files[$i]} | awk '{print $1}'`
echo "bonds $bonds" >> $inputfile
else
echo "bonds 0" >> $inputfile
fi

string=`grep "angles" ${files[$i]}`

if [ -n "$string" ];
then
angles=`grep "angles" ${files[$i]} | awk '{print $1}'`
echo "angles $angles" >> $inputfile
else
echo "angles 0" >> $inputfile
fi

string=`grep "dihedrals" ${files[$i]}`

if [ -n "$string" ];
then
dihedrals=`grep "dihedrals" ${files[$i]} | awk '{print $1}'`
echo "dihedrals $dihedrals" >> $inputfile
else
echo "dihedrals 0" >> $inputfile
fi

string=`grep "impropers" ${files[$i]}`

if [ -n "$string" ];
then
impropers=`grep "impropers" ${files[$i]} | awk '{print $1}'`
echo "impropers $impropers" >> $inputfile
else
echo "impropers 0" >> $inputfile
fi

string=`grep "atom types" ${files[$i]}`

if [ -n "$string" ];
then
atoms=`grep "atom types" ${files[$i]} | awk '{print $1}'`
echo "atom types $atoms" >> $inputfile
else
echo "atom types 0" >> $inputfile
fi

string=`grep "bond types" ${files[$i]}`

if [ -n "$string" ];
then
bonds=`grep "bond types" ${files[$i]} | awk '{print $1}'`
echo "bond types $bonds" >> $inputfile
else
echo "bond types 0" >> $inputfile
fi

string=`grep "angle types" ${files[$i]}`

if [ -n "$string" ];
then
angles=`grep "angle types" ${files[$i]} | awk '{print $1}'`
echo "angle types $angles" >> $inputfile
else
echo "angle types 0" >> $inputfile
fi

string=`grep "dihedral types" ${files[$i]}`

if [ -n "$string" ];
then
dihedrals=`grep "dihedral types" ${files[$i]} | awk '{print $1}'`
echo "dihedral types $dihedrals" >> $inputfile
else
echo "dihedral types 0" >> $inputfile
fi

string=`grep "improper types" ${files[$i]}`

if [ -n "$string" ];
then
impropers=`grep "improper types" ${files[$i]} | awk '{print $1}'`
echo "improper types $impropers" >> $inputfile
else
echo "improper types 0" >> $inputfile
fi


line=`grep "Atoms" ${files[$i]}  -n | sed 's/://g' | awk '{print $1}'`

echo "line1 $line" >> $inputfile

string=`grep "Bonds" ${files[$i]}`

if [ -n "$string" ];
then
line=`grep "Bonds" ${files[$i]} -n | sed 's/://g' | awk '{print $1}'`
echo "line2 $line" >> $inputfile
else
echo "line2 0" >> $inputfile
fi

string=`grep "Angles" ${files[$i]}`

if [ -n "$string" ];
then
line=`grep "Angles" ${files[$i]} -n | sed 's/://g' | awk '{print $1}'`
echo "line3 $line" >> $inputfile
else
echo "line3 0" >> $inputfile
fi

string=`grep "Dihedrals" ${files[$i]}`

if [ -n "$string" ];
then
line=`grep "Dihedrals" ${files[$i]} -n | sed 's/://g' | awk '{print $1}'`
echo "line4 $line" >> $inputfile
else
echo "line4 0" >> $inputfile
fi

string=`grep "Impropers" ${files[$i]}`

if [ -n "$string" ];
then
line=`grep "Impropers" ${files[$i]} -n | sed 's/://g' | awk '{print $1}'`
echo "line5 $line" >> $inputfile
else
echo "line5 0" >> $inputfile
fi

done

./topol.x > lmps.dat

cat information.dat > $lammpsfile
cat $coeffsfile >> $lammpsfile
cat lmps.dat >> $lammpsfile

echo "create topological lammps file"

rm lmps.dat
