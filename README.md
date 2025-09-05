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

## Testing

There are tests (in `test/tennis_scorer_web/live/scoreboard_live_test.exs`)
which fully cover the initial functionality, but they are all run against the
LiveView, which is also where all the business logic currently resides.

To run the tests, just run `make`.

## Practice branches and demo outline

There are numerous branches from practice sessions, which probably all ended up
with slightly different code. The `practice-9` branch is the latest at the time
of writing, and has the most detailed commit history (there’s a wrinkle in that
the implementation originally used a multiheaded function that I later
refactored to a `cond` statement – I’d probably start with the `cond` version
in an actual demo, both to reduce confusion and to allow for factoring out the
common check between `Game.display_score/1` and `Game.over?/1`).

The rough ‘script’ behind that branch is as follows:

* Look at app in browser
  * add scores
  * reset scores
  * edit names
* New requirement
  * Proper scoring
* Observe that we have tests, and a makefile, and allegedly 100% coverage
* Read the tests to understand existing behaviour
  * This is one of the advantages of well-designed automated tests, if not
    specifically TDD
  * Tests are examples of behaviour in specific scenarios
* Refactor
  * Extract `Game` struct (by wishful thinking; covered by existing tests)
  * Add `Game.new/2` (provide names; init scores to 0; pass or change the
    message)
  * Call `Game.new/2` from LiveView
  * Change existing tests to match new scoring rules (0 – 0, 1 – 0 and 1 – 1
    become love all, fifteen love and fifteen all respectively)
  * Observe multiple responsibilities (display and score calculation)
  * We don’t want to add new business rules to the LiveView. Where do they
    belong? The `Game` module! We don’t want to refactor on red though, so
    stash the test changes for now
  * Move `award_point_to_player_` functions into `Game`, and write unit tests
    as we go
  * Note how we can safely move stuff around, protected by our test suite
  * Reapply the stashed test changes, so we have an acceptance test to work
    towards
  * Score generation is currently embedded in the html template, so we can
    build up the required functionality in `Game` then plug it in
  * Create `Game.display_score/1`, and pass first test by hard-coding ‘love
    all’
  * Clearly not the real solution, which prompts us to find an example where
    the current behaviour is wrong or incomplete
  * Implement fifteen love case by pattern matching. Doesn’t feel quite right,
    but let’s be sure we understand the pattern before jumping to an
    abstraction
  * Parameterise tests to avoid duplication
  * Once we have 0–0, 15–0, 0–15 and 15–15, we can see a pattern: if the scores
    are different, we convert each side to a label, and if they’re the same,
    it’s _label_ all. Refactor!
  * But wait! Now we have enough scores implemented that we can plug it into
    the Gui and make sure our integration tests pass
  * Implement other scores, then deuce and game
  * Maybe implement `Game.over?/1`, and disable score buttons when over (copy
    win logic from `display_score/1`, then factor out duplication on green)

## Running the application

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
