# Cromulent

A World of Warcraft addon for adding perfectly cromulent data to the world map.

## Battle for Azeroth

Battle for Azeroth (8.0) brought many changes to the way the world map works,
as a consequence, Cromulent doesn't quite work the same as it used to.

The major change here is that the Cromulent text is no longer attached to the
world map zone text at the top centre of the world map. It currently lives
out of the way (hopefully) at the bottom left of the world map. It is hoped
that displaying the text the old way is something that will be possible in the
future.

The fishing skill levels are also hidden for now, the authors of LibTourist
(which Cromulent uses to get the instance and fishing information) are unsure
of how the fishing levels work after the profession changes in 8.0 so all
fishing level information calls to the library are returning `0` for now. Since
it would be pointless to display this, the fishing information in Cromulent has
been hidden until LibTourist authors are happy.
