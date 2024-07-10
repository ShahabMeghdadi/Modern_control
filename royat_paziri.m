A = [-0.600896 251.751 0 -9.815; -0.0240377 -11.9318 0.454904 0; 0.00245226 -0.616477 -0.70952 0; 0 0 1 0];
B = [0;-0.6951;-1.9374; 0];
C = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
D = [0];
O = obsv(A,C);
rnkO = rank(O);
Con = ctrb(A,B);
rnkC = rank(Con);
[T, J] = jordan(A);
JB = inv(T)*B;
JC = C*T;
