function read_dataset(PATHIN,PATHOUT,lowfre,highfre)
%   input: 
%   输入路径�?PATHIN   
%   输出路径�?PATHOUT
%   带�?滤波器下陷： lowfre
%   带�?滤波器上上限�?highfre

if ~exist(PATHOUT)
    mkdir(PATHOUT);
end
cd(PATHIN)
list=dir('*.vhdr');
len=length(list);
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% Loop over subjects 
for s=1:len 
    EEG = pop_loadbv(PATHIN, list(s).name);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','EEG_data','gui','off'); 
    EEG=pop_chanedit(EEG, 'lookup','E:\sccn_eeglab-eeglab-1411e6c5d5ef\plugins\dipfit2.3\standard_BESA\standard-10-5-cap385.elp');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = eeg_checkset( EEG );
    EEG = pop_reref( EEG, [31 32] );
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
    EEG = eeg_checkset( EEG );
    EEG = pop_select( EEG,'nochannel',{'IO'});
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
    EEG = pop_eegfilt(EEG, lowfre,highfre,[], [0], 0, 0, 'fir1', 0);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off'); 
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',[num2str(s),'.set'],'filepath',PATHOUT);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end
save([PATHOUT,'Readdata_List.mat'],'list');
