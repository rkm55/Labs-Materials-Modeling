# Quantum Mechanics (First Principles) Lab 1 - Shooting method to determine wave functions


In this lab, we will use a shooting method to examine the energies and wave functions for a particle in a (1D) box. This assignment is derived from Nicolas Giordano's *Computational Physics* textbook (Prentice Hall, 1997). Some of this assignment will take place on MATLAB Grader and the remainder can be carried out in MATLAB on your computer. You will submit a PDF document with the information listed below to LS. The Learner Templates are available in the GITHUB repository.

*Note: The analytical solution to this problem is described [here](https://chem.libretexts.org/Bookshelves/Physical_and_Theoretical_Chemistry_Textbook_Maps/Supplemental_Modules_(Physical_and_Theoretical_Chemistry)/Quantum_Mechanics/05.5%3A_Particle_in_Boxes/Particle_in_a_1-Dimensional_box).

1.	(10 pts) Determine and code the potential for a 1D particle in a box.
    * Complete this problem on MATLAB Grader.
    * **In the LS PDF, include a statement indicating what fraction of the tests you were able to complete on MATLAB Grader in the allowed attempts for credit.**

2.	(10 pts) Determine and code the initial conditions for an even and odd wave function for a 1D particle in a box.
    * Complete this problem on MATLAB Grader.
    * **In the LS PDF, include a statement indicating what fraction of the tests you were able to complete on MATLAB Grader in the allowed attempts for credit.**

3.	(10 pts) Determine and code a method to normalize a wave function and return the normalized wave function and its probability density.
    * Complete this problem on MATLAB Grader.
    * **In the LS PDF, include a statement indicating what fraction of the tests you were able to complete on MATLAB Grader in the allowed attempts for credit.**

  *Before continuing I highly recommend playing with the test_shooting.m function in MATLAB on your own computer. It will make the next problem easier.*

4.	(10 pts) Determine and code a routine to determine the energy levels and wave functions for both odd or even wave functions for a 1D particle in a box. This problem will require the functions you created in the previous problems.
    * Complete this problem on MATLAB Grader.
    * **In the LS PDF, include a statement indicating what fraction of the tests you were able to complete on MATLAB Grader in the allowed attempts for credit.**

**Use the code developed for problems 1-4 to do the following. Place all the graphs and discussion in a single PDF file that will be uploaded to Learning Suite.**  *Note: Make sure your graphs cover the whole domain. The graphing function displayPsi may be useful in knowing how to plot both even and odd over the whole domain.*

5.	(5 pts) Make plots of the first 3 wave functions superimposed on the same graph. Make one plot each for the even and odd solutions. Comment on what you see and what it means.

6.	(5 pts) The probability of finding the particle at any position can be found by calculating the probability density, |psi|^2. Make plots of the first 3 probability densities superimposed on the same graph. Make one plot each for the even and odd solutions. Comment on the likely location of each particle depending upon its energy.

7.	(5 pts) Comment on the discrete solutions you have discovered and why the unconverged wave functions at different energies are not allowed. *Note: The unconverged wave functions can be seen by plotting the convergence process; this can be accomplished by setting showplot to true in either the findfirstNsolutions function or the shooting function.*

8.	(5 pts) Determine how the well-depth (in the range of 1e5 to 1e-1) influences the first two allowed energy levels for both even and odd wave functions; make a plot of the result. One of the interesting aspects of quantum mechanics is the fact that only certain solutions are allowed. This is evident in the first three even and odd solutions you found. The allowed wave vectors (*k*) for the infinite well for the even and odd solutions are given by <img src="https://render.githubusercontent.com/render/math?math=k_{+}=\frac{(2n-1)\pi}{2L}"> and <img src="https://render.githubusercontent.com/render/math?math=k_{-}=\frac{2n\pi}{L}">. These lead to discrete energy levels that can be calculated as <img src="https://render.githubusercontent.com/render/math?math=E=\frac{\hbar^2 k^2}{2m}">. For this case assume <img src="https://render.githubusercontent.com/render/math?math=\hbar=1"> and *m*=1. Compare your energy values for the three first energy levels. Compare the energy values measured as a function of well-depth with expectations of energies for an infinite well (from the equations provided here) and comment on what you observe and on why the energy values might change as the well-depth is decreased.

9.  (5 pts) Make a plot of the probabilities for the first two energy levels (one on each plot) of the even function for several different well depths. Comment on your observations. Also comment on whether you observe any non-zero probability densities outside the box or well and how these are affected by well-depth; how might this relate to [tunneling](https://en.wikipedia.org/wiki/Quantum_tunnelling) or phenomena of this nature? Also comment on why the probability density for the second energy eventually goes to zero outside the well even though the second energy is greater than the well-depth for the lost values of sampled well-depths.
