#smallrnaseq
#!/bin/bash
#torun
#chmod u+x smallrnaseq.sh
#./smallrnaseq.sh /home/fb416/projects/fabian/FB37/
BASEPATH=${1} 
for filepath in $BASEPATH/seq/*.fastq
do
	filename=$(basename $filepath .fastq)
	qsub -o $BASEPATH/log/fastqc_$filename.out -e $BASEPATH/log/fastqc_$filename.err -N fastqc_$filename -pe slots 1 -b y /home/fb416/projects/res/FastQC/fastqc $filepath -o $BASEPATH/out/	
	qsub -o $BASEPATH/log/wormgfpCDS$filename.out -e $BASEPATH/log/wormgfpCDS$filename.err -N wormgfpCDS$filename -pe slots 8 -b y /home/fb416/projects/res/bowtie -a -p 8 -v 0 -t --fullref --sam /home/fb416/projects/res/genomes/wormgfpCDS $BASEPATH/seq/$filename.fastq $BASEPATH/out/$filename.wormgfpCDS.sam --al $BASEPATH/out/$filename.wormgfpCDS.fq --un $BASEPATH/out/$filename.nowormgfpCDS.fq
done
