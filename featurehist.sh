#featurehist
#!/bin/bash
#torun
#chmod u+x featurehist.sh
#./featurehist.sh /home/fb416/projects/fabian/FB37/ /home/fb416/projects/res/genomes/wormgfpCDS.gbk
BASEPATH=${1}
FEATUREFILE=${2} #should be genebank
for filepath in $BASEPATH/out/*sort.bam
do
	filename=$(basename $filepath .bam)
	qsub -o $BASEPATH/log/featurehist_$filename.out -e $BASEPATH/log/featurehist_$filename.err -N featurehist_$filename -pe slots 1 -b y -V python /home/fb416/projects/res/tstk/featurehist.py --normnreads --stranded $BASEPATH/out/$filename.bam $FEATUREFILE  $BASEPATH/out/
done

