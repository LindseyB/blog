---
title: Blender Rigify to Unity Ragdoll
date: 2015-08-08
---

Some files to help you along:

- [body.blend: a very simple humanoid model](https://www.dropbox.com/s/we3amesmuny95l9/body.blend?dl=0)
- [unity-ready.blend: an already rigged model if you want to skip to the unity part](https://www.dropbox.com/s/djs4crc1b6nj3rm/unity-ready.blend?dl=0)
- [ragdoll-tutorial.unitypackage: unity package if you want to see it all put together](https://www.dropbox.com/s/yr7jharxvaguiqf/ragdoll-tutorial.unitypackage?dl=0)

#### Step 1
![Open your model or the one provided in Blender. Make sure the rigify add-on is enabled in Blender by going to User Preferences, hitting the Add-on's tab and typing rigify to bring it up](https://i.imgur.com/j4KINWc.gif)


#### Step 2
![On your mesh hit Shift-A and select Armature > Human (Meta-rig) from the menu. You might need to move and adjust your meta-rig so it lines up nicely.](https://i.imgur.com/FAZEJrJ.gif)

#### Step 3
![With the metarig selected switch to armature and then under Rigify Buttons at the bottom select 'Generate'. It might take a little bit to generate your rig.](https://i.imgur.com/AvSHnBd.gif)

#### Step 4
![Deselect your rig by hitting 'A' then select your mesh and then your rig and hit Ctrl-P and select 'With Automatic Weights'.](https://i.imgur.com/58rlTdl.gif)

#### Step 5
![Delete all of the WGT items that Blender generates.](https://i.imgur.com/2awTfv6.png)

#### Step 6
![Open up a Unity project and add your .blend file to a scene. Then, open the Ragdoll wizard by right clicking on your object selecting 3D Object and hitting Ragdoll...](https://i.imgur.com/FGAMB7K.gif)

#### Step 7
![Assign your bones as shown here and click create when you are done.](https://i.imgur.com/7odBbUw.png)

![Enjoy your new ragdoll - you might need to make some adjustments in Unity to get it looking exactly how you want, but it's a good start.](https://i.imgur.com/ba3JGjX.gif)
