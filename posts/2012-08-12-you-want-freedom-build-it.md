---
title: You want freedom? Build it.
author: wilkie
---

There has been [many](http://bytbox.net/blog/2012/08/leaving-github.html) a [debate](http://news.ycombinator.com/item?id=4220353) about the recent, somehow surprising discovery that github is a company with [interests](http://peter.a16z.com/2012/07/09/software-eats-software-development/) that are perhaps beyond our own. Whatever. Honestly, github is replaceable. The real issue is the one we as developers, creatives, and people who like difficult problems should be talking about: WTF is a centralized website doing wrapping a distributed protocol?

## The Problem

I propose a simple, real-world problem: make code as available as possible and ensure that it is correct when retrieved and from the source you desire it. You may give up confidentially and consistency since this is [impos](http://en.wikipedia.org/wiki/Information_security)-[sible](http://en.wikipedia.org/wiki/CAP_theorem) given our goal. Can you provide this with high probability that code cannot be destroyed permanently?

We want it quickly, so we shouldn't reinvent. Therefore, let's look at what we have.

## What is Git

[Git](http://git-scm.com/) is a ridiculously simple protocol. The design is made up of blocks and bridges like most distributed systems. The blocks are commits and the bridges are simple links between them. Follow the bridges from any point, you get a snapshot of the codebase. Easy.

> In many ways you can just see git as a filesystem — it's content-addressable, and it has a notion of versioning, but I really really designed it coming at the problem from the viewpoint of a filesystem person (hey, kernels is what I do), and I actually have absolutely zero interest in creating a traditional SCM system.
> <div class="citation">&mdash; <cite>Linus Torvalds, designer of git and Linux kernel, [available](http://marc.info/?l=linux-kernel&m=111314792424707)</cite></div>

Git projects can be distributed anywhere. Either as a link to the git project through some sort of URI or by duplicating most or all of the structure on a separate system. Consistency is maintained through hashes serving as unique identifiers to target specific commits (when named, this is a code branch) and internal delta objects lighten the load of replication.

Git preserves the integrity of the code (it would be rather worthless if it didn't) with simple hashes and availability through manual replication. The point of a service that uses git would be to strengthen the availability and simply relax and fall in love with the parts that ensure integrity.

Too much hand waving for you? Sweet, read [Git from the bottom up](http://ftp.newartisans.com/pub/git.from.bottom.up.pdf).

## What is Github

[Github](http://github.com) is a centralized website. It serves to host a git project. It is centralized in that it promotes a culture where code is available on their servers and no where else. The fact that you _can_ distribute your code easily on different sites is a property of _git_ not github. If their servers go down (and they [do](https://github.com/blog/744-today-s-outage)) then your code only exists locally in the common case where you do not manually replicate it.

> By orienting around people rather than repositories, GitHub has become the de facto social network for programmers
> <div class="citation">&mdash; <cite>Peter Levine, affiliated with the $100 million backing of github, [available](http://peter.a16z.com/2012/07/09/software-eats-software-development/)</cite></div>

Full disclosure: [All](https://github.com/wilkie) [of](https://github.com/hotsh) [my](https://github.com/xomboverlord) [code](https://github.com/djehuty) is hosted there because people expect it to be. That's not a very good reason. Github does not solve the given problem.

## Why Should We Be Mad?

The thing is... git allows us to have high availability and a known point of access. Hell, we can have known points of access to particular commits. If we replicate and go through a peer-to-peer system, we can have a known point of access to many points of access.

> [CS is] just such an amazing field, and it's changed the world, and we're just at the beginning of the change.
> <div class="citation">&mdash; <cite>Frances E. Allen, compiler and systems researcher, Turing Award winner</cite></div>


Yet... github makes the whole availability thing a bit more difficult in the general case. This should absolutely infuriate us. That's a backward step to solving the given problem. It is a lack of substantial progress. Should we accept the concept of _social coding_ that github gives us even though it hinders or obscures the socially benefitial prospects of a distributed system? Can a diverse set of people use our code _because_ github exists? Nothing prohibits this for _git_, but nothing promotes it either.

## What is a Federated System

Let's discuss an alternative to the centralized autonomy that github provides. A _federated system_ is one that is distributed but acts within a common ecosystem. For example, a federated version of twitter would consist of many separately maintained machines (perhaps one is maintained by you) each serving a website. Each server is responsible for a subset of the content, but access to all public content is shared equally and assumed.

A non-federated distributed system would simply be these machines communicating within some set of pipes. A user on one machine would be a user of that machine. You would have a subset of capabilities which are local to that machine. Users would be detached from the whole, but able to interact with users of other systems through a protocol.

For example, a user of a federated twitter system would be a user on all machines. No matter which machine you use, you would have the same functionality available to you (tweet, reply, direct message). If any one machine knows you exist, you will be seen as a user on that machine even though you physically _exist_ on another. They might even announce you to neighboring systems or replicate your content. Conversely, you will use your machine to interact with others as though they are on your server.

> Status.net exists to fulfill a need of a lot of people, both on the public web and private web, to have a microblogging server that they can control.
> <div class="citation">&mdash; <cite>Evan Prodromou, founder of status.net and identi.ca, [available](http://www.building43.com/videos/2010/04/29/opening-up-microblogging-with-founder-of-status-net/)</cite></div>

You may have used a federated system such as this thing called _email_.

Of course, the federated twitter exists. It is a solved problem. It is both [status.net](http://status.net) which powers [identi.ca](https://identi.ca) and [rstat.us](https://rstat.us), which do indeed talk to each other and other entities.

You build federated systems on top of distributed ones. Federation is a subset. It allows one to contribute to a global view, but retain ownership, control, and integrity of their content.

## The Solution

We need a system that promotes the features of git that are of both practical and social importance: availability and integrity. We need a system that does not allow code to be destroyed or censored. This is something github cannot do. Such a system is only possible through the exposing and leveraging of the distributed nature of git. A git repository is a shared view of a set of commits. A true web-based client of git is by nature already distributed.

To federate the system, all git repositories would be visible and accessible through any system. This could be done very much the way your twitter followers would be distributed leaving a system where all users interact equally. The origins of social interactions (notifications, messages, comments) would be abstracted as well. This is, of course, the same as twitter status updates. A federated twitter is a solved problem, as I stated. The protocol is [OStatus](http://ostatus.org/sites/default/files/ostatus-1.0-draft-2-specification.html), replication is through [PuSH](https://code.google.com/p/pubsubhubbub/) and untrusted notifications are through [salmon](http://salmon-protocol.googlecode.com/svn/trunk/draft-panzer-salmon-00.html). So we just need a [git web client](https://github.com/gitlabhq/gitlabhq/).

Encouraging replication is fairly simple, but certainly second-iteration. I mean, replication is intuitive to git. Any local copy should be able to be pulled from in a peer-to-peer fashion. The commits are preserved (all history is linked) and have a point of access (hash) as a matter of design. So, anybody that installs your code or forks it will be able to host it. Optional, of course, but cooperation can be incentivized. Peer-to-peer protocols are becoming rather commonplace already, for instance, in [video game patching](http://en.wikipedia.org/wiki/BitTorrent#Software) and package management, although typically not well-marketed perhaps due to a negative association with piracy. Using p2p here can ensure that one cannot locate all copies of code easily, and therefore preserve them from accident or maliciousness. Your attribution can be ensured through private keys and self-hosted identity (through something like [webfinger](http://code.google.com/p/webfinger/)).

Put all of these in the same bowl. Mix. Enjoy.
