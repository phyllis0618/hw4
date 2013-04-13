sigma_n=0.5;
x=[-5:2:-1 0:0.1:5]';
y=2*sin(x)+sigma_n*randn(length(x),1);
x_star=-5:0.1:5;
y_star=2*sin(x_star);
gamma=0.5;

K=zeros(length(x),length(x));
for i=1:length(x)
    for j=1:length(x)
        if i==j
           
            K(i,j)=1+sigma_n^2;
            
        else
            K(i,j)=exp(-1/(2*gamma)*norm(x(i)-x(j),2)^2);
        end
    end
end

K_star=zeros(1,length(x));
y_pre=zeros(1,length(x_star));
y_std=zeros(1,length(x_star));

K_inv=inv(K);

for i=1:length(x_star)
    for j=1:length(x)
        if x_star(i)==x(j)
          
           K_star(j)=1
        else
            K_star(j)=exp(-1/(2*gamma)*norm(x_star(i)-x(j),2)^2);
        end
    end
   
    K_star2=1+sigma_n^2;
    
    y_pre(i)=K_star*K_inv*y;
    y_std(i)=sqrt(K_star2-K_star*K_inv*K_star');
end

        


figure;
plot(x,y,'*-',x_star,y_star,'*-',x_star,y_pre,'*-',x_star,y_std,'*-');
legend('Training data','Test data','Predicting','Standard deviation')
xlabel('Xpoints')
ylabel('Ypoints')
title('hw4-3 plots')