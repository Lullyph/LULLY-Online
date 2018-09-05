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

if(place_meeting_rounded(x,y + 150,obj_ropeswing) && self.up_held)
{
    x_speed=0;
    y_speed=0;
    //obj_PLAYER.x = obj_ropeswing.anchor_x + lengthdir_x(obj_ropeswing.distance, obj_ropeswing.angle);
    obj_PLAYER.x = obj_ropeswing.hsp + obj_ropeswing.anchor_x + lengthdir_x(obj_ropeswing.distance, obj_ropeswing.angle);
    //obj_PLAYER.y =
    //x=obj_ropeswing.x;
    //y= obj_ropeswing.y;
} else {
if(!self.up_held)
  state_switch("Air");
}



