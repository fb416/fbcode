#peterplot
#!/bin/bash
#torun
#chmod u+x peterplot.sh
#./peterplot.sh /home/fb416/projects/fabian/FB37/
BASEPATH=${1} 
for filepath in $BASEPATH/out/*.sort.bam
do
	filename=$(basename $filepath .bam)
	qsub -o $BASEPATH/log/peterplot_$filename.out -e $BASEPATH/log/peterplot_$filename.err -N peterplot_$filename -pe slots 1 -b y -V python /home/fb416/projects/res/tstk/peterplot.py --ylims="-.65,.65" --stranded --normnreads --minlength 20 --maxlength 30 --title $filename $BASEPATH/out/$filename.bam $BASEPATH/out/$filename.bam.svg
	done
