Numbers = '123456789*0#';
low_freq = [697,770,852,941];
high_freq = [1209,1336,1477];

Fs = 8000;
t = 0.3;
N = 1:ceil(t*Fs);

[Ra,Ca] = meshgrid(low_freq,high_freq);

T = sin(2*pi*(Ra(:)/Fs)*N) + sin(2*pi*(Ca(:)/Fs*N));

Get_input = input('Enter Keys:[0:9*#]: ','s');

D=cell(1,numel(Get_input));
assert(all(ismember(Get_input,Numbers)),'Invalid Key')

for k = 1:numel(Get_input)
    X = strfind(Numbers,Get_input(k));
    sound(T(X,:));
    sil_tt=0:(1/Fs):0.2;
    sil_tone=sin(2*pi*0.2*sil_tt);
    pause(0.5);
    D{k}=[T(X,:),sil_tone];
end
dtmf = cat(2, D{:});
audiowrite('sound.wav',dtmf,8000)
audio=audioread('sound.wav');
spectrogram(audio);
