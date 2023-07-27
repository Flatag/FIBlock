# FIBlock
Fault Injection Block for Simulink models
Please refer to a comprehensive article regarding the FIBLock: https://flatag.tech/fiblock.html
Please cite as: "Fabarisov, T. et al. "Model-based Fault Injection Experiments for the Safety Analysis of Exoskeleton System." Proceedings of the 30th European Safety and Reliability Conference and the 15th Probabilistic Safety Assessment and Management Conference, 2020."

This block allows to conduct a fault injection experiment (refer to help if needed).
Specify:
- name of the block instance.
- type of fault: Noise, Bias/Offset, Bit flips, Stuck-at, Time delay, Package drop, Drift.
- fault event: Failure probability, Mean Time to Failure, Deterministic, Probability Distributions.
- fault effect: Once, Constant time, Infinite time, Mean Time to Repair, Weibull Distribution, Gamma Distribution, Exponential Distribution, Poisson Distribution, Binomial Distribution, 2-Weibull Mixed Distribution.

In different FIBlock instances, the 'name' of the block in GUI must be different (must be an integer number).

This block allows to conduct a fault injection experiment.
Specify:
1) number of the block instance (e.i. 'name' of the fault injector, name shall be unique).

2) type of fault: 
- Noise : A random noise value is added. The Boundaries are defined as the percentage of the correct value.
- Bias/Offset : The defined positive or negative Bias value is added to the block output.
- Bit flips : The defined Number of bits are inverted in the binary representation of the correct value.
- Stuck-at : The block output stays constant, preserving the latest correct value before the error occurrence.
- Time delay : A delay is introduced into the signal. During the delay the value is zero.
- Package drop : The correct output is replaced by the specified Value, emulating a package drop.
- Drift : The sensor drift value is added. A linear equation with the defined slope is added onto the signal.

3) fault event: 
- Failure probability. Errors are injected based on the constant Failure probability for each execution of the block function.
- Mean Time to Failure. Errors are injected according to the specified MTTF. Normal distribution.
- Deterministic. Errors are injected at specific time step.

4) fault effect: 
- Once. An error appears only one time during a simulation.
- Constant time. The block produces erroneous output during the specified Time period.
- Infinite time. The block produces erroneous output until the end of the simulation.
- Mean Time to Repair. Normally distributed MTTR regulates the time of the error effect.

FIBlock also provide, what we call, a chained fault injection.
Second output of the FIBlock emits a trigger flag. 
This output signal could be connected to the second input of the FIBlock. 
In case of the fault injection, this signal will force trigger fault injection in the second FIBlock.

FIBlock supports for a base Workspace variables as input in the GUI parameters.

[![View Fault Injection Block (FIBlock) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/75539-fault-injection-block-fiblock)

## How to operate the FIBlock?

The FIBlock library is present in the FIBlock.slx file. This library has to be unlocked (by clicking the Locked Library button) in order to perform changes to the block. The inputs and outputs of the FIBlock are described below :

Attempt | #1 | #2 | #3 | #4 | #5 | #6 | #7 | #8 | #9 | #10 | #11
--- | --- | --- | --- |--- |--- |--- |--- |--- |--- |--- |---
Seconds | 301 | 283 | 290 | 286 | 289 | 285 | 287 | 287 | 272 | 276 | 269

Made By Tagir Fabarisov, TU Dresden 2020
GNU General Public License v3.0
