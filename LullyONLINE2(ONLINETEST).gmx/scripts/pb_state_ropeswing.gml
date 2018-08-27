///pb_state_ropeswing()
//The Rope Swing State for Platform Girl

if(state_new)
{
    x_speed=0;
    y_speed=0;
    image_speed=0;
    sprite_index=spr_ketty_climb;
    image_index=0;
}



///////////////////////////////////////////////////
//LULLY STUFFS NEW////////////////////////////////
//////////////////////////////////////////////////



//PLATFORMS


//SWINGING ROPE

if(place_meeting_rounded(x,y,obj_ropeswing) )
{
    x_speed=0;
    y_speed=0;
    x=obj_ropeswing.x;
    //y= obj_ropeswing.y;
//} else {
  //  state_switch("Air");
}



