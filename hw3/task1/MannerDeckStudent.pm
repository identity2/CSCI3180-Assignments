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

package MannerDeckStudent;
use parent("Deck");

sub shuffle {
	my $self = shift @_;
	my $card = $self->{"cards"};
	for my $i (1..$#$card) {
		my $j = $i/2;
		@$card[$j, $i] = @$card[$i, $j];
	}
}


return 1;