This MATLAB program compares two temperature signals: the predicted and the measured signals.

The prediction is based on a highly complex state space model where the system matrix dimension is 27x27, featuring $10$ inputs and $4$ outputs.

Here is the theoretical equation of a state space model:

$$\dot{x}(t) = Ax(t) + Bu(t)$$$$y(t) = Cx(t) + Du(t)$$

Where:

  $$\dot{x}(t)$$ is the next values of the states
  
  A is the system matrix
  
  x(t) state vector
  
  B is the input matrix
  
  u(t) is the input vector
  
  y(t) is the output vector
  
  C is the output matrix
  
  D direct transmission matrix


  My state-space model simulates the heat transfer system of a house using thermal resistors, thermal capacitors, and heat sources:

  
<img width="970" height="1292" alt="house+thermic modelling" src="https://github.com/user-attachments/assets/20b610ac-7816-49e4-bfca-1a3cc5198fbb" />


The main.m script plots both the simulated output and the measured signal, and calculates the error between them.
