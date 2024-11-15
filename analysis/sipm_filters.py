import numpy as np

### CONVOLUTION

def h(t, t0, tRC):
    a = 1/(t0-tRC)*(np.exp(-t/t0)-np.exp(-t/tRC))
    n = a > 0
    return a * n
def x(t, T1, sig1, T2, sig2):
    return np.exp(-(t-(T1+T2))**2/(2*(sig1**2 + sig2**2)))
def convo(t, T1, sig1, t0, T2, sig2, tRC):
    return np.convolve(h(t, t0, tRC), x(t, T1, sig1, T2, sig2), 'same')

### DECONVOLUTION

def deconv(v0, Ts, t0, tRC):
    roll1 = np.roll(v0, 1)
    roll2 = np.roll(v0, 2)
    roll1[0:1] = 0
    roll2[0:2] = 0
    d1 = np.exp(-Ts/t0)
    d2 = np.exp(-Ts/tRC)
    return v0 - (d1 + d2) * roll1 + d1 * d2 * roll2

### TRAPEZOIDAL


def trapezoidal(i_d, K, L, M):
    si2_1 = np.roll(i_d, K)
    si2_1[0:K] = 0
    si2_2 = np.roll(i_d, L)
    si2_2[0:L] = 0
    si2_3 = np.roll(i_d, K+L)
    si2_3[0:K+L] = 0
    a = i_d - si2_1 - si2_2 + si2_3
    c = M * a
    d = np.array([0])
    for i in range(1, len(a)):
        d = np.append(d, a[i] + d[i-1])
    e = c + d
    f = np.array([0])
    for i in range(1, len(e)):
        f = np.append(f, e[i] + f[i-1])
  #  print(np.shape(f))
  #  print(np.shape(i_d))
    return f

    
### TRAPEZOIDAL (2nd Version)

def trapezoidal_2nd(i_d, K, L, M):
    si2_temp = np.roll(i_d, K)
    si2_temp[0:K] = 0
    a = i_d - si2_temp
    a_temp = np.roll(a, L)
    a[0:L] = 0
    b = a - a_temp
    c = M * b
    d = np.array([0])
    for i in range(1, len(b)):
        d = np.append(d, b[i] + d[i-1])
    e = c + d
    f = np.array([0])
    for i in range(1, len(e)):
        f = np.append(f, e[i] + f[i-1])
   # print(np.shape(f))
   # print(np.shape(i_d))
    return int(f) / L / M

### BASIC SIPM PULSE (NOT BASED ON EVIDENCE)

def sim_pulse(t, xin, a, b, c):
    
    x = a * np.exp(-(t-xin)/b) * np.heaviside(t-xin, 1)
    y = np.array([np.mean(x[int(i-c/2):int(i+c/2)]) for i in range(len(x))])
    y[:int(c/2)] = 0
    y[-int(c/2):] = 0
    return y