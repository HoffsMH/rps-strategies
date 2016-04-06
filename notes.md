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
