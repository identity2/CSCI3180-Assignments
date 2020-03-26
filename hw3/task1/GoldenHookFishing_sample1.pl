use strict;
use warnings;

package GoldenHookFishing;
use Game;

my $game = Game->new();
if ($game->set_players(['lin', 'liz'])) {
	$game->start_game();
}
