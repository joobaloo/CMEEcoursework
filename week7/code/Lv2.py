#!/usr/bin/env python3

""" The Lotka-volterra model revisited """

__appname__ = 'Lv2.py'
__author__ = 'Jooyoung Ser (zs519@ic.ac.uk)'
__version__ = '0.0.1'

#importing modules
import numpy as np
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p
import sys

#Lokta-Volterra model
def dCR_dt(pops, t = 0, r = 5, a = 5, z = 5, e = 5, K = 5):
    """ Function that takes populations and calculates the Lotka-Volterra model"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - R / K) - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

#arbituary units of time
t = np.linspace(0, 15, 1000) #1000 evenly spaced t values between 0 to 15

#setting initial conditions for the two populations per unit area
R0 = 10 #10 resources
C0 = 5  #5 consumers
RC0 = np.array([R0, C0])
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

if len(sys.argv) == 6:
    print("Running script using provided arguments")
    r = float(sys.argv[1])
    a = float(sys.argv[2])
    z = float(sys.argv[3])
    e = float(sys.argv[4])
    K = float(sys.argv[5])
    p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    p.text(14, 40, "r =" + str(sys.argv[1]))
    p.text(14, 38, "a =" + str(sys.argv[2]))
    p.text(14, 36, "z =" + str(sys.argv[3]))
    p.text(14, 34, "e =" + str(sys.argv[4]))
    p.text(14, 32, "K =" + str(sys.argv[5]))
    p.legend(loc='best')
    p.savefig('../results/revisited_LV_model.pdf')
else:
    print("Incorrect number of arguments provided, using default values")
    p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    p.text(14, 40, "r = 5")
    p.text(14, 38, "a = 5")
    p.text(14, 36, "z = 5") 
    p.text(14, 34, "e = 5")
    p.text(14, 32, "K = 5")
    p.legend(loc='best')
    p.savefig('../results/default_revisited_LV_model.pdf')
