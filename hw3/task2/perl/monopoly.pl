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

sub terminationCheck {
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
        if ($cur_player->{money} < 200) {
            local $Player::due;
            $Player::due = $cur_player->{money};
            $cur_player->payDue();
        } else {
            $cur_player->payDue();
        }

        if ($cur_player->{num_rounds_in_jail} == 0) {
            # Player not in jail. Throw the dice.
            my $dice_step;
            print("Pay \$500 to throw two dice? [y/n]\n");

            my $choice = "n";
            if ($cur_player->{money} < 500) {
                print("You do not have enough money to throw two dice!\n");
            } else {
                $choice = <STDIN>;
                chomp($choice);
            }

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
            
            print("Points of dices: ".$dice_step."\n");

            # Move the player and show new gameboard.
            $cur_player->move($dice_step);
            printGameBoard();
            
            # Perform slot action.
            my $cur_slot = $game_board[$cur_player->{position}];
            $cur_slot->stepOn();
        } else {
            # In jail. Still moves to reduce prison term.
            $cur_player->move(0);
        }

        # Check if the game should end.
        if (terminationCheck()) {
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