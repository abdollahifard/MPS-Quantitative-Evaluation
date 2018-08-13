# MPS-Quantitative-Evaluation
These codes could be employed for quantitative evaluation of MPS realizations.

The code is developed by Mohammad Javad Abdollahifard at Tafresh University (mj.abdollahi@tafreshu.ac.ir).

Programming Language: MATLAB.

Software Requirements: At first, the user MUST download and put the SIFT demo program on the MATLAB search path (http://www.cs.ubc.ca/~lowe/keypoints/siftDemoV4.zip). 

Then you can easily run our code as follows:

>>[ci,cc,c]=mps_quantitative_evaluation(ti,Y);

where ti is the 2D Training Image and Y is a 3D matrix of size mxnxk containing k realizations of size mxn. 
ci, cc and c are nx1 vectors showing pattern innovation, consistency and overall evaluation factors. 
