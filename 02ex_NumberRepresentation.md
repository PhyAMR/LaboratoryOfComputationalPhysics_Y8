---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.18.1
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

# Libraries 


```python
import numpy as np 
```

# Exercises
1\. Write a function that converts number representation, bin<->dec<->hex. (Clearly using the corresponding python built-in functions is not fair..)


```python

class Number_converter(n)

```

2\. Write a function that converts a 32 bit word into a single precision floating point (i.e. interprets the various bits as sign, mantissa and exponent)


```python

```

3\. Write a program to determine the underflow and overflow limits (within a factor of 2) for python on your computer. 

**Tips**: define two variables inizialized to 1 and halve/double them enough time to exceed the under/over-flow limits   


# 4\. Write a program to determine the machine precision

**Tips**: define a new variable by adding a smaller and smaller value (proceeding similarly to prob. 2) to an original variable and check the point where the two are the same 

```python
a=1.0
b=0.99999
c=1e-8 
while a != b:
  b+=c

print(a - (b-c))
```

5\. Write a function that takes in input three parameters $a$, $b$ and $c$ and prints out the two solutions to the quadratic equation $ax^2+bx+c=0$ using the standard formula:
$$
x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}
$$


(a) use the program to compute the solution for $a=0.001$, $b=1000$ and $c=0.001$


```python
def solve_quad(a,b,c):
  x_1 = (-b + np.sqrt(b**2 - 4*a*c))/(2*a)
  x_2 = (-b-np.sqrt(b**2 - 4*a*c))/2*a 
  return x_1,x_2 

print(solve_quad(0.001,1000,0.001))
```

(b) re-express the standard solution formula by multiplying top and bottom by $-b\mp\sqrt{b^2-4ac}$ and again find the solution for $a=0.001$, $b=1000$ and $c=0.001$. How does it compare with what previously obtained? Why?


```python
def solve_quad2(a,b,c):
  pos_factor = (-b + np.sqrt(b**2 - 4*a*c))/(-b + np.sqrt(b**2 - 4*a*c))
  neg_factor = (-b - np.sqrt(b**2 - 4*a*c))/(-b - np.sqrt(b**2 - 4*a*c))
  x_1 = (-b + np.sqrt(b**2 - 4*a*c))/(2*a)*(-b - np.sqrt(b**2 - 4*a*c))/(-b - np.sqrt(b**2 - 4*a*c))

  x_2 = (-b-np.sqrt(b**2 - 4*a*c))/(2*a)*(-b + np.sqrt(b**2 - 4*a*c))/(-b + np.sqrt(b**2 - 4*a*c))
  return x_1,x_2 

print(solve_quad(0.001,1000,0.001))
```

(c) write a function that compute the roots of a quadratic equation accurately in all cases


```python

```

6\. Write a program that implements the function $f(x)=x(x−1)$

(a) Calculate the derivative of the function at the point $x = 1$ using the derivative definition:

$$
\frac{{\rm d}f}{{\rm d}x} = \lim_{\delta\to0} \frac{f(x+\delta)-f(x)}{\delta}
$$

with $\delta = 10^{−2}$. Calculate the true value of the same derivative analytically and compare with the answer your program gives. The two will not agree perfectly. Why not?



```python
def f(x):
  return x*(x-1)

def der_f(f,x_0,d):
  return (f(x_0+d)-f(x_0))/d 
x_0 = 0
print(der_f(f,x_0,1e-12))
print(2*x_0-1)

```

(b) Repeat the calculation for $\delta = 10^{−4}, 10^{−6}, 10^{−8}, 10^{−10}, 10^{−12}$ and $10^{−14}$. How does the accuracy scales with $\delta$?


```python
for d in [1e-4,1e-6,1e-8,1e-10,1e-12,1e-14]:
  print(f"The relative error for d={d} is: {100*np.abs(der_f(f,x_0,d)+1)/(1)}%")
```

7\. Consider the integral of the semicircle of radius 1:
$$
I=\int_{-1}^{1} \sqrt(1-x^2) {\rm d}x
$$
which it's known to be $I=\frac{\pi}{2}=1.57079632679...$.
Alternatively we can use the Riemann definition of the integral:
$$
I=\lim_{N\to\infty} \sum_{k=1}^{N} h y_k 
$$

with $h=2/N$ the width of each of the $N$ slices the domain is divided into and where
$y_k$ is the value of the function at the $k-$th slice.

(a) Write a programe to compute the integral with $N=100$. How does the result compares to the true value?


```python


def int_f2(N):
  x = np.linspace(-1,1,N)
  f = lambda x: np.sqrt(1-x**2)
  h=2/N 
  return np.sum(h*f(x))
N=100

print(f"The relative error for N={N} is: {100*np.abs(int_f2(N)- np.pi/2)/(np.pi/2)}%")

```

(b) How much can $N$ be increased if the computation needs to be run in less than a second? What is the gain in running it for 1 minute? 


```python
import time 

cycle = 0
N=100
while cycle <= 1:
  N += 1
  start = time.time()
  print(f"The relative error for N={N} is: {100*np.abs(int_f2(N)- np.pi/2)/(np.pi/2)}%")
  cycle = start - time.time()


```

```python
%timeit int_f2(7.999999e7)
```
