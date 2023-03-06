#!/usr/bin/perl -w
use strict;




my $largest = 0;
my $contig = '';




if (@ARGV != 2) {
    print "$0 fasta CLASS \n" ;
	exit ;
}

my $filenameA = $ARGV[0];
my $class = $ARGV[1] ; 


open OUT, ">", "$filenameA.$class.fa" ;

print "$filenameA.$class.fa produced!\n" ; 

open (IN, "$filenameA") or die "oops!\n" ;

my $count = 1 ; 

	while (<IN>) {

	    if ( /\0/ ) {
                print "escape char found!\n" ;
            }

            s/\0//gi ;




	    if (/^>(\S+)/) {
		my $seqname = $1 ; 



		$seqname =~ s/\|/./gi ; 
		$seqname =~ s/\#/./gi ; 
                $seqname =~ s/\=/./gi ;
                $seqname =~ s/\;/./gi ;
                $seqname =~ s/\:/./gi ;		
		$seqname =~ s/\,/./gi ;
		

		
		#print "" . length($seqname) . "\n" ; 

		if ( length($seqname) > 40 ) {
		    print "$seqname ----> seq.$count.changed\n" ; 
		    $seqname = "seq.$count.changed\#$class" ; 
		    $count++ ; 
		}

		    print OUT ">$seqname\#$class\n" ;
	    }
	    else {
		chomp; 
		if ( $_ eq '' ) {
		
		}
		else {
		    print OUT "$_\n" ;
		}
	    }

	}

close(IN) ;




