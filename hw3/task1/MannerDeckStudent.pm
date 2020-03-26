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