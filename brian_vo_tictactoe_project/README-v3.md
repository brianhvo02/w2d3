# Tic-Tac-Toe, Version 3: Rise Of The Machines

Make a copy of your entire __tic_tac_toe_v2__ directory and rename it
__tic_tac_toe_v3__. Open Version 3 in your editor and terminal so you can
update it to support more features. This will be your new working directory.

Your goal for this version is to implement a simple `ComputerPlayer` class that
will play randomly. You will also add some improved error handling for your
existing `HumanPlayer`s.

Let's begin by adding a new file in your working directory to house
`ComputerPlayer`:

```plaintext
tic_tac_toe_v3/
  ├── computer_player.rb
  ├── human_player.rb
  ├── board.rb
  └── game.rb
```

## Updating for random positions

Your `ComputerPlayer` artificial intelligence will be naive. When it is their
turn, a computer will play a random position on the board. However, you'll want
to ensure that the computers will choose a position that is legal according to
`Board#empty?` and `Board#valid?`. To implement this, you **could** just
continually "guess and check" random positions until you stumble upon a legal
position , but this is a rather wasteful strategy. Instead, it would be much
wiser to provide a list of legal positions to the `ComputerPlayer` from
which they may randomly select.

Here is where you must make a design decision founded on Object-Oriented
principles. You should try your best to keep all board and position related
logic inside of `Board`. Although your new major feature is `ComputerPlayer`, it
is apparent that the `Board` class also needs to provide additional information
for a `ComputerPlayer` to consume.

### Board#legal_positions

This method should return an array containing all positions of the board that
are legal to place a new mark on. That is, the returned positions should be
"in-bounds" on the grid and have no mark.

### ComputerPlayer#initialize

An instance of `ComputerPlayer` should have the same interface as a
`HumanPlayer`. This means that both classes should have the same method names,
but may implement these methods using different logic. Having a consistent
interface for all types of players will allow us to use computers and humans
interchangeably in a game with no annoying side-effects. The `#initialize` for a
computer should be identical to that of a human.

The programming paradigm you leverage here is known as [duck
typing][duck-typing]. If an object walks like a duck and quacks like a duck,
then you can use it as a duck for all intents and purposes. In your game, you
have duck typed `HumanPlayer` and `ComputerPlayer`.

### ComputerPlayer#get_position(legal_positions)

Assume that this method takes in an array of positions as an argument. The
method should return a random position from the array. To make gameplay clear,
print a message saying the computer's mark along with the position they chose.

Unlike your new `ComputerPlayer#get_position`, your old
`HumanPlayer#get_position` did not accept any argument. This discrepancy in
interface will cause issues. You'll reconcile this difference next.

### HumanPlayer#get_position(legal_positions)

Change this method to accept an array of positions as an argument. If the user
enters a position that is not inside of the array argument, tell them that their
choice was illegal and prompt them to enter another. This method should continue
to prompt the user until they make a legal choice.

#### Checkpoint: Turing's test†

†[The Turing test][turing-test]

Before you go any further, let's take a moment to verify the behavior of all of
the methods you just created or updated. Test them in isolation of one
another before connecting them together.

Here's a sample pry workflow you could use to test your board:

```plaintext
[1] pry(main)> load 'board.rb'
=> true

[2] pry(main)> my_board = Board.new(2)
=> #<Board:0x @grid=[["_", "_"], ["_", "_"]]>

[3] pry(main)> my_board.legal_positions
=> [[0, 0], [0, 1], [1, 0], [1, 1]]

[4] pry(main)> my_board.place_mark([0, 1], :Z)
=> :Z

[5] my_board.legal_positions
=> [[0, 0], [1, 0], [1, 1]]
```

Let's also test your humans. Since `#getPositions` simply expects an array as its
argument, you can pass in some "mock" data that doesn't really come from any
board. Don't forget that **abstraction** is a pillar of Object-Oriented
Programming. `#getPositions` just cares about being given an array; it
doesn't care where that array comes from:

```plaintext
[1] pry(main)> load 'human_player.rb'
=> true

[2] pry(main)> dave = HumanPlayer.new(:X)
=> #<HumanPlayer:0x @mark=:X>

[3] pry(main)> positions = [[1, 2], [3, 4], [4, 3]]
=> [[1, 2], [3, 4], [4, 3]]

[4] pry(main)> dave.get_position(positions)
Player X, enter two numbers representing a position in the format `row col`
3 4
=> [3, 4]

[5] pry(main)> dave.get_position(positions)
Player X, enter two numbers representing a position in the format `row col`
2 5
[2, 5] is not a legal position
Player X, enter two numbers representing a position in the format `row col`
1 2
=> [1, 2]
```

Finally, let's verify our AI:

```plaintext
[1] pry(main)> load 'computer_player.rb'
=> true

[2] pry(main)> hal_9000 = ComputerPlayer.new(:Y)
=> #<ComputerPlayer:0x @mark=:Y>

[3] pry(main)> positions = [[1, 2], [3, 4], [4, 3]]
=> [[1, 2], [3, 4], [4, 3]]

[4] pry(main)> hal_9000.get_position(positions)
Computer Y chose position [1, 2]
=> [1, 2]

[5] pry(main)> hal_9000.get_position(positions)
Computer Y chose position [3, 4]
=> [3, 4]
```

Do any other testing that you see fit before moving on.

### Game#initialize

Update this method to accept an option hash instead of the arbitrary number of
marks that you implemented in Version 2. A hash is a great choice here because
you now need to communicate two details per player: their mark and whether they
are human or computer. Let the keys of the hash be the marks and the values,
booleans. Interpret `false` as a human and `true` as a computer. This
configuration allows you to take advantage of the fact that hash keys--like your
player marks--must be unique.

The order of players in the hash should dictate the order in which they take
their turns. For example, the following game would entail three players of X
(human), Y (computer), and Z (human) playing on a 4 by 4 board:

```plaintext
[1] pry(main)> load 'game.rb'
=> true

[2] pry(main)> Game.new(4, X: false, Y: true, Z: false)
=> #<Game:0x
 @players=
  [#<HumanPlayer:0x @mark=:X>,
   #<ComputerPlayer:0x @mark=:Y>,
   #<HumanPlayer:0x @mark=:Z>]>,
 @current_player=#<HumanPlayer:0x @mark=:X>,
 @board=
  #<Board:0x
   @grid=[["_", "_", "_", "_"], ["_", "_", "_", "_"], ["_", "_", "_", "_"], ["_", "_", "_", "_"]]>
```

### Game#play

Only one more upgrade and you'll have your final product! Modify this method
slightly to account for your new argument required for `#get_position`. That is,
be sure to pass in the board's legal positions for the player to choose from.

That's it. Play some diverse games with computers and humans to test your work.
You've done some **amazing** Object-Oriented Programming if you've gotten to
this point. Sit back, relax, and reward yourself by running this snippet in pry:

```ruby
load 'game.rb'
machine_civil_war = Game.new(10, h: true, u: true, e: true)
machine_civil_war.play
```

No Skynet anytime soon.

[duck-typing]: https://en.wikipedia.org/wiki/Duck_typing
[turing-test]: https://en.wikipedia.org/wiki/Turing_test