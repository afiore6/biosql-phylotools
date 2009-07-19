#!/bin/perl

use warnings;
use strict;
use Getopt::Long;
use Bio::TreeIO;
use Bio::Phylo;
use Bio::Phylo::IO 'parse';

my $treeformat;
my $ok = GetOptions ('treeformat=tf'	=> \$treeformat,
);

unless ( $ok ){ die "need treeformat option -tf";
}
my ( $taxa, $matrix, $forest );
 
my $file = shift @ARGV;
my $blocks = parse(
   '-format'	 => $treeformat,
   '-file'       => $file,
);

#need validation of input treefile (missing)
