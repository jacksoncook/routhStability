# routhStability

The file to execute in this repository is routhStability.m
A helper file prevLine.m is included to check the previous line for certain edge cases

The purpose of this is to determine whether or not a characteristic equation is stable and if it is unstable, how many unstable roots it has.
- The way to execute this is to first launch your own copy of Matlab
- Open the folder you have downloaded from here in Matlab
- In the "Command Window", enter [table, stability] = routhStability(coeffs)
- "coeffs" is the input vector representing the coefficients of the polynomial you are interested in eg. the roots for 3s^2 + 6s + 7 would be a vector [3, 6, 7]
- "table" will give you the Routh's Stability Table
- "stability" will print a message telling you whether the characteristic equation is stable, marginally stable, or unstable with the number of roots

Please enjoy this code!
