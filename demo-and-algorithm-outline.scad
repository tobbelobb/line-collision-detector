effectorPivots = [[ 220.0, -140.0, 130.0],
                  [-220.0, -140.0, 130.0],
                  [ 230.0, -130.0, 130.0],
                  [   5.0,  270.0, 130.0],
                  [  -5.0,  270.0, 130.0],
                  [-230.0, -130.0, 130.0]];

anchorPivots=[[  220.00, -1744.54,  15.92],
              [ -220.00, -1744.54,  15.92],
              [ 1542.51,  1140.88, -32.19],
              [ 1317.51,  1540.88, -32.19],
              [-1435.30,  1011.60, -31.23],
              [-1670.30,   611.63, -31.23]];

// A bounding box of big x big x big
// fully encloses the centered model
big = 10000;

//for (effectorPivot = effectorPivots)
//  translate(effectorPivot) color("red") sphere(30);
//for (anchorPivot = anchorPivots)
//  translate(anchorPivot) color("blue") sphere(30);


//translate([610, 0, 0]) color("yellow") cylinder(r=40, h=t);
//translate([610, 45, 0]) color("purple") cylinder(r=40, h=t + 130);


module twistVase() {
  linear_extrude(height=1000, twist=1.3*360)
    for (i = [0:360/5:359])
      rotate([0,0,i])
        translate([100, 0, 0]) circle(r=100);
}

module fourPoles() {
  width = 300;
  translate([width/2-2, width/2-2, 0]) cube([2,2,1000]);
  translate([-width/2, -width/2, 0]) cube([2,2,1000]);
  translate([-width/2, width/2-2, 0]) cube([2,2,1000]);
  translate([width/2-2, -width/2, 0]) cube([2,2,1000]);
}

//!benchy();
module benchy() {
  color("moccasin")
    scale(20)
      import("./linc/linc/test-models/benchy-low-poly.binary.stl", convexity=4);
}

module theModel() {
  //cylinder(d=600, h=1200);

  //side = 480;
  //translate([-side/2, -side/2, 0]) cube(side);

  //twistVase();

  //fourPoles();

  benchy();
}

module theModelPartial(h) {
  intersection()
  {
    theModel();
    color("lime", 0.30)
    translate([-big/2, -big/2, -big + h + 0.3]) cube(big);
  }
  // For some reason, the difference() method doesn't preview right
  //difference(){
  //  theModel();
  //  translate([-big/2, -big/2, h]) cube(big);
  //}
}

module volumeEnclosedByLineMovements(h) {
  mirror([0,1,0])
  for (i = [0:1:len(effectorPivots) - 1])
    hull() {
      translate(effectorPivots[i]) {
        // A slice of the model that is to be printed right now
        intersection()
        {
          translate([-big/2, -big/2, h]) cube([big, big, 1]);
          theModel();
        }
        //difference() {
        //  theModel();
        //  translate([-big/2, -big/2, t+2]) cube(big);
        //  translate([-big/2, -big/2, -big+t]) cube(big);
        //}
      }
      translate(anchorPivots[i]) cube(1, center=true);
    }
}

//$t = 1;
t = $t*980;
// rotate
$vpr = [80, 0, $t * 270 - 45];
// no rotate
//$vpr = [75, 0, 0];
$vpt = [0,0,410];
$vpd = 3000;

theSimulation();
module theSimulation() {
  difference(){
    theModelPartial(t);
    color("red") {
      intersection()
      {
        theModelPartial(t);
        volumeEnclosedByLineMovements(t);
      }
    }
    // Would be nice to show which parts were cut away
    // from previous layers like this, but unfortunately
    // this code crashes my Openscad 2018.04.19
    //for (k = [0:200:t])
    //{
    //  intersection()
    //  {
    //    theModelPartial(k);
    //    volumeEnclosedByLineMovements(k);
    //  }
    //}
  }
  color("yellow")
  scale(1.05)
    intersection()
    {
      theModelPartial(t);
      volumeEnclosedByLineMovements(t);
    }
  //theModelPartial(t);
  //color("deepskyblue", 0.2)
  //volumeEnclosedByLineMovements(t);
}

// To make a gif out of this, run in animation mode and dump pictures
// I'm sure that could be done on the command line, but hard to find
// good values for $vpr, $vpt, and $vpd via command line.
// Once you have the frames, create a pallette:
// $ ffmpeg -i frames/frame%05d.png -vf palettegen frames/palette.png
// Once you have frames and pallete, create gif:
// $ ffmpeg -v warning -framerate 200 -i frames/frame%05d.png -i frames/palette.png -lavfi "paletteuse,setpts=6*PTS" -y out.gif
