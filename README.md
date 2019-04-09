# MPS-Quantitative-Evaluation
These codes could be employed for quantitative evaluation of MPS realizations.

The code is developed by Mohammad Javad Abdollahifard at Tafresh University (mj.abdollahi@tafreshu.ac.ir).

Programming Language: MATLAB.

Software Requirements: 
For the 2D version at first, the user MUST download and put the SIFT demo program on the MATLAB search path (http://www.cs.ubc.ca/~lowe/keypoints/siftDemoV4.zip). 
Then download and put the files of this repository on the path and use them as follows.
For the 3D version the user needs to download and install the 3D SIFT implementation from https://github.com/bbrister/SIFT3D/releases.

How to use the code:
for the 2D version:
>>[ci,cc,c]=mps_quantitative_evaluation(ti,Y);

where ti is the 2D Training Image and Y is a 3D matrix of size mxnxk containing k realizations of size mxn. 
ci, cc and c are kx1 vectors showing pattern innovation, consistency and overall evaluation factors. 

for the 3D version:
>>[ci,cc,c]=mps_quantitative_evaluation3d(ti,Y);

where ti is the 3D Training Image and Y is a 4D matrix of size lxmxnxk containing k realizations of size lxmxn. 
ci, cc and c are kx1 vectors showing pattern innovation, consistency and overall evaluation factors. 
