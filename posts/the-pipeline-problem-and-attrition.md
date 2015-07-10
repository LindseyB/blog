---
title: The pipeline problem and attrition
date: 2014-03-31
---

Usually we model population growth with this basic model:

```
population growth rate = incoming rate - attrition rate
```

For the sake of this example we'll use the incoming rate as the number of women attaining cs degrees based on [the taulbee survey](http://cra.org/resources/taulbee/), let's say 18% even though it varies. Our attrition rate will be the percent of women that leave tech after 10 years from [NCWIT](http://www.ncwit.org/sites/default/files/legacy/pdf/NCWIT_TheFacts_rev2010.pdf) at 41%. 

```
population growth rate = (.18 - .41)
                       = (-.23)
```

![mathematical!](https://unironicallyenthusiasticnerd.files.wordpress.com/2013/10/mathematical.gif)

So, the number of women in tech is decreasing based on these two numbers. Obviously, not a perfect model since both the attrition rate and the incoming rates vary. Additionally, there are clearly those who enter tech, no matter what gender, without a CS degree. However, we can use this to make some assumptions about the relative change in the number of women. 

For population growths we can say that given an initial amount we can estimate what it will be in the next time step. So, here we're assuming our rates are per year. 

The generalized equation is: N<sub>n</sub> = N<sub>0</sub> (1-.23)<sup>n</sup> 

So let's just look one year into the future: N<sub>1</sub> = N<sub>0</sub> (1 - .23)
and our starting population, N<sub>0</sub> = 100, just to make it easy. We would expect to see 77 women in the tech field in the next year.

We see a lot of people trying to attack the issue of women in tech by simply trying to add more people to the pipeline, but to overcome a rate of attrition as high as 41% we need to more than double the amount of women entering the tech workforce. 

We should be trying to fix this pipeline from both ends. The pipe is leaking. Sure, we can increase the number of women entering the field, but we should be working to make tech a place where people want to stay - not just for the sake of women, but for all people coming into the field.  