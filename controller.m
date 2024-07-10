A = [-0.600896 251.751 0 -9.815; -0.0240377 -11.9318 0.454904 0; 0.00245226 -0.616477 -0.70952 0; 0 0 1 0];
B = [0;-0.6951;-1.9374; 0];
C = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
D = [0];
sys = ss(A,B,C,D);
tft = tf(sys);
tf1 = tft(1);
tf2 = tft(2);
tf3 = tft(3);
tf4 = tft(4);
Pd = [-0.5, -0.501, -6, -6.01];
k = place(A, B, Pd);
Pd2 = [-3+3*j, -3.01-3*j, -4+1*j, -4.01-1*j];
k2 = place(A, B, Pd2);
C_edit = [0 1 0 0];
Ac = A - B*k;
Ac2 = A - B * k2;
cl_sys = ss(Ac, B, C_edit, D);
cl2_sys = ss(Ac2, B, C_edit, D);
ol_sys = ss(A, B, C_edit, D);
xx0 = [200;-5;0;0];
[yy1, tt1, xx1] = initial(cl_sys, xx0, 4);
[yy2, tt2, xx2] = initial(ol_sys, xx0, 4);
[yy3, tt3, xx3] = initial(cl2_sys, xx0, 4);
subplot(131)
plot(tt1, yy1, tt2, yy2, 'k--', tt3, yy3);
xlabel('time');
ylabel('angle of attack');
legend('close loop 1', 'open loop', 'close loop 2');
sys_control = ss(A - B * k, B, C_edit, D);
Q = 100*eye(4);
R = 1;
k_opt = lqr(A, B, Q, R);
clo_sys = ss(A - B * k_opt, B, C_edit, D);
Q2 = eye(4);
k2_opt = lqr(A, B, Q2, R);
clo2_sys = ss(A - B * k2_opt, B, C_edit, D);
[yy1o, tt1o, xx1o] = initial(clo_sys, xx0, 4); u1o = -k_opt * xx1o';
[yy2o, tt2o, xx2o] = initial(ol_sys, xx0, 4);   
[yy3o, tt3o, xx3o] = initial(clo2_sys, xx0, 4); u2o = -k2_opt * xx3o';
subplot(132)
plot(tt1o, yy1o, tt2o, yy2o, 'k--', tt3o, yy3o); grid;
xlabel('time');
ylabel('angle of attack');
legend('close loop 1 opt', 'open loop', 'close loop 2 opt');
subplot(133)
plot(tt1o, u1o,  tt3o, u2o); grid;
xlabel('time');
ylabel('angle of attack control effort');
legend('close loop 1 opt', 'close loop 2 opt');