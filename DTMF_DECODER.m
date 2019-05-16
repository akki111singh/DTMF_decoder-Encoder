num_array = [1,2,3;4,5,6;7,8,9;0,0,0];
[y,Fs] = audioread('sound.wav');
N = 100;
freqs = [697,770,852,941,1209,1336,1477];

inst_power = filter(ones(1,N)/N,1,y.*y);
threshold = 0.5*max(inst_power);

p_gt_t = zeros(1,length(y));

for i = (1:length(y))
    if(inst_power(i)>threshold)
        p_gt_t(i) = 1;
    else
        p_gt_t(i) = 0;
    end
end


clear i;
a=p_gt_t(2:length(y)) - p_gt_t(1:length(y)-1)==1;
b=p_gt_t(2:length(y)) - p_gt_t(1:length(y)-1) == -1;
beginning = find(a);  
ending = find(b);

len = ending - beginning(1:size(ending,2)) + 1;
k = ceil(freqs' * len/Fs);
num = 0;
for n = 1:length(ending)
    x = y(beginning(n):ending(n));
    fft2 = abs(fft(x));
    a = find(fft2(k(1:4,n)) == max(fft2(k(1:4,n))));
    b = find(fft2(k(5:7,n)) == max(fft2(k(5:7,n))));
    num = num*10 +num_array(a,b);
end
num


