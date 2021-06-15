Combinatorial Optimization using PSO
================
Andres Fernando Garcia
6/14/2021

<img src="./imgs/rescue.jpg"
     height="80%" 
     width="80%"/>

## Project details

This project consists of performing [combinatorial
optimization](https://en.wikipedia.org/wiki/Combinatorial_optimization)
to select the best group of 3 rescue ships in order to attend marine
accidents. There are 725 rescue ships distributed in a particular ocean
region with a high level of maritime activity.

<img src="README_files/figure-gfm/unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

The number of possible combinations is:

<img src="https://render.githubusercontent.com/render/math?math=C(725,3)=\frac{725!}{3!(725-3)}=63,250,450"
    style="background-color:#CCD1D6"
    height="80%" 
    width="80%"/>

One accident should be assigned to the nearest rescue ship, considering
all accidents. As a constraint condition, an accident must be assigned
to a rescue ship within 30 nautical miles, no matter how far.

The objective function of the problem is:

<img src="https://render.githubusercontent.com/render/math?math=argmin_{c_1,c_2,c_3} \{ \sum_{i=1}^{n}min(||x_i-c_1||,||x_i-c_2||,||x_i-c_3||) \}"
    style="background-color:#CCD1D6"
    height="80%" 
    width="80%"/>

subject to

<img src="https://render.githubusercontent.com/render/math?math=min(||x_i-c_1||,||x_i-c_2||,||x_i-c_3||) < 30\ nautical\ miles"
    style="background-color:#CCD1D6"
    height="80%" 
    width="80%"/>

where

  - n is the number of marine accidents (n=366)
  - x\_i is the i-th marine accident
  - c is the center of the rescue ship (3 rescue ships)

The selected distance between each rescue ship and the registered marine
accidents (366) is the [euclidean
distance](https://en.wikipedia.org/wiki/Euclidean_distance#:~:text=In%20mathematics%2C%20the%20Euclidean%20distance,being%20called%20the%20Pythagorean%20distance.).

## Results

To solve the optimization problem, the Particle Swarm Optimization
([PSO](https://en.wikipedia.org/wiki/Particle_swarm_optimization#:~:text=In%20computational%20science%2C%20particle%20swarm,a%20given%20measure%20of%20quality.&text=The%20algorithm%20was%20simplified%20and%20it%20was%20observed%20to%20be%20performing%20optimization.))
algorithm is implemented using MATLAB. The parameters used in the
simulation were:

``` r
# PSO initialization
swarm_size = 70                # number of the swarm particles
maxIter    = 150               # maximum number of iterations
inertia    = 0.93
c_local    = 0.4               # influence of the best local                     
c_global   = 0.3               # influence of the best global
```

The following image shows the behavior of each particle in the
simulation.

<img src="./imgs/animation.gif"
     height="110%" 
     width="110%"/>

The node number of the best three rescue ships locations is (170, 363,
542).
