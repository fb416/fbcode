#samtools
#!/bin/bash
#torun
#chmod u+x gzipout.sh
#./gzipout.sh /home/fb416/projects/eyal/FB83/
BASEPATH=${1} 
for filepath in $BASEPATH/out/*.fq
do
	filename=$(basename $filepath .fq)
	qsub -o $BASEPATH/log/gzip_$filename.out -e $BASEPATH/log/gzip_$filename.err -N samtools_$filename -pe slots 8 -b y gzip -1 $filepath
done
