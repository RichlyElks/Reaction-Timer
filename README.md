# Reaction-Timer

Synthesized a game which measured the user's reaction time in Verilog on an FPGA.

Hardware: Terasic DE10-Lite

Software: Quartus Prime Lite Edition 17.1.0

### Overview

The objective of this project is to design a circuit which measures the reaction time of a user who must turn off an LED, which lights up after a random amount of time, by pressing a designated button. The user begins the random delay with an initial press of the button after which the counter begins and displays on the seven-segment hexadecimal displays. After the player presses the button to turn off the LED, the counter stops and the circuit is in the ‘Finished’ state. The user also has access to a reset button to return them to the initial state, and a high score mode.

<p align="center">
  <img src="https://github.com/RichlyElks/Reaction-Timer/blob/master/diagram_state.jpg">
</p>

For this project, a Finite State Machine (FSM) is a critical component. There are many states in which their inputs and outputs behave differently than the other states, and a FSM manages these transitions. Before building the state machine, I outlined the necessary states, state variables and transitions. My design is almost entirely a Moore state machine, however, the ‘Start’ state behaves more similar to a Mealy state machine. The the FSM’s output, the LED and seven-segment displays, depend on the current input as well as the current state in the ‘Start’ state. It has two phases: the first is the random delay which displays nothing across the LED and seven-segment displays until the delay submodule signals the random delay has finished counting down, at which point the LED lights up and the counter begins and is shown on the seven-segment displays. 

In the ‘Finished’ state, the time at which point the LED is turned off is displayed. Pressing KEY0 returns them to the ‘Idle’ state. From the idle state, the current high score can be viewed by setting the first switch, SW0, high and then pressing KEY0. To return to the ‘Idle’ state, the switch is returned to low and KEY0 is pressed. At any point, the user can return to the initial idle state by pressing the  Reset button, KEY1.
	
<p align="center">
  <img src="https://github.com/RichlyElks/Reaction-Timer/blob/master/diagram_block.jpg">
</p>

In order to coordinate the various, smaller modules which comprise the entire system, creating a block diagram of the anticipated final circuit was essential in developing a cohesive design. For my implementation, the FSM manages all of the inputs/outputs and initializes/resets the submodules depending on the current state. From the diagram, it is clear that the delay “loop” is built from the linear-feedback shift register (LFSR). Those submodules create the random delay and the delay_finished output signals to the FSM that it can transition into the second phase of its ‘Start’ state in which the circuit turns on the LED, accepts input from KEY0 and the seven-segment displays show  the current count based on the values from the BCD_counter submodule. After the player reacts to the LED lighting up, the counter stops and the final time is displayed on the board until the player returns to the initial state. 

Pressing the button one more time will return the player to the  and will display the time, and can return to the initial idle state at any point by pressing the other, Reset, button. The finish state will display the time at which point the LED is turned off. From the idle state, the current high score can be viewed with the first switch.

### Results

<p align="center">
  <img src="https://github.com/RichlyElks/Reaction-Timer/blob/master/histogram_delay.png">
</p>

The random values plotted from a sample size of n = 40. They are two-digit hexadecimal values. The first is the value given from the linear-feedback shift register, and the second one is the binary complement of it. These values are then put into the eight most significant bits of a 12-bit value, which is then fed into the delay submodule where the total value is decremented by one every millisecond.

<p align="center">
	<a href="https://www.youtube.com/watch?v=B9TirOliNBM" target="_blank">
	<img src="http://img.youtube.com/vi/B9TirOliNBM/0.jpg" alt="Reaction Timer Video" width="240" height="180" border="10" /></a>
</p>

Here are the results of subjecting my co-workers to a reaction time competition:

| Name      | Time (s) |
| --------- | --------:|
| Dani:		  | 0.251    |
| Randall:  | 0.268    |
| Cam:		  | 0.282    |
| Reese:	  | 0.301    |
| August:	  | 0.321    |
| James:		| 0.330    |
| Joe:		  | 0.338    |
| Sophie:		| 0.342    |

### Conclusion

This project challenged my knowledge of implementing digital logic in Verilog. It is always a challenge to think in terms of physical components and digital logic, as opposed to trying to code as if it were a standard programming language, and this project tested my ability to stay in that mindset. The most successful way to combat poor coding habits was by reimplementing different design through diagrams and flow charts before writing any code. This allowed me to briefly think through the entire design and revise any unforseen issues. When translating the diagrams and flow charts into code, the process was always quicker if I implemented smaller pieces of the code to test rather than write a large block of code and squandering time on debugging. 
	
The most difficult part of the implementation was designing a state machine which incorporated the delay. I tried a few different approaches, including using a separate ‘Delay’ state, but was able to build the circuit without the additional state by having the delay submodule output a ‘finished’ variable to the state machine. 

This is absolutely one of the more challenging projects I have worked on, but I really appreciated the opportunity to push my knowledge of digital design further than I imagined and I am proud of my final implementation.
