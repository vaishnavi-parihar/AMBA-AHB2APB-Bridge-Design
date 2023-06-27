# AMBA AHB to APB Bridge

AHB2APB bridge is an AHB slave that serves as an interface between the Advanced High-performance Bus (AHB) and the Advanced Peripheral Bus (APB) within the AMBA framework. It enables seamless communication and data transfer between high-speed AHB components and low-power peripherals by translating and converting various read and write bus transactions initiated by the AHB master into APB-compatible transactions, and vice versa.

**Tools Used:** Quartus Prime(for synthesis), ModelSim(for simulation)

## Simulation Results

### Single Write Transfer
![Screenshot (46)](https://github.com/vaishnavi-parihar/AMBA-AHB2APB-Bridge-Design/assets/75555001/a4602faf-56c5-4f0c-a77c-37df2890bad7)

### Single Read Transfer
![Screenshot (45)](https://github.com/vaishnavi-parihar/AMBA-AHB2APB-Bridge-Design/assets/75555001/f171c204-873b-44a8-9b99-9ca6e7113b78)

### Burst INCR4 Write Transfer
![Screenshot (47)](https://github.com/vaishnavi-parihar/AMBA-AHB2APB-Bridge-Design/assets/75555001/6f0c9253-fefb-4c81-a265-8c7827553c5b)

### Burst INCR4 Read Transfer
![Screenshot (49)](https://github.com/vaishnavi-parihar/AMBA-AHB2APB-Bridge-Design/assets/75555001/b4962cef-c867-45e3-acd3-bf66b4d371e5)


## Synthesis Result

![Screenshot (51)](https://github.com/vaishnavi-parihar/AMBA-AHB2APB-Bridge-Design/assets/75555001/2f022bec-8327-4523-8ecb-f8657b0b3de6) 

**Please note that only the Bridge module is synthesizable, the other modules are employed solely as testbenches for generating the essential read/write operations**



