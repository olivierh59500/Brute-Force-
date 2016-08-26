#!/usr/bin/env/perl

use strict;
use warnings;
use Cwd;
my ($d1, $d2, $string) = "";
my $first = 0;
carregar();
principal();
#carregar2();
#principal2();
system("pause");

sub carregar {
print "../Dictionary/? : ";
chomp (my $wordroot = <STDIN>);
my $a = "perl fbrute.pl ";
my $b = "../Dictionary/$wordroot";
my $c = "";#"\nTIMEOUT /T 300";
my $d = "";#"ipconfig/flushdns";
my $e = "";#"ipconfig/release";
my $f = "";#"ipconfig/renew";
my $g = "";#"ipconfig/registerdns";
my $h = "---------------------\n";
$d1 = getcwd;
chdir $b;
foreach (<*>) {
			if ($_ =~ /((.*)\.txt)/ig) { 
				$string = "\@echo off\nD:\nset mypath=%cd%\n" if ($first eq 0);
				$string = "---------------------\n" if ($first eq 0);
				$string = "\n" if ($first eq 0);
				$string .= $a.$b.$1;
				$string .= "$c\n$d\n$e\n$f\n$g\n$h";
			}
			$first = 1;
	}
}

sub principal {
$d2 = getcwd;
chdir $d1;
open F, ">fbrute_run.bat";
print F $string;
close (F);
}

=cut
sub carregar2 {
undef $string;
my $a = "\@echo off
D:
set mypath=%cd%
perl fbrute.pl ";
my $b = "Dictionary/pt2/partioners/";
my $c = "\nTIMEOUT /T 300";
my $d = "ipconfig/flushdns";
my $e = "ipconfig/release";
my $f = "ipconfig/renew";
my $g = "ipconfig/registerdns";
$d1 = getcwd;
chdir $b;
foreach (<*>) {
			if ($_ =~ /((.*)\.txt)/ig) { 
				$string .= $a.$b.$1;
				$string .= "$c\n$d\n$e\n$f\n$g";
			}
	}
}



sub principal2 {
$d2 = getcwd;
chdir $d1;
open F, ">pt2.bat";
print F $string;
close (F);
}
=cut
