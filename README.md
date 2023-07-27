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
- Mean Time to Failure. Errors are injected according to the specified MTTF Normal distribution.
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

## FIBlock Properties

The FIBlock library is present in the "FIBlock.slx" file. This library has to be unlocked (by clicking the Locked Library button) in order to perform changes to the block. 

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/329e5351-c46c-4f97-a6fd-2c63cf4d8d89)

The inputs and outputs of the FIBlock are described below :

|     **Port**     |                                     **Description**                                     |
|:----------------:|:---------------------------------------------------------------------------------------:|
| Idata            | Input signal to which fault has to be injected                                          |
| Iflag            | For consecutive error blocks. Fflag output from previous FIBlock is to be used as input |
| Fdata            | Invalid data signal after fault is injected as per user requirement                     |
| Fflag            | The error flag signal                                                                   |
| Ftype            | Shows the FaultType. Displayed as an enum                                               |
| FInjectionPoints | Shows at what time points the error has been injected                                   |

- To see the implementation of the complete block : Right click the FIBlock -> Mask -> Look Under Mask. 

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/d41c258a-b3d9-4f0b-abba-11dd4dd1072f)

- To see the implementation of the complete block : Right click the FIBlock -> Mask -> Edit Mask.
  Here, the various parameters, GUI, initial code for starting the FIBlock, icon behind the FIBlock can be modified. The initial code contains the user input values retrieved as an object.

## GUI and testing the FIBlock

To test the FIBlock, open the "testFIB.slx" file. 

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/732bfec1-7b21-4640-b1c0-b22172b458a4)

It contains two FIBlocks in cascade. On double clicking the first FIBlock, the GUI will open. The GUI makes it possible for the user to set the block paramters. The fault type, the fault value, the fault injection method, event value and the fault injection effect and the effect value can be modified using this GUI.

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/b7e1c5c6-b214-4f7b-be8a-38bbcd230101)

- The parameters prompted and the accepted values for each Fault Type are given below:

| **Fault Type** |  **Mask Parameter Prompted**  |     **Accepted values**     |
|:--------------:|:-----------------------------:|:---------------------------:|
| Noise          | Fault value (boundaries, %)   | Any number between 1 to 100 |
| Bias/Offset    | Fault value (bias)            | Any integer number          |
| Bit flips      | Fault value (number of bits)  | Any natural number          |
| Stuck-at       | No Mask Parameter is prompted | Not Applicable (NA)         |
| Time delay     | No Mask Parameter is prompted | NA                          |
| Drift          | Fault value (slope)           | Any number                  |





















Made By Tagir Fabarisov, TU Dresden 2020
GNU General Public License v3.0
