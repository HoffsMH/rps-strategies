#### So time to start breaking down this problem.
* a pretty clear first distinction to draw  is the difference between the game and the strategy that the computer will use to win in that game
* An interesting point though, is how much state should the game object store and how much state should the strategy  be responsible for.
* for instance, score would obviously be something the game itself should keep track of but  some strategies may rely on a detailed history of which moves were made and in what order.

* I think, for now, it makes sense to keep as much information in the game object itself as possible and have the strategies just ask the game questions. It seems like that will be easier to write test for as we can make up as many fake games as we like and make sure that our strategies are choosing the correct moves.
  * stateful game -  stateless strategy


#### Ok now we have our working game object.
* its time to write our first strategy
* still keeping with the theme that our strategies are going to be stateless
  * because of that in rps.rb there is no reason for us to instantiate anything with ```new```
  * lets try to keep the strategies as modules instead of classes, behavior only
* Going to start with the ```last``` strategy
* evaluate is just going to look at the top of the game's history and get the opponents move for that turn and then suggest the move that beats that move

#### Well that was easy
* time to move onto the ```favorite``` strategy
* this one should be a bit harder, we are going to iterate through the entire history and tally up scores for the  opponents favorite move and then suggest to beat that move

* NOTE: at this point it should be noted that, since I am keeping with the theme that strategies will be stateless, we must iterate through the history EACH TIME we want want evaluate a game. As games go longer and longer this will become more and more of a performance hit.
  * if we see arbitrarily large games occur we could have our strategy optionally accept some sort of store  along with the game object like this
  * ``` strategy.evaluate(game: game, store: store)```
  * the downside is that we would need to add some conditional logic to ```rps.rb``` and ideally we want that file to be as agnostic about strategies as possible


* in Favorite.get_max not using max_by because the values it returns when there is a tie between two moves don't make sense for our game
* when there is a 2 way tie or 3 way tie we should choose randomly

#### Moving on to adaptive-last
* this strategy is detailed here [http://arstechnica.com/science/2014/05/win-at-rock-paper-scissors-by-knowing-thy-opponent/](http://arstechnica.com/science/2014/05/win-at-rock-paper-scissors-by-knowing-thy-opponent/)

*  basically if the player won last round with rock the player is more likely to play rock again so we counter that with paper
* if the player lost last round with rock he is likely to counter what we last used (paper) so the player will pick scissors, so we will pick rock.

* if the opponent loses play what the opponent just played
* if the opponent wins play what counters what the opponent just played.

* as for what happens after draws I think for now we will just go with random, its possible I will have time for history matching later on

#### iocaine powder part 1
* [http://ofb.net/~egnor/iocaine.html](iocaine powder) by Dan Egnor
* I am aware that the source is available but I am avoiding reading it and trying to figure out how to write this from his description
  * not that the source would even help me, I don't know the first thing about C!
* I don't plan on being able to implement the full version over the next 12 hours but I do plan to work iteratively and have something somewhat resembling this strategy by tomorrow

* The first cool thing that I'm learning as Im reading over this is that its possible for a prediction and a strategy based on that prediction to be 2 totally separate things
  * so before I get to work on the first iteration of ```iocaine-powder``` Im going to have to come up with atleast one separate prediction algorithm.
  * for now Im just going to co-opt my ```adaptive-last`` algorithm, Later on I might try the "history matching" algorithm detailed on the website.

#### iocaine powder part 2
* Ok I now have a working version of my adaptive-last-predictor time to start working on iocaine itself

* To start talking myself through this...
  * I have a rough idea of how to use a prediction algorithm on a complete game history and then use a meta strategy on that prediction to form a final suggestion

  * The hard part seems to be figuring out which (prediction algorithm)-(meta strategy) combination to use.

  * From my understanding: I have to use each (prediction)-(strategy) combination on each unique point in game history and determine whether using that combination would result in a win(+1), loss(-1), or draw(0).

  * the (prediction)-(strategy) combination with the highest score after iterating through every point in history is the winner and is what is suggested for the next move

#### I can now get the top scoring combination from a score hash and generate an initial score hash!

##### So now its time to populate that score hash

  * I need to break up each round in history into a sub-history, going from that specific round to the very first round, and use each of those predictors on each of those sub histories

  * So say I have round 1-4 in history with 4 being the latest round and 1 being the first round
    * The list of histories I want to submit to all of my predictors are:
      ```
      round 1-3
      round 1-2
      round 1
      ```
  * the nested loops are getting icky but I want to stick with this theme of keeping as much state as possible away from the strategies
