///pb_state_stand()
//The Standing State for Platform Girl
if(state_new)
{
    x_speed=0;
    y_speed=0;
    image_speed=0;
    sprite_index=spr_ketty_walk;
    image_index=0;
}

if((self.left_held && !place_meeting_rounded(x-1,y,PAR_Wall))|| 
   (self.right_held && !place_meeting_rounded(x+1,y,PAR_Wall)))
{
    state_switch("Walk");
}

if(self.jump_pressed)
{
    state_switch("Air");
    y_speed-=jump_strength;
}

///Check for no ground.
if(!position_meeting_rounded(x,y+1,obj_ramp) && !place_meeting_rounded(x,y+1,PAR_Wall) && !place_meeting_rounded(x,y+1,PAR_Platform))
{
    state_switch("Air");
}





///////////////////////////////////////////////////
//LULLY STUFFS NEW////////////////////////////////
//////////////////////////////////////////////////


///LADDERS///

//LADDER state switch climb UP
if(self.up_held && place_meeting_rounded(x,y,par_LADDER))
{
    state_switch("Ladder");
}

//LADDER state switch climb DOWN
if(self.down_held && place_meeting_rounded(x,y+16,par_LADDER))
{
    self.x=par_LADDER.x+16;
    y += 1;
    state_switch("Ladder");
}


///PLATFORMS///

//To NOT get stuck in platform
if((!place_meeting_rounded(x,y+1,PAR_Wall) && !position_meeting_rounded(x,y+1,obj_ramp)) && !place_meeting_rounded(x,y+5,PAR_Platform))
{
    state_switch("PlatformFall");
}

//STAIR stuck in platform fix
if(place_meeting_rounded(x,y-1,PAR_Platform))
{
    state_switch("PlatformFall");
}


///STAIRS///

//Stair Right and Left TOP

if((self.down_held && self.left_held) && place_meeting_rounded(x,y,obj_stairTOPR))
{
    state_switch("StairR");
}

if((self.down_held && self.right_held) && place_meeting_rounded(x,y,obj_stairTOPL))
{
    state_switch("StairL");
}

//Stair Right and Left BOT

if((self.up_held && self.right_held) && place_meeting_rounded(x,y,obj_stairBOTR))
{
    state_switch("StairR");
}

if((self.up_held && self.left_held) && place_meeting_rounded(x,y,obj_stairBOTL))
{
    state_switch("StairL");
}

