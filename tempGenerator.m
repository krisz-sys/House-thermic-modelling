function out=tempGenerator(t)
t0=1;
t1=1500;
t2=3000;
t3=4500;
t4=6000;
t5=7500;

temp1=5;
temp2=-1;
temp3=-2;
temp4=-2;
m1=(temp1-temp2)/(t(t0)-t(t1));
out=m1*t(t0:t1)-m1*t(t0)+temp1;
out=[out temp2*ones(1,t2-t1-1)];
m2=(temp3-temp2)/(t(t3)-t(t2));
out=[out (m2*(t(t2:t3)-t(t2))+temp2)];
out=[out temp3*ones(1,t4-t3-1)];

m3=(temp3-temp4)/(t(t3)-t(t4));
out=[out (m3*(t(t3:t4)-t(t3))+temp3)];
out=[out temp4*ones(1,length(t)-t5)];
% plot(t,out)