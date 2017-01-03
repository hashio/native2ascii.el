Copyright 2009 Takahiro Hashimoto
All rights reserved.

native2ascii
============

This program is a emacs major-mode.
Read and write ascii encoding file like a Java properties by native2ascii of Sun's JDK

Setup
=====

1. you need install native2ascii. Oracle JDK have it.

2. write this to your .emacs.

    ;;;
    ; if Windows need set this 2 lines
    ; (setq native2ascii-command-format "native2ascii.exe")
    ; (setq ascii2native-command-format "native2ascii.exe -reverse")
    (load "native2ascii.el")
