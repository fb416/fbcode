#dicerproducts
#!/bin/bash
#torun
#chmod u+x dicerproducts.sh
#./dicerproducts.sh /home/fb416/projects/fabian/FB37/
BASEPATH=${1} 
for filepath in $BASEPATH/out/*.sam
do
	filename=$(basename $filepath .sam)
	qsub -o $BASEPATH/log/bam_$filename.out -e $BASEPATH/log/sort_$filename.err -N bam_$filename -pe slots 8 -b y /home/fb416/projects/res/samtools view -bS $BASEPATH/out/$filename.sam -o $BASEPATH/out/$filename.bam
	qsub -hold_jid bam_$filename -o $BASEPATH/log/sort_$filename.out -e $BASEPATH/log/sort_$filename.err -N sort_$filename -pe slots 8 -b y /home/fb416/projects/res/samtools sort -T $BASEPATH/out/$filename.sorted -o $BASEPATH/out/$filename.sort.bam $BASEPATH/out/$filename.bam
	qsub -hold_jid sort_$filename -o $BASEPATH/log/index_$filename.out -e $BASEPATH/log/index_$filename.err -N index_$filename -pe slots 8 -b y /home/fb416/projects/res/samtools index $BASEPATH/out/$filename.sort.bam
	qsub -hold_jid index_$filename -o $BASEPATH/log/dicer_$filename.out -e $BASEPATH/log/dicer_$filename.err -N dicer_$filename -pe slots 8 -b y -V python /home/fb416/projects/res/tstk/get_overlapping_reads.py --length 22 --5p 2 --3p 2 $BASEPATH/out/$filename.sort.bam $BASEPATH/out/$filename.dicer.bam
done
