---
title: Git collaboration fun for beginners
---

It's pretty easy to get started using git. [TryGit](http://try.github.com/) is a really awesome introduction to the basic commands to get you started using git for version control. However, one of the awesome features of git is just how easy to is to collaborate with others. 

One of the easiest ways to move code between yourself and others that have a fork of the repository is by adding a remote. This allows you to reference their repository from with yours. So, if I wanted to add Batman's copy of this blog (and suppose he forked me on github) I could run the following command:

```
git remote add Batman git@github.com:Batman/blog.git
```

But say I was the Joker (who calls Batman, Bats, by the way) I would probably decide to add the remote like this: 

```
git remote add Bats git@github.com:Batman/blog.git
```

What I am getting at is this: you can name the remote whatever you want. Usually I try to stick with the person's name or handle, but say if it was part of an organization or something difficult to spell or type you can give it any alias you want.


If Batman made some changes to the master branch that I want I can now do:

```
git pull Batman master
```

Which will grab all of Batman's changes from Batman's master branch and merge them into my master branch.

Let's suppose now that Batman created a new branch on blog called "batman-theme" which changes all my CSS to make my blog feel more like the the batcave and I want to look at his branch on my machine. 

That's where ```fetch``` comes into play. 

![](https://i.imgur.com/Lmzix.gif)

```git fetch``` allows us to download branches and data from remote repositories. The usage is rather simple: 

```
git fetch Batman
```

Now I will have all of Batman's branches to reference locally. Now if I want to see what's inside the "batman-theme" branch I can do:

```
git checkout Batman/batman-theme
```

You will probably get the message that ```You are in 'detached HEAD' state.``` which is fine, unless you are a zombie. This simply means that the state you are currently in isn't really part of your repository.However, if say I decided I liked the batman theme and I wanted it to be a branch in my repository I could do:

```
git checkout -b batman-theme
```

If we know we want to create this new branch we can do one single command:

```
git checkout -t Batman/batman-theme
```

Which is the exact same as running the two previous commands. 

Now I have an exact copy of this batman-theme branch in my repository. If I like the changes this branch makes and want to make it part of my master branch then I can ```git merge```. The following two commands will change my current branch to the one I want to merge the changes into (master) and then do the merge with the branch I want to get the changes from (batman-theme). 

```
git checkout master
git merge batman-theme
```

Let's now suppose that I have lots of remotes (Batman, Robin, Batgirl, Batwoman, Oracle and Nightwing) and that I want to get all of the branches and data from all of them. I can do the following:

```
git remote update
```

This will run ```git fetch``` for every single on of my remotes. Be careful, however, if you have a lot of remotes or remotes have **a lot** of branches this may take some time. 

*Happy code collaboration!*