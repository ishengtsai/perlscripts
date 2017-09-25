#!/usr/bin/perl -w
use strict;




my $largest = 0;
my $contig = '';




if (@ARGV != 1) {
    print "$0 fastq.gz|fastq \n" ; 
    exit ;
}

my $filenameA = $ARGV[0];





if ( $filenameA=~ /.gz$/ ) {
    open (IN, "zcat $filenameA |") or die "oops!\n" ;
}
else {
    open (IN, "$filenameA") or die "oops!\n" ;
}


while (<IN>) {

    my $name = $_ ;

    $name =~ s/^\@/\>/ ;

    if ( $name =~ /^(\S+)/ ) {
	$name = $1 ; 
    }
    
    my $seq = <IN> ;
    my $tmp = <IN> ;
    my $qual = <IN> ;

    print "$name\n$seq" ; 

}

close(IN) ; 
