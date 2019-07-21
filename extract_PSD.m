function extract_PSD(PATHIN,PATHOUT,low_fre,high_fre)
%   input: 
%   输入路径�?PATHIN   
%   输出路径�?PATHOUT
cd(PATHIN)
list=dir('*.set');
len=length(list); 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
for s=1:len 
    EEG = pop_loadset('filename',[num2str(s),'.set'],'filepath',PATHIN);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    figure; pop_spectopo(EEG, 1, [EEG.xmin*1000  EEG.xmax*1000], 'EEG' , 'percent', 50, 'freq', [ ], 'freqrange',[low_fre high_fre],'electrodes','off');
    load([PATHIN,'Power.mat']);
    save([PATHOUT,num2str(s),'.mat'],'Power');
    close all;
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end
close all;
