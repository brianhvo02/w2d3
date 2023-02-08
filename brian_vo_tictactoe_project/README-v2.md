# Tic-Tac-Toe, Version 2: Make It Scalable

**Make sure you have Version 1 working correctly before moving on to Version
2.**

Make a copy of your entire __tic_tac_toe_v1__ directory and rename it
__tic_tac_toe_v2__. Open Version 2 in your editor and terminal so you can update
it to support more features. This will be your new working directory.

Your goal for this version is to make the game scale on two fronts:

1. Support a dynamic board size
2. Support more than two players

## Flexible Board size

You need to change a few things to support boards of any size. These
instructions will mention a few general todos, but you may need to change more
if you hard-coded a 3x3 size in your first iteration.

### Board#initialize

Update this method to accept a number argument `n`. The grid should be set
to a 2-dimensional array with size '**n** x **n**', instead of '3 x 3'. It's
worth noting that the grid will always be a square (meaning its height is equal
to its width). This will somewhat simplify things as you update your other
methods.

You will need to update these critical `Board` methods if they contain any
hardcoded values:

- `#valid?`
- `#print`
- `#win_row?`
- `#win_col?`
- `#win_diagonal`
- `#win?`
- `#empty_positions?`

### Checkpoint: Test the fruits of your labor(ed)

Load __board.rb__ using pry. Create different sized boards and invoke **all**
`Board` methods on them. Here are some initial tests, but you should be much
more thorough:

```plaintext
[1] pry(main)> load 'board.rb'
=> true

[2] pry(main)> small = Board.new(4)
=> #<Board:0x
 @grid=[
   ["_", "_", "_", "_"],
   ["_", "_", "_", "_"],
   ["_", "_", "_", "_"],
   ["_", "_", "_", "_"]]
   >

[3] pry(main)> large = Board.new(6)
=> #<Board:0x
 @grid=
  [["_", "_", "_", "_", "_", "_"],
   ["_", "_", "_", "_", "_", "_"],
   ["_", "_", "_", "_", "_", "_"],
   ["_", "_", "_", "_", "_", "_"],
   ["_", "_", "_", "_", "_", "_"],
   ["_", "_", "_", "_", "_", "_"]]>

[4] pry(main)> small.valid?([3, 3])
=> true

[5] pry(main)> small.valid?([5, 5])
=> false

[6] pry(main)> large.valid?([5, 5])
=> true
```

### Game#initialize

Update this method to also accept a number for the board size as the first
argument.

That **should** be all you need to change since you designed your Version 1 to
avoid as much coupling to `Board` as possible. However, take a moment to scan
the rest of your `Game` and `HumanPlayer` class to be sure.

Use pry to play a few games of varying size to completion before continuing
further.

## Flexible number of players

Adding support for any number of players should require a decent refactor of the
`Game` class, but no major changes to `HumanPlayer`. The only logic that should
change is how we decide _which_ player should move, but the capabilities of any
single player remains unchanged.

### Game#initialize

An instance of `Game` will now need to track an array of many players instead of
just two. Make this an instance variable. Allow your `#initialize` to accept any
number of mark values. The number of marks passed to `#initialize` will decide
how many players are in the game.

### Game#switch_turn

For your switching logic, you'll use a "Round Robin" strategy. This means that
players continually take turns in the same order. For example, if you had
players A, B, and C, then the turns would be ABCABCABC... until the game is
over.

For simplicity, always designate whoever is at the front of the array as the
current player. Consider using `Array#rotate!` to accomplish this.

Test the switching logic in isolation using pry. Here is how your class should
work:

```plaintext
[1] pry(main)> load 'game.rb'
=> true

[2] pry(main)> g = Game.new(4, 'A', 'B', 'C')
=> #<Game:0x
 @board=
  #<Board:0x
   @grid=[["_", "_", "_", "_"],
          ["_", "_", "_", "_"],
          ["_", "_", "_", "_"],
          ["_", "_", "_", "_"]]>,
 @current_player=#<HumanPlayer:0x @mark="A">,
 @players=
  [#<HumanPlayer:0x @mark="A">,
   #<HumanPlayer:0x @mark="B">,
   #<HumanPlayer:0x @mark="C">]>

[3] pry(main)> g.switch_turn
=> #<HumanPlayer:0x @mark="B">

[4] pry(main)> g.switch_turn
=> #<HumanPlayer:0x @mark="C">

[5] pry(main)> g
=> #<Game:0x
 @board=
  #<Board:0x
   @grid=[["_", "_", "_", "_"],
          ["_", "_", "_", "_"],
          ["_", "_", "_", "_"],
          ["_", "_", "_", "_"]]>,
 @current_player=#<HumanPlayer:0x @mark="C">,
 @players=
  [#<HumanPlayer:0x @mark="C">,
   #<HumanPlayer:0x @mark="A">,
   #<HumanPlayer:0x @mark="B">]>
```

After you see that the current player is switching properly, you should be able
to play your game! Play a few rounds of varying size for good measure. Pretty
neat, huh?

Now on to Version 3!