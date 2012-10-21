---
title: What the hell is an exokernel?
---

I've worked a little bit on the exokernel project [XOmB](http://xomb.org) and very often I struggle to explain exactly what an exokernel is. So, here it is in simple to understand (and imperfect) car analogy. 

![car analogy](itsacaranalogy.png)

Monolithic kernels like Windows and Linux are like a car where the kernel along with drivers, file system code, etc. all has their own steering wheel and at any point any of these things can cause the car to crash and thus crash your system. Resulting in something like the Windows blue screen of death which is very often caused by faulty drivers. 

In the exokernel each thing is put in its own individual car so if one driver decides to go crash into a telephone pole everything is still okay with the rest of the system.