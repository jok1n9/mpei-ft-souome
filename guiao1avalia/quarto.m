p= (1-0.01)*(1-0.002)*(1-0.005);
n=8;
k=8;
probteo= factorial(n)/(factorial(n-k)*factorial(k))*p^k*(1-p)^(n-k);
