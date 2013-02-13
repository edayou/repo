clear;
close all;
stack = tiffread;
n_stack = size(stack,2);
for i = 1:n_stack
    target(:,:,i) = stack(i).data;
end
clear i;
%FH1 = figure; imshow(target(:,:,40), 'DisplayRange', [], 'InitialMagnification', 'fit'); %Stackの先頭をFigureとして表示

%{
行列サイズを可変にする場合
data_matrix = [];

for j=1:n_stack
    X=double(target(:,:,j));
    data_matrix = [data_matrix,X(:)];
end

clear j;
%}

W = numel(target)./n_stack;
sample = zeros(W,n_stack);
for j=1:n_stack
    X=double(target(:,:,j));
    sample(:,j) = X(:);
end
[size_y,size_x] = size(X);    
clear j;

%{
model = perform_pca_PhD(sample,rank(sample)-1); %generate PCA model
 
figure(1)
imshow(reshape(model.P,size_y,size_x),[])
title('Mean face')
 
figure(2)
   for i=1:6
       subplot(4,2,i)
       imshow(reshape(model.W(:,i),size_y,size_x),[])
       title(sprintf('Eigenface no. %i',i));
   end
subplot(4,2,7)
imshow(reshape(model.W(:,20),size_y,size_x),[])
title('Eigenface no. 20')
subplot(4,2,8)
imshow(reshape(model.W(:,30),size_y,size_x),[])
title('Eigenface no. 30')  
set(gcf,'Name', 'PCA components/Eigenfaces/eigenvectors in image form')    
%}

[coefs,scores,variances,t2] = princomp(sample);
percent_explained = 100*variances/sum(variances);

%imshow(reshape(scores(:,i),size(X)),[])

Result= zeros(size_y,size_x,n_stack);
for n=1:n_stack
    Result(:,:,n) = reshape(scores(:,n),size(X));
end

figure(1)
if n_stack>30
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
else
    for i=1:4
       subplot(2,2,i)
       imshow(Result(:,:,i),[])
       title(sprintf('Eigenimage no. %i',i));
    end
end
%{
figure(2)
pareto(percent_explained);
biplot(coefs(:,1:2), 'scores',scores(:,1:2));
%}

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