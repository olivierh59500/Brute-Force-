#!/usr/bin/perl

# Coder: MMxM
# hc0der.blogspot.com
# Post facebook message with perl

use strict;
use LWP;
use HTTP::Cookies;
use URI::Escape;


fblogin();

sub fblogin {
#die("\n[+] $0 <fb-email> <fb-password>\n\n") if(@ARGV!=2);
#my($email,$pw) = @ARGV;
#print "[*] Logging... (Wait)\n";
my $email = "MyUserName";
my $pw = "MyPassword";
my $browser = LWP::UserAgent->new;
$browser->cookie_jar( {} );
$browser->agent('Mozilla/5.0 (Windows NT 6.2; rv:31.0) Gecko/20100101 Firefox/31.0');

my $body = $browser->get('https://m.facebook.com/')->content;

my %attr;
my @elements = ($body =~ /(?<=<input type="hidden" name=").*?(?<=" value=").*?(?=["])/g);
my $uri_login = "https://www.facebook.com/login.php?login_attempt=1&lwv=110";

foreach my $hidden(@elements){
    my @tmp = split(/" value="/,$hidden);
    $attr{$tmp[0]} = uri_escape($tmp[1]);
}

$attr{'email'} = $email;
$attr{'pass'} = $pw;

my $header = $browser->post( $uri_login ,  \%attr  )->as_string;
my $location;

if($header =~ /Location: (.*)/i){
    $location = $1;
} else {
    die("[-] Unexpected Error\n");
}

if($location =~ /^https:\/\/m.facebook.com\/login.php/){
    die("[-] Failed to login\n");
}

print "[+] Sucessfull Login\n";
print "[*] GETing URL to post message... (Wait)\n";

$browser->get($location);
$browser->get('https://m.facebook.com/phoneacqwrite/?s=1&source=m_mobile_mirror_interstitial');
$body = $browser->get('https://m.facebook.com/home.php?_rdr')->content;

my %attr2;
my @ele2 = ($body =~ /(?<=<input type="hidden" name=").*?(?<=" value=").*?(?=["])/g);

($body =~ /<form method="post" action="\/composer\/(.*?)">/)
&& ($location = 'https://m.facebook.com/composer/'.$1);
$location =~ s/&/&/g;

for(0..12){
    my @tmp = split (/" value="/ ,$ele2[$_]);
    next if($tmp[0] eq 'search' || $tmp[0] eq 'search_source');
    $attr2{$tmp[0]} = uri_escape($tmp[1]);
}

$attr2{'xc_message'} = '';
$attr2{'rst_icv'} = '';

$header = $browser->post($location, \%attr2)->as_string;

if($header =~ /Location:\s+?(.*)/ig){
    $location = $1;
}

($location !~ /$attr2{'csid'}/) && die("Unexpected Error\n");
print "[+] OK\n";
print "[*] Acessing url ...(Wait)\n";

$body = $browser->get($location)->content;
my %attr3;
my @h = ($body =~ /(?<=<input type="hidden" name=").*?(?<=" value=").*?(?=["])/g);
if($body =~ /<form method="post" action="\/composer\/mbasic\/(.*?)" enctype="multipart\/form-data">/){
    $location='https://m.facebook.com/composer/mbasic/'.$1;
}

for(0..scalar(@h)-1){
    my @tmp = split(/" value="/,$h[$_]);
    if($_ == 6){
        $attr3{'target'} = $tmp[1];
        next;
    }
    if($_ == 12){
        $attr3{'waterfall_source'} = $tmp[1];
        next;
    }
    $attr3{$tmp[0]} = $tmp[1];
}

my $xms = sprintf("%s", "WHERE'S NIGGAS TO KISS ON MOUTH ?! IM BOYOLA, IN BR : VIADÃO");

$attr3{'xc_message'} = $xms;
$attr3{'users_with'} = '';
$attr3{'album_id'} = '';
$attr3{'view_post'} = '';
$attr3{'file1'} = '';
$attr3{'file2'} = '';
$attr3{'file3'} = '';
my $x;
for (my $j = 1;$j < 100;$j++) {
$attr3{'xc_message'} = $xms."aaAaáAa" x $j;
$x = $browser->post($location, Content_Type => 'multipart/form-data',
        Content => [ %attr3 ]);

if($x->as_string =~ /Location:(\s+)?https:\/\/m.facebook.com\/home.php/){
    print "\n[+] Message posted successfully\n";
} else {
    print "\n[-] Possible error\n";
}

#__EOF__
}
}
