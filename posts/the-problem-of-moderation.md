---
title: The problem of moderation in an unfederated social network and a federated one is the exact same problem, send post
date: 2018-09-02
---

![](https://gifer.com/i/oeC.gif)

Online abuse and harassment is not a thing that will ever go away. As long as the web is built to have parties interacting with one another there will be these problems. Many, frustrated with Twitter's refusal to remove Nazi's from their platform, have moved to federated networks like Mastodon. 

While that move is driven by unstandable anger about Twitter's platform it won't fix the issue of abuse and harassment that people see when interacting on social media. Nor was it really intended to. Mastodon wasn't created to be a safe space, nor is it really the technology's job to solve the problem of moderation. 

Why? Mastodon gives users and instance admins the power to choose what to ban what content to allow and what other instances to federate with or not. What this essentially means is that yet again the onus is put on the moderators and admins to ensure the safety of their users and Mastodon is doing their best by giving the tools to do so. 

Folks fleeing to services like Mastodon may be under the false illusion that abuse won't exist on that platform, but that misunderstands the core of the issue on social media. **Moderation**. 

Moderation is not a technical problem. **It should not be solved by technical means.** It is a human problem that needs humans on the other side of things ultimately to be the real deciding factor. 

Speaking with other platform safety teams in tech is a focus of the community & safety team (aka CampS) at GitHub. There remains a common thread of how each company works on harassment and abuse and that is at the end of the day a human generally ends up interacting with the content. 

You can use ML classifiers to categorize spam with a fairly high accuracy, but while there's a pattern in spam of trying to get users to see it and click on it that pattern doesn't really exist for abuse. So, you can build a classifier that looks at user input content and says if it's likely abuse or not, but it generally is able to be gamed, manipulated, or generally just confused. 

You can try this for yourself, but [Perspective API](https://www.perspectiveapi.com/#/) is a tool that claims to be able to tell if a comment is toxic or not. However if you try two common phrases used to demean trans folks:

> Did you just assume my gender?

and 

> I identify as an attack helicopter.

Both get a score of 0.11 unlikely to be precieved as toxic (meanwhile "Fuck TERFs" gets a 0.99 likely to be precieved as toxic score). Why? The classifier has no cultural context for memes that are generally used to harass trans folks, but also these phrases are also sometimes used innoculously to mock transphobic tropes and even if it was trained to recognize these things it wouldn't be able to understand the context. 

Cultural context matters and is highly variable in different spaces and regions. Even a trained human without the cultural context of how the trans community is treated likely would not be able to recognize what's happening here, but that gets to the core of the understanding proper moderation needs. 

A good moderation team has to be a very diverse group of folks who understand patterns of abuse and whatever internet hate mob happens to be active at any given time (which *gate are we at right now?). However, more importantly the moderators need to know when its appropriate to reach out for information about the cultural context and have the resources and the knowledge to understand how marginalized groups are targeted online. 

**What can the tech side do?** Focus on giving moderators the tools do to their jobs. Allow moderators to easily view reported content in the context in whcih it was initially created. What was it a reply to? Who is the person? How does their identity play into the situation? 

Enable users to control their own content. Allow users to block people they don't want to interact with. Give them privacy controls over what content they create and allow responding to that content to be halted at any time.

Increase transparency when not a threat to user privacy. Have editing? Allow there to be an audit log of edits. Who edited the content? When did they edit it? What did they edit (with a chance to expunge this record, but logged somewhere for abuse reports)?

**Social problems cannot be solved with technical means**, but we can provide the tools to help make everyone's lives easier. 