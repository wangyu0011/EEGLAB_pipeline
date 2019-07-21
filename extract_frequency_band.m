function extract_frequency_band(PATHIN,PATHOUT)
%  input : PATHIN------input file's location
%          PATHOUT-----output file's location  
%output:  one file response to one *.mat
%         a serise coherence value between channel 1and channel2 in same
%         frequency bins.
cd(PATHIN)
list=dir('*.set');
len=length(list); 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
for s=1:len 
    EEG = pop_loadset('filename',[num2str(s),'.set'],'filepath',PATHIN);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    % define a serie of matrix for saving extarcted ERP data  
    DATA_theta=zeros(EEG.nbchan,EEG.pnts,EEG.trials);
    DATA_alpha=zeros(EEG.nbchan,EEG.pnts,EEG.trials);
    DATA_gamma=zeros(EEG.nbchan,EEG.pnts,EEG.trials);
    DATA_beta=zeros(EEG.nbchan,EEG.pnts,EEG.trials);
    DATA_delta=zeros(EEG.nbchan,EEG.pnts,EEG.trials);
    % define a serie of matrix for saving extarcted PSD data  
    PSD_theta=zeros(EEG.nbchan,200,EEG.trials);
    PSD_alpha=zeros(EEG.nbchan,200,EEG.trials);
    PSD_gamma=zeros(EEG.nbchan,200,EEG.trials);
    PSD_beta=zeros(EEG.nbchan,200,EEG.trials);
    PSD_delta=zeros(EEG.nbchan,200,EEG.trials);
    for i=1:EEG.nbchan
       for j=1:EEG.trials
           % load eegdata.mat;
            DATA1=EEG.data;
            data1=reshape(DATA1(i,:,j),1,EEG.pnts);
            fs =EEG.srate;
            DATA_times=zeros(5,EEG.pnts);
            DATA_PSD=zeros(10,EEG.pnts);
            % Sampling frequency
            % Sampling frequency
            N=length(data1);
            % setting parameters for wavelet transforma
            waveletFunction = 'db8';
                            [C,L] = wavedec(data1,8,waveletFunction);
                            cD1 = detcoef(C,L,1);
                            cD2 = detcoef(C,L,2);
                            cD3 = detcoef(C,L,3);
                            cD4 = detcoef(C,L,4);
                            cD5 = detcoef(C,L,5); %GAMA
                            cD6 = detcoef(C,L,6); %BETA
                            cD7 = detcoef(C,L,7); %ALPHA
                            cD8 = detcoef(C,L,8); %THETA
                            cA8 = appcoef(C,L,waveletFunction,8); %DELTA
                            D1 = wrcoef('d',C,L,waveletFunction,1);
                            D2 = wrcoef('d',C,L,waveletFunction,2);
                            D3 = wrcoef('d',C,L,waveletFunction,3);
                            D4 = wrcoef('d',C,L,waveletFunction,4);
                            D5 = wrcoef('d',C,L,waveletFunction,5); %GAMMA
                            D6 = wrcoef('d',C,L,waveletFunction,6); %BETA
                            D7 = wrcoef('d',C,L,waveletFunction,7); %ALPHA
                            D8 = wrcoef('d',C,L,waveletFunction,8); %THETA
                            A8 = wrcoef('a',C,L,waveletFunction,8); %DELTA
                            Gamma = D5;
                            Beta = D6;
                            Alpha = D7;
                            Theta = D8;
                            Delta = A8;
            DATA_gamma(i,:,j)=Gamma;
            DATA_beta(i,:,j)=Beta;
            DATA_alpha(i,:,j)=Alpha;
            DATA_theta(i,:,j)=Theta;
            DATA_delta(i,:,j)=Delta;
            %%%%   'GAMMA-FREQUENCY'
            D5 = detrend(D5,0);
            xdft = fft(D5);
            freq = 0:N/length(D5):N/2;
            xdft = xdft(1:length(D5)/2+1);
            DATA=abs(xdft);
            PSD_gamma(i,:,j)=DATA(1:200);
            %%%%   'BETA'
            D6 = detrend(D6,0);
            xdft2 = fft(D6);
            freq2 = 0:N/length(D6):N/2;
            xdft2 = xdft2(1:length(D6)/2+1);
            DATA=abs(xdft2);
            PSD_beta(i,:,j)=DATA(1:200);
            %%%%   'ALPHA'
            D7 = detrend(D7,0);
            xdft3 = fft(D7);
            freq3 = 0:N/length(D7):N/2;
            xdft3 = xdft3(1:length(D7)/2+1);
            DATA=abs(xdft3);
            PSD_alpha(i,:,j)=DATA(1:200);
            %%%%  'THETA'             
            D8 = detrend(D8,0);
            xdft4 = fft(D8);
            freq4 = 0:N/length(D8):N/2;
            xdft4 = xdft4(1:length(D8)/2+1);
            DATA=abs(xdft4);
            PSD_theta(i,:,j)=DATA(1:200);
            %%%%  'DELTA'
            A8 = detrend(A8,0);
            xdft5 = fft(A8);
            freq5 = 0:N/length(A8):N/2;
            xdft5 = xdft5(1:length(A8)/2+1);
            DATA=abs(xdft5);
            PSD_delta(i,:,j)=DATA(1:200);
       end    
    end  
    save([PATHOUT,'DATA_gamma',num2str(s),'.mat'],'DATA_gamma');
    save([PATHOUT,'DATA_beta',num2str(s),'.mat'],'DATA_beta');
    save([PATHOUT,'DATA_alpha',num2str(s),'.mat'],'DATA_alpha');
    save([PATHOUT,'DATA_theta',num2str(s),'.mat'],'DATA_theta');
    save([PATHOUT,'DATA_delta',num2str(s),'.mat'],'DATA_delta');
    
    save([PATHOUT,'PSD_gamma',num2str(s),'.mat'],'PSD_gamma');
    save([PATHOUT,'PSD_beta',num2str(s),'.mat'],'PSD_beta');
    save([PATHOUT,'PSD_alpha',num2str(s),'.mat'],'PSD_alpha');
    save([PATHOUT,'PSD_theta',num2str(s),'.mat'],'PSD_theta');
    save([PATHOUT,'PSD_delta',num2str(s),'.mat'],'PSD_delta');
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end









