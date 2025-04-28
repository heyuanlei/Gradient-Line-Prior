clear
I = imread('./hazy images/lviv_input.png');
I1=im2double(I);
II = I1;
[m,n,~] = size(II);tic
[FX,FY] =gradient(I1);
FXY=sqrt(FX.^2+FY.^2)*1+0.01/255;

patch_size =round(0.01*sqrt(m*n));
H=fspecial('gaussian', patch_size,patch_size);%fspecial('gaussian', hsize, sigma)产生滤波模板
FXY=imfilter(FXY,H,'replicate');

% pre-defined hyper-parameters
threshold = 0.07;


% calculate the atmospheric light
A = get_atmospheric_light(I1);
AA = reshape(repmat(A,[m*n,1]),m,n,3);

S_Vr(:,:,1)=I1(:,:,1)./FXY(:,:,1);
S_Vr(:,:,2)=AA(:,:,1)./FXY(:,:,1);
S_Vr(:,:,3)=I1(:,:,2)./FXY(:,:,2);
S_Vr(:,:,4)=AA(:,:,2)./FXY(:,:,2);
S_Vr(:,:,5)=I1(:,:,3)./FXY(:,:,3);
S_Vr(:,:,6)=AA(:,:,3)./FXY(:,:,3);
fun = @(block_struct)get_transmission(block_struct.data);
[transmission1] = blockproc(S_Vr,[patch_size,patch_size],fun);
transmission=transmission1(:,:,1);
transmission=min(max(transmission,0.05),1);
vart=transmission1(:,:,2);


t_sl = reshape(transmission(vart>threshold),1,[]);
t_l = prctile(t_sl,10);
t_min = mean(t_sl(t_sl<t_l))/1.0;
t_r = min(max(transmission,t_min),1);
% % refine the transmission using guided filter
t_final = guidedfilter(rgb2gray(II),t_r,4*patch_size,0.01); % non-overlapping patches calls for larger patch size in smoothing


dehaze = (I1-AA)./t_final.^0.8+AA;
toc
figure,imshow(dehaze);