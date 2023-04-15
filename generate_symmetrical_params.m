# rotv requires octave linear-algebra package

desired_len_from_origin = str2double(argv(){1});

effector_pivot_A1 = [ 220.0, -140.0, 130.0];
effector_pivot_A2 = [-220.0, -140.0, 130.0];
effector_pivot_B1 = [ 230.0, -130.0, 130.0];
effector_pivot_B2 = [   5.0,  270.0, 130.0];
effector_pivot_C1 = [  -5.0,  270.0, 130.0];
effector_pivot_C2 = [-230.0, -130.0, 130.0];

printf("effector-pivot-A1: ( %.2f, %.2f, %.2f )\n", effector_pivot_A1(1), effector_pivot_A1(2), effector_pivot_A1(3));
printf("effector-pivot-A2: ( %.2f, %.2f, %.2f )\n", effector_pivot_A2(1), effector_pivot_A2(2), effector_pivot_A2(3));
printf("effector-pivot-B1: ( %.2f, %.2f, %.2f )\n", effector_pivot_B1(1), effector_pivot_B1(2), effector_pivot_B1(3));
printf("effector-pivot-B2: ( %.2f, %.2f, %.2f )\n", effector_pivot_B2(1), effector_pivot_B2(2), effector_pivot_B2(3));
printf("effector-pivot-C1: ( %.2f, %.2f, %.2f )\n", effector_pivot_C1(1), effector_pivot_C1(2), effector_pivot_C1(3));
printf("effector-pivot-C2: ( %.2f, %.2f, %.2f )\n", effector_pivot_C2(1), effector_pivot_C2(2), effector_pivot_C2(3));


# The anchor-pivot-points describe the positions of the anchor pivot
# points relative to the origin.

anchor_pivot_A1 = [  220.00, -desired_len_from_origin, -50.0];
anchor_pivot_A2 = [ -220.00, -desired_len_from_origin, -50.0];
# Completely symmetrical anchors
anchor_pivot_B1 = anchor_pivot_A1*rotv([0, 0, 1], 2*pi/3);
anchor_pivot_B2 = anchor_pivot_A2*rotv([0, 0, 1], 2*pi/3);
anchor_pivot_C1 = anchor_pivot_A1*rotv([0, 0, 1], 2*2*pi/3);
anchor_pivot_C2 = anchor_pivot_A2*rotv([0, 0, 1], 2*2*pi/3);

printf("anchor-pivot-A1: ( %.2f, %.2f, %.2f )\n", anchor_pivot_A1(1), anchor_pivot_A1(2), anchor_pivot_A1(3));
printf("anchor-pivot-A2: ( %.2f, %.2f, %.2f )\n", anchor_pivot_A2(1), anchor_pivot_A2(2), anchor_pivot_A2(3));
printf("anchor-pivot-B1: ( %.2f, %.2f, %.2f )\n", anchor_pivot_B1(1), anchor_pivot_B1(2), anchor_pivot_B1(3));
printf("anchor-pivot-B2: ( %.2f, %.2f, %.2f )\n", anchor_pivot_B2(1), anchor_pivot_B2(2), anchor_pivot_B2(3));
printf("anchor-pivot-C1: ( %.2f, %.2f, %.2f )\n", anchor_pivot_C1(1), anchor_pivot_C1(2), anchor_pivot_C1(3));
printf("anchor-pivot-C2: ( %.2f, %.2f, %.2f )\n", anchor_pivot_C2(1), anchor_pivot_C2(2), anchor_pivot_C2(3));
