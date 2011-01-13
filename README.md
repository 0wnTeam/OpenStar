OpenStar Project
================

An OpenSource Version of Star.

What is
-------

OpenStar is a really small piece of code that helps developers to create amazing extensions for any MacOSX app.
You can replace ObjectiveC methods, just like in MobileSubstrate, or intercepts C calls to dyld.

Limitations
-----------

OpenStar isn't able to catch C calls to statically linked functions.
On the ObjectiveC part,  you are allowed to replace every method.

How it works™
-------------

OpenStar uses two things to work.

### ObjectiveC Hooking

OpenStar ("Star") uses some ObjC runtime functions in order to replace method calls.
I provide a static library so it's easier to make a piece of code to do that.
You can even copy/paste Star's code in your app or use a dylib, but this is the easier way.

### C Hooking

OpenStar ("Star") uses DYLD_INTERPOSE.
You can't interpose static functions.

### %ctors

Star defines a constructor in your dylib.
That's all.

Yeah, star is just a "helper".
==============================
