#smallrnaseq
#!/bin/bash
#torun
#chmod u+x fastqc.sh
#./fastqc.sh /home/fb416/projects/eyal/FB83/
BASEPATH=${1} 
for filepath in $BASEPATH/out/*.fq
do
	filename=$(basename $filepath .fq)
	qsub -o $BASEPATH/log/fastqc_$filename.out -e $BASEPATH/log/fastqc_$filename.err -N fastqc_$filename -pe slots 1 -b y /home/fb416/projects/res/FastQC/fastqc $filepath -o $BASEPATH/out/
done