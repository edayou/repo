clear;
close all;

stack = tiffread;
n_stack = size(stack,2);
for i = 1:n_stack
    target(:,:,i) = stack(i).data;
end
clear i;
%FH1 = figure; imshow(target(:,:,40), 'DisplayRange', [], 'InitialMagnification', 'fit'); %Stackの先頭をFigureとして表示

W = numel(target)./n_stack;
sample = zeros(W,n_stack);
for j=1:n_stack
    X=double(target(:,:,j));
    sample(:,j) = X(:);
end
[size_y,size_x] = size(X);    
clear j;

[coefs,scores,variances,t2] = princomp(sample);
percent_explained = 100*variances/sum(variances);

Result= zeros(size_y,size_x,n_stack);
for n=1:n_stack
    Result(:,:,n) = reshape(scores(:,n),size(X));
end

%%　ここから出力

fig_num;%表示する図の数

figure(1)%eigen imageの表示
if n_stack>30%変数の数で分岐、
       for i=1:6
       subplot(4,2,i)
       imshow(Result(:,:,i),[])
       title(sprintf('Eigenimage no. %i',i));
       end
    subplot(4,2,7)
    imshow(Result(:,:,20),[])
    title('Eigenimage no. 20')
    subplot(4,2,8)
    imshow(Result(:,:,30),[])
    title('Eigenimage no. 30')
    fig_num=6;
else
    for i=1:4
       subplot(2,2,i)
       imshow(Result(:,:,i),[])
       title(sprintf('Eigenimage no. %i',i));
    end
    fig_num=4;
end

figure(4)
Leg=cell(fig_num,1);%legend用
text='Component';%legend用
for i=1:1:fig_num
    plot(coefs(:,i));
    hold all;
    Leg{i,1}=[text, num2str(i)];
end
legend(Leg);
legend('show');

%{
[Z,mu,sigma] = zscore(sample);
[coefs_Z,scores_Z,variances_Z,t2_Z] = princomp(Z);
percent_explained_Z = 100*variances_Z/sum(variances_Z);
Result_Z= zeros(size_y,size_x,n_stack);
for n=1:n_stack
    Result_Z(:,:,n) = reshape(scores_Z(:,n)+mu(:,n),size(X));
end

figure(3)
if n_stack>30
   for i=1:6
       subplot(4,2,i)
       imshow(Result_Z(:,:,i),[])
       title(sprintf('Eigenimage no. %i',i));
   end
   subplot(4,2,7)
   imshow(Result_Z(:,:,20),[])
   title('Eigenimage no. 20')
   subplot(4,2,8)
   imshow(Result_Z(:,:,30),[])
   title('Eigenimage no. 30')  
else
   for i=1:4
       subplot(2,2,i)
       imshow(Result_Z(:,:,i),[])
       title(sprintf('Eigenimage no. %i',i));
   end 
end
%}


