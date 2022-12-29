## Custom footsteps for Sven Co-op

*You though it was impossible?*

This script allows you to change the default SC's footsteps with your own sounds.

While intended to be used as a map script, this can be used globally as a server plugin if you want to.
Just download the .as file ([click here](https://raw.githubusercontent.com/JulianR0/CFootsteps/main/footsteps.as), then right click --> save as) and then copy this file to:

**svencoop_addon/scripts/plugins** if you want to use this script as a server plugin.

**svencoop_addon/scripts/maps** if you want to use this as a map script.

Then add "map_script footsteps.as" to the end of your map cfg to enable this (If using as a map script).

To customize the footstep sounds, open footsteps.as with your favorite editor and edit to your liking the sound arrays.
**Make sure the length of all arrays are 4!**

You'll find the arrays just below the `CUSTOMIZATION BEGIN` text in the source code:
```
// CONCRETE - Default step sound
const array< string > _ConcreteSounds =
{
	"player/pl_step1.wav",
	"player/pl_step2.wav",
	"player/pl_step3.wav",
	"player/pl_step4.wav"
};

// METAL
const array< string > _MetalSounds =
{
	"player/pl_metal1.wav",
	"player/pl_metal2.wav",
	"player/pl_metal3.wav",
	"player/pl_metal4.wav"
};

// ...
```
All 12 types of footsteps can be customized, including ladder and wade sounds! (Wade sounds are the swimming sounds produced by the players when its knees are underwater)

All sounds written in the arrays are automatically precached - players will download the sounds you add, no need to insert them into a .res file.

A very basic developer map (__footsteps.bsp and __footsteps.cfg) is also provided in the repository to quickly test your choosen sounds.

# Known caveats

This cannot replace the SC's jumping sound, which will be stuck on the last texture type the player was standing on (Usually concrete).

The player *might* hear a "double footstep sound" glitch caused by this script.

The solution to both issues is to set CVar `mp_footsteps` to `0`. However, this is a server CVar, meaning that maps cannot modify it. Until a future update allows maps to modify this CVar, you will need to directly set `mp_footsteps 0` to the server console if you want to ensure custom footsteps work as intended.

If you are still reading this, thank you.
