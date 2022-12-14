#!/usr/bin/env python3

""" Demonstrates creating figures using matplotlib """

__appname__ = 'Lv1.py.py'
__author__ = 'Jooyoung Ser (zs519@ic.ac.uk)'
__version__ = '0.0.1'

import numpy as np
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p


#Lokta-Volterra model
def dCR_dt(pops, t=0):
    """ Function for the lokta_volterra model"""

    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

type(dCR_dt)

r = 1.
a = 0.1 
z = 1.5
e = 0.75

#arbituary units of time
t = np.linspace(0, 15, 1000)

R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

type(infodict)

infodict.keys()

infodict['message']

#plotting the graph
p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.show()# To display the figure

#saving figure
f1 = p.figure()
f1.savefig('../results/LV_model.pdf')

p.plot(pops[:,0], pops[:,1], 'r-', label = 'Consumer-Resource population dynamics')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
p.show()

#saving figure
f2 = p.figure()
f2.savefig('../results/second_fig.pdf')