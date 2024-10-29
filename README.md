# Tennis Scorer

Demo app for TDD talk at BT AgileFest 2024.

The starting point (`main` branch) is a working Phoenix LiveView application,
which displays a tennis scoreboard. However, the scoring doesn’t actually match
the rules of tennis, and the task is to test-drive, in small steps, the changes
required to meet the following (based on [Tennis
Kata](https://sammancoaching.org/kata_descriptions/tennis.html)):

  * Point scores of zero, one, two and three should be shown as love, fifteen,
    thirty and forty respectively.
  * If one player has four or more points, and is two or more points ahead,
    then they have won, and the score should be shown as “Game <player>”.
  * If one player has four or more points, and is only one point ahead, the
    score should be shown as “Advantage <player>”.
  * If both players have four or more points, and are on the same score, the
    score should be shown as “Deuce”.
  * Sets and matches are out of scope.

There are tests (in `test/tennis_scorer_web/live/scoreboard_live_test.exs`)
which fully cover the initial functionality, but they are all run against the
LiveView, which is also where all the business logic currently resides.

To run the tests, just run `make`.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
