/** CUSTOM FOOTSTEPS
*
* by Giegue
*
* This script allows you to change the default SC's footsteps with your own sounds
*
* You can use this script as a server plugin or as a map script
* As a server plugin, copy this file to svencoop_addon/scripts/plugins
* As a map script, copy this file to svencoop_addon/scripts/maps
*
* Just add "map_script footsteps.as" to the end of your map cfg to enable this
* (If using as a map script)
*
*/

/** CUSTOMIZATION BEGIN
*
* Change here the sounds to your liking
* Make sure the length of all arrays are 4
* Fill with null.wav if you don't want a certain texturetype to emit a sound
*
* All sounds are automatically precached, players will download these sounds
*/
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

// DIRT
const array< string > _DirtSounds =
{
	"player/pl_dirt1.wav",
	"player/pl_dirt2.wav",
	"player/pl_dirt3.wav",
	"player/pl_dirt4.wav"
};

// VENT
const array< string > _VentSounds =
{
	"player/pl_duct1.wav",
	"player/pl_duct2.wav",
	"player/pl_duct3.wav",
	"player/pl_duct4.wav"
};

// GRATE
const array< string > _GrateSounds =
{
	"player/pl_grate1.wav",
	"player/pl_grate2.wav",
	"player/pl_grate3.wav",
	"player/pl_grate4.wav"
};

// TILE
const array< string > _TileSounds =
{
	"player/pl_tile1.wav",
	"player/pl_tile2.wav",
	"player/pl_tile3.wav",
	"player/pl_tile4.wav"
};

// SLOSH
const array< string > _SloshSounds =
{
	"player/pl_slosh1.wav",
	"player/pl_slosh2.wav",
	"player/pl_slosh3.wav",
	"player/pl_slosh4.wav"
};

// WOOD
const array< string > _WoodSounds =
{
	"player/pl_wood1.wav",
	"player/pl_wood2.wav",
	"player/pl_wood3.wav",
	"player/pl_wood4.wav"
};

// COMPUTER
const array< string > _ComputerSounds =
{
	"player/pl_step1.wav",
	"player/pl_step2.wav",
	"player/pl_step3.wav",
	"player/pl_step4.wav"
};

// GLASS
const array< string > _GlassSounds =
{
	"player/pl_step1.wav",
	"player/pl_step2.wav",
	"player/pl_step3.wav",
	"player/pl_step4.wav"
};

// FLESH
const array< string > _FleshSounds =
{
	"player/pl_organic1.wav",
	"player/pl_organic2.wav",
	"player/pl_organic3.wav",
	"player/pl_organic4.wav"
};

// SNOW
const array< string > _SnowSounds =
{
	"player/pl_snow1.wav",
	"player/pl_snow2.wav",
	"player/pl_snow3.wav",
	"player/pl_snow4.wav"
};

// WADE (played when the player's knee is underwater)
const array< string > _WadeSounds =
{
	"player/pl_wade1.wav",
	"player/pl_wade2.wav",
	"player/pl_wade3.wav",
	"player/pl_wade4.wav"
};

// LADDER
const array< string > _LadderSounds =
{
	"player/pl_ladder1.wav",
	"player/pl_ladder2.wav",
	"player/pl_ladder3.wav",
	"player/pl_ladder4.wav"
};

/** CUSTOMIZATION END
*
* Everything below here is the actual code that handles the footsteps
* You should not modify it unless you know what you are doing
*
* PS: Breaking things are the best way to learn!
*/

const int STEP_CONCRETE = 0;	// default step sound
const int STEP_METAL = 1;		// metal floor
const int STEP_DIRT = 2;		// dirt, sand, rock
const int STEP_VENT = 3;		// ventillation duct
const int STEP_GRATE = 4;		// metal grating
const int STEP_TILE = 5;		// floor tiles
const int STEP_SLOSH = 6;		// shallow liquid puddle
const int STEP_WOOD = 7;		// 
const int STEP_COMPUTER = 8;	// 
const int STEP_GLASS = 9;		// 
const int STEP_FLESH = 10;		// 
const int STEP_SNOW = 11;		// 
const int STEP_WADE = 12;		// wading in liquid
const int STEP_LADDER = 13;		// climbing ladder

// disabling the hook crashes the game, just use a global variable
bool hook_enabled = true;

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Julian \"Giegue\" Rodriguez" );
	g_Module.ScriptInfo.SetContactInfo( "www.steamcommunity.com/id/ngiegue" );
}

void MapInit()
{
	g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @PlayerPreThink );
	
	// Precache all footsteps
	for ( uint uiSound = 0; uiSound < _ConcreteSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _ConcreteSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _ConcreteSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _MetalSounds.length(); uiSound++ ) // copypaste but it's a beatbox
	{
		g_Game.PrecacheGeneric( "sound/" + _MetalSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _MetalSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _DirtSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _DirtSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _DirtSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _VentSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _VentSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _VentSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _GrateSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _GrateSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _GrateSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _TileSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _TileSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _TileSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _SloshSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _SloshSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _SloshSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _WoodSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _WoodSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _WoodSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _ComputerSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _ComputerSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _ComputerSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _GlassSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _GlassSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _GlassSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _FleshSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _FleshSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _FleshSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _SnowSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _SnowSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _SnowSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _WadeSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _WadeSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _WadeSounds[ uiSound ] );
	}
	for ( uint uiSound = 0; uiSound < _LadderSounds.length(); uiSound++ )
	{
		g_Game.PrecacheGeneric( "sound/" + _LadderSounds[ uiSound ] );
		g_SoundSystem.PrecacheSound( _LadderSounds[ uiSound ] );
	}
}

// for map scripts that want to enable/disable the custom footsteps on-demand
void ToggleFootsteps( CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue )
{
	hook_enabled = !hook_enabled;
	if ( hook_enabled )
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "* Custom footsteps enabled.\n" );
	else
		g_PlayerFuncs.ClientPrintAll( HUD_PRINTTALK, "* Custom footsteps disabled.\n" );
}

HookReturnCode PlayerPreThink( CBasePlayer@ pPlayer, uint& out dummy )
{
	if ( !hook_enabled )
		return HOOK_CONTINUE;
	
	// mp_footsteps is a server cvar and maps cannot modify it
	// disable game footsteps by making the engine believe it's never the time to play a sound
	pPlayer.pev.flTimeStepSound = 100;
	// this does not prevent the footstep sound caused by jumping, which will be stuck on the last
	// texture type the player was standing on. unless mp_footsteps 0.
	// but i already said that you cannot touch it.
	
	// now that the engine's own footstep system is (mostly) disabled, create our own logic
	CustomKeyvalues@ pKVD = pPlayer.GetCustomKeyvalues();
	
	// it is time to play a sound?
	if ( g_Engine.time > pKVD.GetKeyvalue( "$f_timestep" ).GetFloat() )
	{
		// player is in a frozen state, stop
		if ( ( pPlayer.pev.flags & FL_FROZEN ) != 0 )
			return HOOK_CONTINUE;
		
		// how fast the player should be to emit a sound
		float speed = 210;
		if ( pPlayer.IsOnLadder() )
			speed = 80;
		
		// only play a sound if the player is moving fast enough (or is on a ladder)
		if ( ( pPlayer.IsOnLadder() || ( pPlayer.pev.flags & FL_ONGROUND ) != 0 ) && pPlayer.pev.velocity.Length() >= speed )
		{
			// find out what we're stepping in or on...
			Vector center, knee, feet;
			float height;
			
			center = knee = feet = ( pPlayer.pev.absmin + pPlayer.pev.absmax ) * 0.5;
			height = pPlayer.pev.absmax.z - pPlayer.pev.absmin.z;
			
			knee.z = pPlayer.pev.absmin.z + height * 0.2;
			feet.z = pPlayer.pev.absmin.z;
			
			int step;
			float fvol, next;
			if ( pPlayer.IsOnLadder() )
			{
				step = STEP_LADDER; // type of footstep
				fvol = 0.35; // how loud the sound should be
				next = g_Engine.time + 0.35; // when to play the next sound
			}
			else if ( g_EngineFuncs.PointContents( knee ) == CONTENTS_WATER )
			{
				step = STEP_WADE;
				fvol = 0.65;
				next = g_Engine.time + 0.6;
			}
			else if ( g_EngineFuncs.PointContents( feet ) == CONTENTS_WATER )
			{
				step = STEP_SLOSH;
				fvol = 0.5;
				next = g_Engine.time + 0.3;
			}
			else
			{
				// find texture under player, get material type
				Vector start, end;
				
				start = end = center;							// center point of player BB
				start.z = end.z = pPlayer.pev.absmin.z;			// copy zmin
				start.z += 4.0;									// extend start up
				end.z -= 24.0;									// extend end down
				
				string szTextureName = g_Utility.TraceTexture( pPlayer.pev.groundentity, start, end );
				char type;
				if ( szTextureName.Length() > 0 )
				{
					// strip leading '-0' or '{' or '!'
					if ( szTextureName[ 0 ] == "-" )
					{
						szTextureName.SetCharAt( 0, " " );
						szTextureName.SetCharAt( 1, " " );
						szTextureName.Replace( " ", "" );
					}
					if ( szTextureName[ 0 ] == "{" )
						szTextureName.Replace( "{", "" );
					else if ( szTextureName[ 0 ] == "!" )
						szTextureName.Replace( "!", "" );
					
					// get texture type
					type = g_SoundSystem.FindMaterialType( szTextureName );
				}
				
				// map the texture type to step type
				// ...
				// ERROR: The default case must be the last one
				// ERROR: Switch expressions must be integral numbers
				// ...
				// Oh shut up, will ya?! -Giegue
				switch ( uint32( type ) )
				{
					case uint32( CHAR_TEX_CONCRETE ): step = STEP_CONCRETE; break;
					case uint32( CHAR_TEX_METAL ): step = STEP_METAL; break;
					case uint32( CHAR_TEX_DIRT ): step = STEP_DIRT; break;
					case uint32( CHAR_TEX_VENT ): step = STEP_VENT; break;
					case uint32( CHAR_TEX_GRATE ): step = STEP_GRATE; break;
					case uint32( CHAR_TEX_TILE ): step = STEP_TILE; break;
					case uint32( CHAR_TEX_SLOSH ): step = STEP_SLOSH; break;
					case uint32( CHAR_TEX_WOOD ): step = STEP_WOOD; break;
					case uint32( CHAR_TEX_COMPUTER ): step = STEP_COMPUTER; break;
					case uint32( CHAR_TEX_GLASS ): step = STEP_GLASS; break;
					case uint32( CHAR_TEX_FLESH ): step = STEP_FLESH; break;
					case uint32( CHAR_TEX_SNOW ): step = STEP_SNOW; break;
					default: step = STEP_CONCRETE;
				}
				
				switch ( uint32( type ) )
				{
					case uint32( CHAR_TEX_CONCRETE ):
					{
						fvol = 0.5;
						next = g_Engine.time + 0.3;
						break;
					}
					case uint32( CHAR_TEX_METAL ):
					{
						fvol = 0.5;
						next = g_Engine.time + 0.3;
						break;
					}
					case uint32( CHAR_TEX_DIRT ):
					{
						fvol = 0.55;
						next = g_Engine.time + 0.3;
						break;
					}
					case uint32( CHAR_TEX_VENT ):
					{
						fvol = 0.7;
						next = g_Engine.time + 0.3;
						break;
					}
					case uint32( CHAR_TEX_GRATE ):
					{
						fvol = 0.5;
						next = g_Engine.time + 0.3;
						break;
					}
					case uint32( CHAR_TEX_TILE ):
					{
						fvol = 0.5;
						next = g_Engine.time + 0.3;
						break;
					}
					case uint32( CHAR_TEX_SLOSH ):
					{
						fvol = 0.5;
						next = g_Engine.time + 0.3;
						break;
					}
					// if you need it, add cases for the other texture types here, otherwise the default case below is used
					default:
					{
						fvol = 0.5;
						next = g_Engine.time + 0.3;
						break;
					}
				}
			}
			
			// play the sound
			int iSkipStep = pKVD.GetKeyvalue( "$i_skipstep" ).GetInteger();
			int foot = pKVD.GetKeyvalue( "$i_stepleft" ).GetInteger(); // treat as bool!
			
			// irand - 0,1 for right foot, 2,3 for left foot
			// used to alternate left and right foot
			int irand = Math.RandomLong( 0, 1 ) + ( foot * 2 );
			
			foot ^= 1;
			
			switch ( step )
			{
				case STEP_CONCRETE: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _ConcreteSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_METAL: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _MetalSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_DIRT: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _DirtSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_VENT: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _VentSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_GRATE: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _GrateSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_TILE: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _TileSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_SLOSH: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _SloshSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_WOOD: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _WoodSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_COMPUTER: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _ComputerSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_GLASS: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _GlassSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_FLESH: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _FleshSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_SNOW: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _SnowSounds[ irand ], fvol, ATTN_NORM ); break;
				case STEP_WADE:
				{
					if ( iSkipStep == 0 )
					{
						iSkipStep++;
						break;
					}
					
					if ( iSkipStep++ == 3 )
						iSkipStep = 0;
					
					g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _WadeSounds[ irand ], fvol, ATTN_NORM );
					break;
				}
				case STEP_LADDER: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _LadderSounds[ irand ], fvol, ATTN_NORM ); break;
				default: g_SoundSystem.EmitSound( pPlayer.edict(), CHAN_BODY, _ConcreteSounds[ irand ], fvol, ATTN_NORM );
			}
			
			pPlayer.KeyValue( "$f_timestep", string( next ) );
			pPlayer.KeyValue( "$i_skipstep", string( iSkipStep ) );
			pPlayer.KeyValue( "$i_stepleft", string( foot ) );
		}
	}
	
	return HOOK_CONTINUE;
}
