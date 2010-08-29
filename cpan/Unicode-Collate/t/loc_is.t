#!perl
use strict;
use warnings;
use Unicode::Collate::Locale;

use Test;
plan tests => 94;

my $eth  = pack 'U', 0xF0;
my $ETH  = pack 'U', 0xD0;
my $thrn = pack 'U', 0xFE;
my $THRN = pack 'U', 0xDE;
my $ae   = pack 'U', 0xE6;
my $AE   = pack 'U', 0xC6;
my $auml = pack 'U', 0xE4;
my $Auml = pack 'U', 0xC4;
my $ouml = pack 'U', 0xF6;
my $Ouml = pack 'U', 0xD6;
my $ostk = pack 'U', 0xF8;
my $Ostk = pack 'U', 0xD8;
my $arng = pack 'U', 0xE5;
my $Arng = pack 'U', 0xC5;

my $objIs = Unicode::Collate::Locale->
    new(locale => 'IS', normalization => undef);

ok(1);
ok($objIs->getlocale, 'is');

$objIs->change(level => 1);

ok($objIs->lt('a', "a\x{301}"));
ok($objIs->gt('b', "a\x{301}"));
ok($objIs->lt('d', $eth));
ok($objIs->gt('e', $eth));
ok($objIs->lt('e', "e\x{301}"));
ok($objIs->gt('f', "e\x{301}"));
ok($objIs->lt('i', "i\x{301}"));
ok($objIs->gt('j', "i\x{301}"));
ok($objIs->lt('o', "o\x{301}"));
ok($objIs->gt('p', "o\x{301}"));
ok($objIs->lt('u', "u\x{301}"));
ok($objIs->gt('v', "u\x{301}"));
ok($objIs->lt('y', "y\x{301}"));
ok($objIs->gt('z', "y\x{301}"));

# 16

ok($objIs->lt('z', $thrn));
ok($objIs->lt($thrn, $ae));
ok($objIs->lt($ae, $ouml));
ok($objIs->lt($ouml, $arng));
ok($objIs->lt($arng, "\x{1C0}"));

# 21

ok($objIs->eq('d', "d\x{335}"));
ok($objIs->eq($ae, $auml));
ok($objIs->eq($ouml, $ostk));

$objIs->change(level => 2);

ok($objIs->lt('d', "d\x{335}"));
ok($objIs->lt($ae, $auml));
ok($objIs->lt($ouml, $ostk));

# 27

ok($objIs->eq("a\x{301}", "A\x{301}"));
ok($objIs->eq("d\x{335}", "D\x{335}"));
ok($objIs->eq($eth, $ETH));
ok($objIs->eq("e\x{301}", "E\x{301}"));
ok($objIs->eq("i\x{301}", "I\x{301}"));
ok($objIs->eq("o\x{301}", "O\x{301}"));
ok($objIs->eq("u\x{301}", "U\x{301}"));
ok($objIs->eq("y\x{301}", "Y\x{301}"));
ok($objIs->eq($thrn, $THRN));
ok($objIs->eq($ae,   $AE));
ok($objIs->eq($AE, "\x{1D2D}"));
ok($objIs->eq($auml, $Auml));
ok($objIs->eq($ouml, $Ouml));
ok($objIs->eq($ostk, $Ostk));
ok($objIs->eq($arng, $Arng));

# 42

$objIs->change(level => 3);

ok($objIs->lt("a\x{301}", "A\x{301}"));
ok($objIs->lt("d\x{335}", "D\x{335}"));
ok($objIs->lt($eth, $ETH));
ok($objIs->lt("e\x{301}", "E\x{301}"));
ok($objIs->lt("i\x{301}", "I\x{301}"));
ok($objIs->lt("o\x{301}", "O\x{301}"));
ok($objIs->lt("u\x{301}", "U\x{301}"));
ok($objIs->lt("y\x{301}", "Y\x{301}"));
ok($objIs->lt($thrn, $THRN));
ok($objIs->lt($ae,   $AE));
ok($objIs->lt($AE, "\x{1D2D}"));
ok($objIs->lt($auml, $Auml));
ok($objIs->lt($ouml, $Ouml));
ok($objIs->lt($ostk, $Ostk));
ok($objIs->lt($arng, $Arng));

# 57

ok($objIs->eq("a\x{301}", pack('U', 0xE1)));
ok($objIs->eq("A\x{301}", pack('U', 0xC1)));
ok($objIs->eq("d\x{335}", "\x{111}"));
ok($objIs->eq("D\x{335}", "\x{110}"));
ok($objIs->eq("e\x{301}", pack('U', 0xE9)));
ok($objIs->eq("E\x{301}", pack('U', 0xC9)));
ok($objIs->eq("i\x{301}", pack('U', 0xED)));
ok($objIs->eq("I\x{301}", pack('U', 0xCD)));
ok($objIs->eq("o\x{301}", pack('U', 0xF3)));
ok($objIs->eq("O\x{301}", pack('U', 0xD3)));
ok($objIs->eq("u\x{301}", pack('U', 0xFA)));
ok($objIs->eq("U\x{301}", pack('U', 0xDA)));
ok($objIs->eq("y\x{301}", pack('U', 0xFD)));
ok($objIs->eq("Y\x{301}", pack('U', 0xDD)));

# 71

ok($objIs->eq("\x{1FD}", "$ae\x{301}"));
ok($objIs->eq("\x{1FC}", "$AE\x{301}"));
ok($objIs->eq("\x{1E3}", "$ae\x{304}"));
ok($objIs->eq("\x{1E2}", "$AE\x{304}"));
ok($objIs->eq("a\x{308}", $auml));
ok($objIs->eq("A\x{308}", $Auml));
ok($objIs->eq("o\x{308}", $ouml));
ok($objIs->eq("O\x{308}", $Ouml));
ok($objIs->eq("o\x{338}", $ostk));
ok($objIs->eq("O\x{338}", $Ostk));
ok($objIs->eq("o\x{338}\x{301}", "\x{1FF}"));
ok($objIs->eq("O\x{338}\x{301}", "\x{1FE}"));
ok($objIs->eq("a\x{30A}", $arng));
ok($objIs->eq("A\x{30A}", $Arng));
ok($objIs->eq("A\x{30A}", "\x{212B}"));
ok($objIs->eq("a\x{30A}\x{301}", "\x{1FB}"));
ok($objIs->eq("A\x{30A}\x{301}", "\x{1FA}"));

# 88

$objIs->change(upper_before_lower => 1);

ok($objIs->gt($ae,   $AE));
ok($objIs->lt($AE, "\x{1D2D}"));
ok($objIs->gt($auml, $Auml));
ok($objIs->gt($ouml, $Ouml));
ok($objIs->gt($ostk, $Ostk));
ok($objIs->gt($arng, $Arng));

# 94
