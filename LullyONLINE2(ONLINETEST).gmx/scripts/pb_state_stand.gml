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

if((self.left_held && !place_meeting_rounded(x-1,y,obj_wall))|| 
   (self.right_held && !place_meeting_rounded(x+1,y,obj_wall)))
{
    state_switch("Walk");
}

if(self.jump_pressed)
{
    state_switch("Air");
    y_speed-=jump_strength;
}

///Check for no ground.
if(!position_meeting_rounded(x,y+1,obj_ramp) && !place_meeting_rounded(x,y+1,obj_wall) && !place_meeting_rounded(x,y+1,PAR_Platform))
{
    state_switch("Air");
}





///////////////////////////////////////////////////
//LULLY STUFFS NEW////////////////////////////////
//////////////////////////////////////////////////


//LADDER state switch climb UP
if(self.up_held && place_meeting_rounded(x,y,par_LADDER))
{
    state_switch("Ladder");
}

//LADDER state switch climb DOWN
if(self.down_held && place_meeting_rounded(x,y+16,par_LADDER))
{
    x=par_LADDER.x+16;
    y += 1;
    state_switch("Ladder");
}


//PLATFORMS


//To NOT get stuck in platform
if((!place_meeting_rounded(x,y+1,obj_wall) && !position_meeting_rounded(x,y+1,obj_ramp)) && !place_meeting_rounded(x,y+5,PAR_Platform))
{
    state_switch("PlatformFall");
}

