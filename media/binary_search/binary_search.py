# This script was run on local machine with
# $ python3 plotit.py
# Not in the Docker enviroment

from matplotlib import pyplot as plt
import numpy as np

plt.figure()
# heights gotten by grepping linc.log after a successful run
# # cd /line-collision-detector/linc
# # rm linc.log
# # run linc/test-models/broken/3DBenchy_scale15.binary.stl linc/params-example
# # grep "Soft clipping at" linc.log
h = [384.0, 576.0, 768.0, 192.0, 672.0, 96.0, 288.0, 480.0, 720.0, 144.0, 336.0, 528.0, 48.0, 624.0, 240.0, 432.0, 168.0, 744.0, 360.0, 552.0, 120.0, 696.0, 312.0, 72.0, 504.0, 24.0, 648.0, 264.0, 456.0, 180.0, 216.0, 600.0, 156.0, 372.0, 756.0, 132.0, 348.0, 108.0]
intervals=[0.0, 768.0/4.0, 768.0/2.0, 3.0*768.0/4.0, 768.0]
foundit = [408]
#plt.vlines(1,0,768, lw=2)  # Draw a vertical line
plt.text(1.35,0,'0', verticalalignment='center');
plt.text(1.35,768,'h', verticalalignment='center');
plt.text(1.35,768/4,'h/4', verticalalignment='center');
plt.text(1.35,768/2,'h/2', verticalalignment='center');
plt.text(1.35,3*(768/4),'3h/4', verticalalignment='center');
plt.eventplot(intervals, orientation='vertical', colors=[0.9, 0.1, 0.1], linelengths=0.65, lw=0.5)
plt.eventplot(h, orientation='vertical', colors='b', linelengths=0.6, lw=0.8)
plt.eventplot(foundit, orientation='vertical', colors='g', linelengths=0.6, lw=1.2)
plt.axis('off')
#plt.show()
plt.savefig('3DBenchy_scale16_progress.png');

