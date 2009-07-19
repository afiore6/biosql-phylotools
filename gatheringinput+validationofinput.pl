#!/usr/bin/perl

use strict;
use warnings;
use Bio::Phylo::IO 'parse';

my ( $taxa, $matrix, $forest );

my $file = shift @ARGV;
my $blocks = parse(
   '-format' => 'nexus',
   '-file'       => $file,
);


for my $block ( @{ $blocks } ) {
        $taxa = $block if $block->isa('Bio::Phylo::Taxa');
        $matrix = $block if $block->isa('Bio::Phylo::Matrices::Matrix');
        $forest = $block if $block->isa('Bio::Phylo::Forest');
}

# Examine each tree in the forest
foreach my $tree ( @{ $forest->get_entities } ) {
   validate($tree);
}


exit;



sub validate{
  my $tree = shift;
  my $root;
  if (!$tree->is_rooted ) {
    print "tree not rooted\n";
    $tree->set_attributes('is_rooted','f');
  }
  else{
    $tree->set_attributes('is_rooted','t');
    $tree->set_attributes('node_id',$tree->get_root->get_internal_name);
  }
  foreach (keys(%{$tree->get_attributes()})){
    print ${$tree->get_attributes()}{$_};
    print " ";
    print $_;
    print "\n";
  }
  return $tree
}