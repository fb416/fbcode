#samtools
#!/bin/bash
#torun
#chmod u+x samtools.sh
#./samtools.sh /home/fb416/projects/fabian/FB37/
BASEPATH=${1} 
for filepath in $BASEPATH/out/*.sam
do
	filename=$(basename $filepath .sam)
	qsub -o $BASEPATH/log/samtools_$filename.out -e $BASEPATH/log/samtools_$filename.err -N samtools_$filename -pe slots 8 -b y /home/fb416/projects/res/samtools view -bS $BASEPATH/out/$filename.sam -o $BASEPATH/out/$filename.bam
done
