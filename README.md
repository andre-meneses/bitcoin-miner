# RTL Design for a bitcoin miner

## Introduction
This project was developed as part of a digital circuits class with the goal of designing a register-transfer level implementation for an application of our choice. Given the popularity of cryptocurrencies, we decided to design our own Bitcoin miner as an interesting and challenging project.
## Bitcoin
Bitcoin transactions are validated through computational work. To validate a block, its header must be hashed by a SHA-256 function and compared to a target value. If the comparison succeeds, a 4-byte portion of the header called the "nonce" is returned. If it fails, the nonce is updated and the process is repeated.  
## Design Considerations
Our first step was to decide what tasks our circuit should perform. To mine Bitcoins, an 80-byte (640-bit) block must be hashed using the SHA-256 function, which processes 512-bit blocks at a time. Two blocks must be hashed, with the first block's hash remaining constant and the second block's hash changing after each nonce update. Therefore, we designed our circuit to only perform the hash of the second block, allowing for a simpler design while still performing most of the computational work required for mining.

Our design process involved the following steps:

1. Creation of a high-level state machine
2. Definition of the datapath
3. Creation of a finite-state machine
4. Controller design 
5. VHDL implementation
6. Controller simulation

## High level state machine
We began by modeling the miner with a high-level state machine. The circuit receives the second block message (m1), the target, and the hashed first block (m0) as inputs. Two hash transforms are performed, as required by the Bitcoin protocol, and the resulting hash is compared to the target. If the hash is less than the target, the transaction block is validated and the process is complete. Otherwise, the nonce is updated and another iteration is needed.  

<img src="./figures/hlsm.png" style="width: 55vw; min-width: 330px;"/>

## Datapath
The high-level state machine was used to design an appropriate datapath. The hash computations are performed by two 'digest' modules that receive inputs controlled by multiplexers. Two sets of 16 32-bit registers store the 512 bits blocks and two sets of 8 32-bit registers (reg_init_0 and reg_init_1) store the initial hash variables. The registers 'Reg_hash' store the hashed messages.

To keep track of the sha-256 current iteration, a 64-bit counter is used. The scheduling process is handled by the 'cmp_16' comparator, while the 'cmp_target' comparator validates the produced hash. An adder with a 32-bit output is used for the nonce update. A ROM stores the constants required by the digest module.

Understanding the proposed datapath requires knowledge of how the sha-256 computation works. The operation of the 'digest' module has been abstracted.

<img src="./figures/digest.png" style="width: 55vw; min-width: 330px; "/>

## Finite-state machine
After the datapath definition, we must transform the high-level state machine to a finite-state machine. Each transform stage has been expanded into 4 states and the final fsm has 12 states. 

State 1. Initiate variables

State 2. Initiate first hash

States 3 - 5. Perform first hash 

State 6. Initiate second hash

States 7 - 9. Perform second hash

State 10. Compare hash with target 

State 11. Update nonce

State 12. Hash found

<img src="./figures/fsm.png" style="width: 55vw; min-width: 330px; "/>

## Controller Design

After coding the finite-state machine, we proceeded to assemble a truth table based on the defined states. From this truth table, we extracted a logical equation for each one of the 20 outputs, and then projected the combinational circuit of our controller. This allowed us to create a detailed design for our controller, which would be responsible for managing the datapath and coordinating the various stages of the sha-256 computation.
<p align='center'> 
<img src="./figures/combinacional.png" style="height: 30vw; min-height: 100px; "/>
</p>

Since there are 12 states, a 4 bit register was used as a state register. 

<img src="./figures/controlador.png" style="height: 30vw; min-height: 100px; "/>

The controller was simulated in Quartus II software and the it works as expected. 

## Conclusions and remarks
Designing an RTL (register-transfer level) implementation of a Bitcoin miner proved to be a challenging project. In particular, understanding the SHA-256 function and implementing it in hardware was a difficult task. We also faced design decisions, such as whether to prioritize ease of implementation or efficiency. Ultimately, we discovered that the simplest solution is not always the fastest in terms of clock cycles.

Currently, the datapath component of our Bitcoin miner is yet to be implemented and simulated. However, we are proud to report that the proposed design computes both hashes required for Bitcoin validation in just 129 clock cycles. Considering the typical clock frequency of an FPGA, our circuit could potentially perform in the order of Megahashes per second. While this may not be lucrative, the process of designing and building the miner was an enjoyable and rewarding experience  
