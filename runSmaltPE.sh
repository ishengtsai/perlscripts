#!/bin/bash

if [ $# -eq 0 ]
then
    echo "runPE.sh outPrefix forward reverse  refFile numCPU "
    exit 1
fi


SAMPLE=$1
FORWARD=$2
REVERSE=$3
REF=$4
CPU=$5



smalt index -k 20 -s 13 $REF $REF
smalt map -i 10000 -n $CPU -x -f samsoft -o $SAMPLE.sam $REF $FORWARD $REVERSE
samtools sort -@ $CPU -O bam -o $SAMPLE.sorted.bam $SAMPLE.sam

#java -Xmx6g -jar /usr/local/bioinfo/picard-tools-1.130/picard.jar MarkDuplicates METRICS_FILE=metrics CREATE_INDEX=true INPUT=$SAMPLE.sorted.bam OUTPUT=$SAMPLE.sorted.markdup.bam
java -Xmx6g -jar /home/ijt/bin/picard.jar MarkDuplicates METRICS_FILE=metrics CREATE_INDEX=true INPUT=$SAMPLE.sorted.bam OUTPUT=$SAMPLE.sorted.markdup.bam
bamtools stats -in $SAMPLE.sorted.markdup.bam -insert > $SAMPLE.sorted.markdup.bam.stats
