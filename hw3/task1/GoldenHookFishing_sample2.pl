use strict;
use warnings;

package GoldenHookFishing;
use Game;

my $game = Game->new();
if ($game->set_players(['lin', 'liz', 'wu'])) {
	$game->start_game();
}
