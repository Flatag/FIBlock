# FIBlock
Fault Injection Block for Simulink models
Please refer to a comprehensive article regarding the FIBLock: https://flatag.tech/fiblock.html

This block allows to conduct a fault injection experiment (refer to help if needed).
Specify:
- name of the block instance.
- type of fault: Stuck-at, Package drop, Bias/Offset, Bit flips, Time delay, Noise.
- fault event: Failure probability, Mean Time to Failure, Failure Rate Distribution.
- fault effect: Once, Constant time, Infinite time, Mean Time to Repair.

Failure rate distribution is not supported yet!
Bit flips, Time delay, and Noise faults may have some bugs :D
In different FIBlock instances, the 'name' of the block in GUI must be different (must be an integer number).

This block allows to conduct a fault injection experiment.
Specify:
1) number of the block instance (e.i. 'name' of the fault injector, name shall be unique).

2) type of fault: 
- Stuck-at. The block output stays constant, preserving the latest correct value before the error occurrence.
- Package drop. The correct output is replaced by the specified Value, emulating a package drop.
- Bias/Offset . The defined positive or negative Bias value is added to the block output.
- Noise. A random noise value is added. The Boundaries are defined as the percentage of the correct value.
- Time delay. A delay is introduced into the signal. During the delay the value is zero.
- Bit flips. The defined Number of bits are inverted in the binary representation of the correct value.

3) fault event: 
- Failure probability. Errors are injected based on the constant Failure probability for each execution of the block function.
- Mean Time to Failure. Errors are injected according to the specified MTTF. Normal distribution.

4) fault effect: 
- Once. An error appears only one time during a simulation.
- Constant time. The block produces erroneous output during the specified Time period.
- Infinite time. The block produces erroneous output until the end of the simulation.
- Mean Time to Repair. Normally distributed MTTR regulates the time of the error effect.

FIBlock also provide, what we call, a chained fault injection.
Second output of the FIBlock emits a trigger flag. 
This output signal could be connected to the second input of the FIBlock. 
In case of the fault injection, this signal will force trigger fault injectionin second FIBlock.

Made By Tagir Fabarisov, TU Dresden 2020
GNU General Public License v3.0
