---
title: Git Shared Repo Woes
---

If you've ever gotten when trying to push to a shared repo: 

```
error: insufficient permission for adding an object to repository database ./objects
```

You probably are new to setting up a shared repository yourself or like me are way to used to just using github for everything. Luckily the solution is easy. We need to just fix the permissions on the repo and let git know that this is a shared repository. We need to create a group with all the developers that are going to be working on this and then we can use three short commands inside our shared repository directory and we are set: 

```
$ sudo chmod -R g+ws * 
$ chgrp -R [groupName] *
$ git repo-config core.sharedRepository true
```

note: if you have issues with chgrp, you should use chown instead: 

```
$ sudo chown -R [userName]:[groupName] .
```