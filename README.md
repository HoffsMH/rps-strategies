### RPS-Strategies
The instructions on how to operate are below.

 I've also included a notes.md file inside it is going to be my thought process as I work through each problem. This isn't meant to be formal documentation. Its just a sort of flow of consciousness so the reader can get an idea of what I am thinking.

#### Installation:
* ``` bundle ```
* ```ruby rps.rb <strategy> ``` (if strategy isn't found or not specified will use default)

#### Testing:
* ``` bundle exec rspec ```

#### Available strategies:
* ```last ```
* ```favorite ```

#### Extra Strategies:
* ```random```
  * Exactly what you would expect.
* ```adaptive-last ```
  * This is somewhate similar to the "last" strategy. See details here [http://arstechnica.com/science/2014/05/win-at-rock-paper-scissors-by-knowing-thy-opponent/](http://arstechnica.com/science/2014/05/win-at-rock-paper-scissors-by-knowing-thy-opponent/)
* ```iocaine-powder```
  * This is a complicated strategy See details here
  * [http://ofb.net/~egnor/iocaine.html](http://ofb.net/~egnor/iocaine.html) By Dan Egnor
  *  I don't plan to make a full implementation of it, for an explanation and to see how far I get please refer to the notes.
  * If you have a positive W/L ratio against this after 150 rounds, I'm impressed.
  * I usually can't make it past 50 rounds before the strategy starts learning enough beat me consistently
