---
title: Making Sense and Nonsense of Markov Chains
---

Andrey Markov is known for two things being a Russian Mathematician and having amazing facial hair (well probably not the latter, but I'd love to think so). A Markov chain is one way of describing data in such a way that we can determine the future state of the world by looking at the current state of the world. 


![Human to Zombie to Vampire](mc_figure1.png)

Consider a world filled with zombies, vampires, and humans. In this world humans can become zombies, vampires, or stay human. Zombies can become humans by a drug created by Dr. Zork or stay zombies. Vampires can become zombies if they feed on zombies or stay human. In a Markov chain we want to consider the probabilities of each of these things occurring. Humans have a 0.50 chance of staying human and a 0.25 chance of becoming a zombie and a 0.25 chance of becoming a vampire. Zombies, on the other hand, have a 0.15 chance of the cure actually working and becoming human again and a 0.85 chance of staying a zombie. Vampires have the highest chance of staying the same at 0.95 and only a 0.05 chance of stupidly feasting on zombie. 


![Matrix](mc_figure2.png)

What we end up with is a Markov chain that looks something like **Figure 1**. As you can see there are 3 nodes for the 3 possible states and transitions from those nodes to other possible states. It's very important that the transitions out of a node sum to one, because we are dealing with probabilities. We can represent this information in another way. **Figure 2** shows the matrix for this data. This matrix can be used to calculate what the future will look like based on the current state of the world. For example if we start out with 100 of each type of living thing in our world we can do the matrix multiplication using the matrix and we get the calculation shown in **Figure 3**. The result shows that in the future there will be 65 humans, 115 zombies, and 120 vampires. 

![The future](mc_figure3.png)

I decided to use Markov chains in order to generate random English sounding words. The program reads in a file containing words and generates a matrix that contains the transitions from one letter to the next letter in the word. Additional transitions are added to consider which letters begin a word and which letters tend to terminate a word. Then to generate a word a random starting position is selected and the transitions are followed until a word is generated.

Example runs of the program:

```
$ python randomWord.py 
Source file: words.txt 
chaner

$ python randomWord.py 
Source file: words.txt 
wer

$ python randomWord.py 
Source file: words.txt 
drumire 
```

The source and input file can be found [here](https://gist.github.com/3928224). 


Andrey Markov image from [Wikimedia Commons](http://en.wikipedia.org/wiki/File:AAMarkov.jpg).