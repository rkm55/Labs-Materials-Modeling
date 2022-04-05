## FEA-Lab-Calculations

See the assignment on <https://grader.mathworks.com> and complete the following parts and upload the relevant details in a PDF to be submitted to Learning Suite.
The Learner Templates from Matlab Grader are also available in this folder of the GITHUB repository.

Useful reading is contained in `FEA-Bhatti-share.pdf` - available in this folder.

In this lab, you will derive equations and code for analytical and FEA solutions to 1D deflection problems. Most of this assignment will take place on MATLAB Grader and the last problem can be carried out in MATLAB on your computer and will require you to upload a graph and discussion in a PDF to Learning Suite. 

**Complete these on Matlab Grader and then in the LS PDF to be submitted, for each problem, indicate whether your code passed all the Matlab Grader tests in the allowed submissions.**

1.	(10 pts) Exact solution to axial deformation of a uniform bar
2.	(10 pts) Exact solution to the following axial deformation of a non-uniform bar 
3.	(10 pts) Linear approximation solution to axial deformation of a uniform bar
4.	(30 pts) FEA solution to axial deformation of a uniform bar 

    i.	(10 pts) construct stiffness matrix

    ii. (10 pts) construct load vector

    iii. (10 pts) nodal solution

Use the code developed for problems 1,3,4 to do the following.

5.	(10 pts) Write a script to compare the solutions to problems 1, 3, and 4. Your script should produce 3 different figures, one to compare the displacement, one to compare the stress, and one to compare the strain. **Add the 3 figures to the LS PDF and include a discussion of the similarities and differences between the various solutions.**
  
    i.  To keep this from getting overly complicated, I recommend generating solutions for problem 1 and 3 using something like x=linspace(0,0.55,20) and then for problem 4, import the 5 node solution and plot them together. 
  
    ii.  Don't forget that the nodal stress and strain are piece-wise; plot them accordingly.
  
    iii.  Also, don't forget to use a legend and line types, colors, or other features to readily distinguish between the various curves.
 
