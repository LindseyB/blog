---
title: Blender Rigify to Unity Ragdoll
date: 2015-08-08
---

#### Step 1
![Open your model or the one provided in Blender. Make sure the rigify add-on is enabled in Blender by going to User Preferences, hitting the Add-on's tab and typing rigify to bring it up](http://i.imgur.com/j4KINWc.gif)


#### Step 2
![On your mesh hit Shift-A and select Armature > Human (Meta-rig) from the menu. You might need to move and adjust your meta-rig so it lines up nicely.](http://i.imgur.com/FAZEJrJ.gif)

#### Step 3
![With the metarig selected switch to armature and then under Rigify Buttons at the bottom select 'Generate'. It might take a little bit to generate your rig.](http://i.imgur.com/AvSHnBd.gif)

#### Step 4
![Deselect your rig by hitting 'A' then select your mesh and then your rig and hit Ctrl-P and select 'With Automatic Weights'.](http://i.imgur.com/58rlTdl.gif)

#### Step 5
![Delete all of the WGT items that Blender generates.](http://i.imgur.com/2awTfv6.png)

#### Step 6
![Open up a Unity project and add your .blend file to a scene. Then, open the Ragdoll wizard by right clicking on your object selecting 3D Object and hitting Ragdoll...](http://i.imgur.com/FGAMB7K.gif)

#### Step 7
![Assign your bones as shown here and click create when you are done.](http://i.imgur.com/7odBbUw.png)

![Enjoy your new ragdoll - you might need to make some adjustments in Unity to get it looking exactly how you want, but it's a good start.](http://i.imgur.com/ba3JGjX.gif)