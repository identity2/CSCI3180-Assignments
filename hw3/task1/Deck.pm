# CSCI3180 Principles of Programming Languages
#
# --- Declaration ---
#
# I declare that the assignment here submitted is original except for source
# material explicitly acknowledged. I also acknowledge that I am aware of
# University policy and regulations on honesty in academic work, and of the
# disciplinary guidelines and procedures applicable to breaches of such policy
# and regulations, as contained in the website
# http://www.cuhk.edu.hk/policy/academichonesty/
#
# Assignment 3
# Name : Chao Yu
# Student ID : 1155053722
# Email Addr : ychao5@cse.cuhk.edu.hk

use strict;
use warnings;

package Deck;
sub new {
	my $class = shift @_;
	my @cards = ("3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A", "2");
	@cards = (@cards, @cards, @cards, @cards);
	my $object = bless {"cards"=>\@cards}, $class;
	return $object;
}
sub shuffle {
	my $self = shift @_;
	my $card = $self->{"cards"};
	for my $i (1..$#$card) {
		my $j = int rand($i+1);
		@$card[$j, $i] = @$card[$i, $j];
	}
}
sub AveDealCards {
	my $self = shift @_;
	my $num = shift @_;
	my @cards = @{$self->{"cards"}};
	my $cards_num = @cards;
	$cards_num /= $num;
	my @ret = ();
	for my $n (1..$num) {
		my @cur = @cards[($n-1) * $cards_num .. $n * $cards_num-1];
		push @ret, \@cur;
	}
	return @ret;
}


return 1;