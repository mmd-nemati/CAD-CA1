# Computer Aided Design CA 1
This repository contains the first project of the Computer Aided Desgin course at UT.
- We implemented a [Maxnet](https://studyglance.in/nn/display.php?tno=10&topic=Fixed-Weight-Competitive-Networks) neural network which has four nodes and tries to find the maximum number of the input, with a hardware approach in Verilog.

- You can see the Datapath and FSM Controller in this [report](https://github.com/mmd-nemati/CAD-CA1/blob/main/trunk/doc/CAD_HW1_P2_810100226_810100127.pdf).

- Also note that all floating point numbers and calculations follow the [IEEE-754 standard](https://en.wikipedia.org/wiki/IEEE_754).

___
#### To run and test it, you should use Modelsim simulator.
1. clone this repo.
```
$ git clone https://github.com/mmd-nemati/CAD-CA1.git
```
2. Go to the simulation directory inside Modelsim terminal.
```
$ cd ./CAD-CA1/trunk/sim
```
3. Run the testbench.
```
$ do sim_top.tcl
```
4. Now you can see the maximum input and other values in the waves.

   
> You can change the input data in **./trunk/sim/tb/mainTB.v** file. Make sure you enter numbers in IEEE-754 floating point format.
___
**Contributors:**

[Mobina Haghizadeh](https://github.com/mobinahz)

[Mohammad Nemati](https://github.com/mmd-nemati)
