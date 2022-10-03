# This is the README for group project 1: Battleship

## Contributors
- Aether Kerstens
- William Lampke
- Michael Marchand

## Next steps:
- refactor `#player_makes_guess` to simplify
  - currently at least 6 behaviors are in the method:
    - prompt player for input
    - gather input
    - evaluate input
    - validate input (how is this different than evaluate input?)
    - fire upon a board
    - remove validate input from possible guesses