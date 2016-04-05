#### So time to start breaking down this problem.
* a pretty clear first distinction to draw  is the difference between the game and the strategy that the computer will use to win in that game
* An interesting point though, is how much state should the game object store and how much state should the strategy  be responsible for.
* for instance score would obviously be something the game itself should keep track of but  some strategies may rely on a detailed history of which moves were made and in what order.

* I think, for now, it makes sense to keep as much information in the game object itself as possible and have the strategies just ask the game questions. It seems like that will be easier to test as we can make up as many fake games as we like and make sure that our strategies are choosing the correct moves.
  * stateful game -  stateless strategy
