# ISA-QAP
Instance space analysis of the Quadratic Assignment Problem

Cloning this parent repository is not strictly required to run the submodules. However, most of them will need the "Utilities" folder.

If you do clone this repository:

Step 1 - Get whatever submodules you need.

InstanceGeneration and Features are dependent on the Utilities folder.
Algorithms will compile on its own but to do anything useful with it you will require some QAP instance data files like those in the Instances folder.

Step 2 - Run configure.bat (on Windows) to set up the config files automatically. (TODO: configure.bash for Linux.)

The contents of the ISA and Algorithms submodules is largely not my work, and is reproduced/forked here in accordance with their respective licences. See their respective READMEs for authorship and licencing details.

Dependencies:

MATLAB. In particular for the ISA code itself a relatively recent version may be required. Some MATLAB modules are also required, but you should be able to identify these by running the code and seeing what doesn't work.

A C++ compiler. The algorithm code is straight C++. The feature measurement code compiles and then calls a C++ library through MATLAB so you will need to have this hooked up properly.