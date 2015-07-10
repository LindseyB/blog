---
title: Bernoulli and Ada sitting in a tree...
date: 2015-03-20
---

Ada Lovelace is credited with writing the very first computer program. This program was for Babbage's Analytical Engine and calculated Bernoulli numbers. 

Bernoulli numbers have the following mathematical definition: 

![sum_(n=0)^infinity (B_n t^n)/(n!) = t/(exp(t)-1)](https://i.imgur.com/SRCs1pI.png)

It's just a sequence of numbers that looks something more like this:

| n | Bn   |
|---|------|
| 0 | 1    |
| 1 | -1/2 |
| 2 | 1/6  |
| 3 | 0    |
| 4 | -1/30| 
| 5 | 0    |
| 6 | 1/42 |
| 7 | 0    |
| 8 | -1/30| 
| 9 | 0    |
|10 | 5/66 | 


They've been found to be important since they keep coming up over and over in mathematics, which makes them really interesting from a number theory perspective. Also, note that all odd *n* after 1 has the value of 0. 


> The Bernoulli numbers appear in the Taylor series expansions of the tangent and hyperbolic tangent functions, in formulas for the sum of powers of the first positive integers, in the Euler–Maclaurin formula, and in expressions for certain values of the Riemann zeta function. 
<div class="citation"><cite><a href="http://en.wikipedia.org/wiki/Bernoulli_number">from the Bernoulli Number Wikipedia page</a></cite></div>

Well after Ada Lovelace wrote her 'program' to calculate Bernoulli numbers a language called Ada was created. Using the [Akiyama–Tanigawa algorithm for second Bernoulli numbers](http://en.wikipedia.org/wiki/Bernoulli_number#Algorithmic_description) I decided to write my very first Ada program. 

You can see the result below fully commented with my frustrations and concerns along with what the code outputs (note that this is with Ada 2012, though most information I found on Ada was for Ada 95).

<script src="https://gist.github.com/LindseyB/7f6918fd87855468496c.js"></script>