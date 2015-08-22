#samtools
#!/bin/bash
#torun
#chmod u+x gzip.sh
#./gzip.sh /home/fb416/projects/omer/
BASEPATH=${1} 
for filepath in $BASEPATH/seq/*.fq
do
	filename=$(basename $filepath .fq)
	qsub -o $BASEPATH/log/gzip_$filename.out -e $BASEPATH/log/gzip_$filename.err -N samtools_$filename -pe slots 8 -b y gzip -1 $filepath
done
