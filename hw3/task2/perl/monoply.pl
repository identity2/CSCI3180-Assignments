#! /usr/bin/perl
use warnings;
use strict;
require "./Bank.pm";
require "./Jail.pm";
require "./Land.pm";
require "./Player.pm";

our @game_board = (
    new Bank(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
    new Jail(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
);
our $game_board_size = @game_board;

our @players = (new Player("A"), new Player("B"));
our $num_players = @players;

our $cur_player_idx = 0;
our $cur_player = $players[$cur_player_idx];
our $cur_round = 0;
our $max_rounds = 100;
our $num_dices = 1;

srand(0); # don't touch

# game board printing utility. Used to show player position.
sub printCellPrefix {
    my $position = shift;
    my @occupying = ();
    foreach my $player (@players) {
        if ($player->{position} == $position && $player->{money} > 0) {
            push(@occupying, ($player->{name}));
        }
    }
    print(" " x ($num_players - scalar @occupying), @occupying);
    if (scalar @occupying) {
        print("|");
    } else {
        print(" ");
    }
}

sub printGameBoard {
    print("-"x (10 * ($num_players + 6)), "\n");
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix($i);
        $game_board[$i]->print();
    }
    print("\n\n");
    for (my $i = 0; $i < 8; $i += 1) {
        printCellPrefix($game_board_size - $i - 1);
        $game_board[-$i-1]->print();
        print(" "x (8 * ($num_players + 6)));
        printCellPrefix($i + 10);
        $game_board[$i+10]->print();
        print("\n\n");
    }
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix(27 - $i);
        $game_board[27-$i]->print();
    }
    print("\n");
    print("-"x (10 * ($num_players + 6)), "\n");
}

sub termination_check {
    if ($cur_player->{money} <= 0) {
        return 1;
    }
    return 0;
}

sub throwDice {
    my $step = 0;
    for (my $i = 0; $i < $num_dices; $i += 1) {
        $step += 1 + int(rand(6));
    }
    return $step;
}

sub main {
    my $game_ended = 0;
    while ($game_ended != 1){
        printGameBoard();
        foreach my $player (@players) {
            $player->printAsset();
        }
        
        print("Player ".$cur_player->{name}."'s term.\n");
        
        # Pay the $200 fixed fee.
        $cur_player->payDue();

        # Player not in jail.
        my $dice_step;
        if ($cur_player->{num_rounds_in_jail} == 0) {
            # Throw the dice.
            print("Pay \$500 to throw two dice? [y/n]\n");
            my $choice = <STDIN>;
            
            chomp($choice);
            if ($choice eq "y") {
                local $num_dices = 2;      # dynamic scoping.
                $dice_step = throwDice();

                local $Player::due;        # dynamic scoping
                local $Player::handling_fee_rate; # dynamic scoping
                $Player::due = 500;   
                $Player::handling_fee_rate = 0.05;
                $cur_player->payDue();
            } else {
                $dice_step = throwDice();
            }
            
            print("Points of dices: ".$dice_step."\n")
        }

        # Move the player and show new gameboard.
        $cur_player->move($dice_step);
        printGameBoard();
        
        # Perform slot action.
        my $cur_slot = $game_board[$cur_player->{position}];
        $cur_slot->stepOn();

        # Check if the game should end.
        if (termination_check()) {
            $game_ended = 1;
        }

        # Switch to the next player.
        $cur_player_idx = ($cur_player_idx + 1) % $num_players;
        $cur_player = $players[$cur_player_idx];
    }

    # Game over message.
    print("Game over! winner: ".$cur_player->{name}.".\n");
}

main();