TA Manual for the UCSB ECE Controls Lab
===========================================


This document guides Teaching Assistants in setting up the Quanser inverted pendulum hardware in Harold Frank Hall 3120A that we use in the controls classes (ECE 147) in the Electrical and Computer Engineering department at the University of California, Santa Barbara. 

![A Quanser pendulum setup in Harold Frank Hall 3120A](Images/IMG_6727.JPG)

By Justin Pearson, Jan 2017

*This lab manual is dedicated to the legions of Graduate Students who struggled to set up this hardware the day before their first lab.*

*It is also dedicated to Paul Gritt, Avery Juan, and Raul Ramirez for diligently and patiently maintaining these labs against the destructive force of countless students over the years.*

This file lives at

- <https://github.com/justinpearson/UCSB-Quanser-Inverted-Pendulum-Lab-Manual.git>

and also

- <http://ece.ucsb.edu/~jppearson/ECE147C/Lab0/Lab0_ForStudents.tar.gz>

If you improve it, please send me a GitHub pull request so we can help future generations of TAs. Thanks.

Instructions
----------------

1. Set up the hardware as described in the document `hardware_setup.odg` / `pdf`. In the process, you will run the Matlab Simulink files:

- `read_sensors.mdl` (reads motor-cart & springy-cart angle sensors)
- `read_sensors_and_run_motor.mdl` (same, but also writes voltage to motor)

The mdl file `read_sensors_and_run_motor.mdl` runs for 10 seconds. It sends a 1-Hz sinusoidal voltage to the motor and records the encoders of the motor-cart and springy-cart. Upon completion, the simulation dumps the sensor data into the Matlab workspace.

2. In Matlab R2011b, run the Matlab script `do_correlation_method.m`. You will need to edit the script a bit to reflect your own data. This script uses the "correlation method" (taught in the first week of ECE147C) to find the magnitude and phase of the "motor voltage to encoder angle" transfer function evaluated at the frequency that you 1-Hz.

3. Compare your result with the results in `do_correlation_method/do_correlation_method.html`, which shows an example run when I did it. The html file was made by using Matlab to "publish" the Matlab script `do_correlation_method.m`.


Building the PDF of this documentation (Mac)
---------------------------------------------

See `make-lab-manual.sh`.