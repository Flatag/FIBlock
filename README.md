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
| Package drop   | Fault value                   | Any number                  |
| Drift          | Fault value (slope)           | Any number                  |

- A brief description of each Fault Injection Event type is given below:

| **Fault Injection Method** |                                                                  **Description**                                                                  |                   **Accepted values**                  |
|:--------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------:|
| Failure Probability        | The fault is injected based on the constant failure probability specified in Mask Parameter Event value for each execution of the block function  | A decimal value between 0 and 1                        |
| Mean Time To Failure       | The fault is injected at the time step calculated by normal distribution over the mean time specified in Mask Parameter Event value               | Any whole number between 0 and simulation time         |
| Deterministic              | The fault is injected at specific time step provided in Mask Parameter Event value                                                                | Any whole number between 0 and maximum simulation time |
| Probability Distribution   | The fault is injected based on the probability distribution type specified in Mask Parameter Event value for each execution of the block function | Refer table below                                      |

- The various possibilities under Probability Distribution are listen below as follows:

| **Probability Distribution** |                                                                                                                      **Parameters**                                                                                                                      |                                                                                                                                                      **Significance**                                                                                                                                                      |                              **Range**                             |
|:----------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------:|
| Normal Distribution          | Mu (μ) : Mean Sigma (σ) : Variance                                                                                                                                                                                                                       | Determines where the distribution is centered and its variance.                                                                                                                                                                                                                                                            | Mu : Can be from -∞ to +∞ Sigma : Can be 0 to +∞                   |
| Weibull Distribution         | a (α) : Shape parameter b (β) : Scale parameter                                                                                                                                                                                                          | Shape parameter :  "α" < 1, decreasing error rate. P(failure) decreases over time. "α" = 1, Becomes Exponential Distribution. P(failure) remains constant. "α" > 1, increasing hazard rate. P(failure) increases over time.   Scale parameter :  Larger value of "β" corresponds to longer duration or time until failure. | Can be 0 to +∞                                                     |
| Gamma Distribution           | a (α) : Shape parameter b (β) : Scale parameter                                                                                                                                                                                                          | Shape parameter :  "α" is small, the distribution is more spread out and has a longer tail "α" is large, the distribution is more peaked and skewed curve.  Scale parameter :  "β" is large, concentrated distribution around the mean and shorter tails "β" is small, lead to a flatter, more spread-out distribution.    | Can be 0 to +∞                                                     |
| Exponential Distribution     | Mu (μ)                                                                                                                                                                                                                                                   | Rate Parameter. Determines average number of events per unit of time. As "μ" increases, the shape of exponential distribution becomes more concentrated around zero, and the curve of the distribution becomes steeper. The probability of observing events occurring at longer time intervals decreases.                  | Can be 0 to +∞                                                     |
| Poisson Distribution         | Lambda (λ)                                                                                                                                                                                                                                               | Rate Parameter. Determines average number of events per unit of time. As "λ" increases, the shape of the Poisson distribution shifts to the right. The distribution becomes more spread out. As "λ" becomes larger, the distribution becomes more continuous and approaches a normal distribution.                         | Can be 0 to +∞                                                     |
| Binomial Distribution        | N p                                                                                                                                                                                                                                                      | N : Number of independent trials p : Probability of success in each trial                                                                                                                                                                                                                                                  | N should be > 0 p should be between 0 and 1                        |
| Manual Distribution          | X-axis lower limit X-axis upper limit                                                                                                                                                                                                                    | Both limits describe in which area the user would like to plot points                                                                                                                                                                                                                                                      | Can be from -∞ to +∞                                               |
| 2-Weibull Mixed Distribution | a (α1) : Shape parameter for first Weibull b (β1) : Scale parameter for first Weibull c (α2) : Shape parameter for second Weibull d (β2) : Scale parameter for second Weibull p : probability of failure time coming from the first Weibull distribution | A combination of the two Weibull distributions is implemented using a "weight" p.                                                                                                                                                                                                                                          | Same as above for Weibull parameters. p should be between 0 and 1. |

- The various Fault Injection effects available are:

| **Fault Injection Effect Type** |                                                         **Description**                                                        |                                                                                                                                            **Accepted values**                                                                                                                                            |
|:-------------------------------:|:------------------------------------------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Once                            | Fault is injected only once during simulation                                                                                  | Not Applicable                                                                                                                                                                                                                                                                                            |
| Constant time                   | Fault stays for constant time period specified in Mask Parameter Effect Value after being injected                             | Any whole number between 0 and simulation time                                                                                                                                                                                                                                                            |
| Infinite time                   | Fault is injected until end of simulation after being injected                                                                 | Not Applicable                                                                                                                                                                                                                                                                                            |
| Mean Time To Repair             | Fault stays for a duration of time calculated by normally distributing over the mean specified in Mask Parameter Effect Value. | Rate Parameter. Determines average number of events per unit of time. As "μ" increases, the shape of exponential distribution becomes more concentrated around zero, and the curve of the distribution becomes steeper. The probability of observing events occurring at longer time intervals decreases. |
| Weibull Distribution            | A custom Weibull distribution regulates the time of the error effect.                                                          | Same as earlier specified                                                                                                                                                                                                                                                                                 |
| Gamma Distribution              | A custom Gamma distribution regulates the time of the error effect.                                                            | Same as earlier specified                                                                                                                                                                                                                                                                                 |
| Exponential Distribution        | A custom Exponential distribution regulates the time of the error effect.                                                      | Same as earlier specified                                                                                                                                                                                                                                                                                 |
| Poisson Distribution            | A custom Poisson distribution regulates the time of the error effect.                                                          | Same as earlier specified                                                                                                                                                                                                                                                                                 |
| Binomial Distribution           | A custom Binomial distribution regulates the time of the error effect.                                                         | Same as earlier specified                                                                                                                                                                                                                                                                                 |
| 2-Weibull Mixed Distribution    | A custom 2-Weibull Mixed distribution regulates the time of the error effect.                                                  | Same as earlier specified                                                                                                                                                                                                                                                                                 |



Each FIBlock has 4 scopes, where the following can be seen:

- Signal1 : Depicts the signal after fault injection
- errorflag1 : Depicts the error flag signal
- Ftype1 : Depicts the fault type used
- FInjectionPoints1 : Depicts at what time points the error was injected

## Steps to run GUI

- First open the "testFIB.slx" file. Double click the FIBlock to open the GUI.
- Give a number for the FIBlock instance, e.g., 1,2 and so on. This will be its name, so avoid giving the same number to cascaded blocks.
- Check the box for fault injection, if not checked already. This will enable fault injection for that particular block.
- Select a particular Fault type by clicking the Fault type dropdown. Some fault types require a value to be entered, and their description and value limits are mentioned in the above tables.
- Next select a Fault injection method by clicking the Fault injection method dropdown. For all methods other than Probability Distributions, enter a value based on the prompt and value limits above.
- For Probability Distributions, select a Probability Type from the dropdown. The different parameters for different distributions is described along with value limits above. In case values outside these limits are given, there will be an error in the command line, and the probability distribution cannot be viewed.
- To view the selected distribution based on the parameters entered, click the "View selected Probability Distribution" button. This will open a new window with the chosen distrbution according to the input parameters. Note that the button will not work for the "Manual Distribution" Probability Type.
- If Manual Distribution is selected, enter the lower and upper limit for the x-axis. Once all the other parameters is entered, "Apply" is pressed to save the parameter values, and the simulation is started, a new window will open where the user can click on an empty graph to enter required points. Once all the points have been entered, click out of the screen once. The curve generated by the manual distribution will be visible on the window and the simulation will run with the custom manual distribution as its basis. After the simulation is complete, close the window with the manual distribution before starting a new simulation.
- Finally select a Fault injection effect from the dropdown. Some effects require a value to be entered, and their description and value limits are mentioned above.
- After all the parameters have been entered and chosen, click "Apply".
- Set a Stop Time for the simulation, and then Run.
- While running the simulation, do not try to open the GUI as it will result in an error message. On closing this error message, the simulation will continue to run.

## Sample test cases and results

Some sample test cases and their corresponding results are depicted in this section, for reference.

1) Test 1:

- Fault type -> Noise =30 % 
- Fault injection method -> Mean Time To Failure = 2s
- Fault injection effect -> Mean Time to Repair = 0.3s
- Stop Time = 20 
  
 ![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/4dfc5c0a-dc0e-440f-9614-8d3747a41479)

Results:

The injection points correspond to the time of injection in the signal, alongwith a noise injection of 30% during the fault times.

- Scope of Signal1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/496c6b9f-58e1-4e3b-a976-cd8dee133ef9)

- Scope of errorflag1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/80d7a645-6eea-402b-8e6a-2a3c22f6fbbf)

- Scope of Ftype1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/612252a6-eb9d-4a04-9c11-0f5fc0e2803a)

- Scope of FinjectionPoints1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/c1226126-6578-42d9-b3ba-55862971603f)


2) Test 2:

- Fault type -> Stuck-at
- Fault injection method -> Deterministic = 2s
- Fault injection effect -> Constant time = 0.7s
- Stop Time = 20

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/93f3962e-793c-4bb7-80bd-f3abc98e86ad)

Results:

- Scope of Signal1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/2a6c5df7-673d-45b3-90cf-d8f4115ac156)

- Scope of errorflag1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/3ef44d74-7f19-46a7-a009-87bb49759eb5)

- Scope of Ftype1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/b8dd5923-4871-4292-885a-10c127ee4e49)

- Scope of FinjectionPoints1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/1e6ba29e-f5b0-4faa-b868-14c042e2f2dc)


3) Test 3:

- Fault type -> Bias/Offset
- Fault injection method -> Probability Distributions
- Probability Type -> Weibull Distribution, a = 2, b = 3
- Fault injection effect -> Mean Time To Repair = 0.3s
- Stop Time = 20

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/0b5d19b9-6a34-42e4-a943-aaeb6e95d501)

Results:

- On clicking the "View selected Probability Distribution" before running the simulation

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/d6dcb0ad-f4fa-4844-ac48-9c03fec0cba4)

- Scope of Signal1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/def0b298-14a8-4126-9f6c-7a33baa2320f)

- Scope of errorflag1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/9339bebd-0cf7-498e-8b15-146b4479e6d7)

- Scope of Ftype1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/9067db6b-00cd-4956-91b1-8749bb882a37)

- Scope of FinjectionPoints1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/89a2ccde-b3b4-44f7-8504-695dec83629d)


4) Test 4:

- Fault type -> Drift = 4
- Fault injection method -> Probability Distributions
- Probability Type -> Manual Distribution, x-axis lower limit = -2, x-axis upper limit = 5
- Fault injection effect -> Mean Time To Repair = 0.3s
- Stop Time = 20

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/f1d4e7a3-08bd-4df7-accf-013c4b6a11f5)

Results:

- Since Manual Distribution has been selected, the following window pops up once the simulation is set to run:

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/ebbc9d25-b92d-4439-ba80-fc6b2d3809b2)

- Points can then be plotted on this graph and when done, click outside so that a spline is generated. The captured co-ordinates, the random number generated from the spline as well as the threshold for each run are depicted in the Diagnostic Viewer.

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/36f9e6db-6142-4c82-a3a2-54ab8bbeaa6e)

- Scope of Signal1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/d7073e43-676d-4956-8ec9-5610e5ab0cb6)

- Scope of errorflag1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/e0cc27e0-b8c8-47ce-b3fd-e855ef170234)

- Scope of Ftype1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/f3cbfb2d-7c8c-4fea-97f6-078279c35e6b)

- Scope of FinjectionPoints1

![image](https://github.com/stephenphilipose/FIBlock/assets/53791862/29eb3f59-c614-4f30-ae7c-dd09697ead23)


## Conclusion:

The various parameters can be selected based on the desired application, system as per the user's requirements. The FIBlock can accomodate fault injection experiments efficiently and is highly customisable to the user's choice.

Made By Tagir Fabarisov, University of Stuttgart 2023

GNU General Public License v3.0
