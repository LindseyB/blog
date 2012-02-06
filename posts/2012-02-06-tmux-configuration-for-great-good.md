---
title: tmux Configuration for Great Good
author: Dave Wilkinson
---

The tmux (terminal multiplexor) tool is a great way to manage the hellspawn of
computational evolution and TERMINFO hurdling that is the *modern* terminal. If
you spawn multiple terminals, or even multiple terminal tabs, to manage your
terminal space... stop that immediately.

I just want to jot down some quick configuration fu to set up a decent tmux environment.
We want one with 256 color support, a more than decent amount of scrollback, utf8, etc.

## .bash_profile

To have 256 colors, we need to set the TERM variable to xterm-256color by adding an
export to our bash_profile. Put this line at the end:

    export TERM=xterm-256color

If you don't want to do that for some reason, then we can just alias the tmux command
to set that variable:

    alias tmux='TERM=xterm-256color tmux'

## .tmux.conf

Throw whatever subset of these features you'd like into the .tmux.conf file in your
home folder. Create one if it doesn't exist.

### 256 Colors

    set -g default-terminal "screen-256color"

### Scrollback History

    set -g history-limit 30000   # 30,000 lines of scrollback

### UTF8

    set -g utf8 on               # utf8

### Mouse

    setw -g mode-mouse on        # Mouse useful in copy-mode
    set  -g mouse-select-pane on # Mouse can select the current pane

### Vi-Style Commands

    setw -g mode-keys vi         # vi-style commands in copy-mode

## Loading the configuration

You do not need to quit tmux to alter the configuration. Just detach and type

    tmux source ~/.tmux.conf

And then reattach:

    tmux attach

And you're all set.
