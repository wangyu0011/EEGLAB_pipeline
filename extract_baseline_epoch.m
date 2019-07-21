function extract_baseline_epoch(PATHIN,PATHOUT,pretime,postime,extract_events)

%   input: 
%   输入路径�?PATHIN   
%   输出路径�?PATHOUT
%   extract_events={  'S  1'  'S  2'  'S  3'  }
cd(PATHIN)
list=dir('*.set');
len=length(list); 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
for s=1:len 
    EEG = pop_loadset('filename',[num2str(s),'.set'],'filepath',PATHIN);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG,extract_events, [pretime          postime], 'newname', 'EEG_data pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [pretime*1000    0]);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',[num2str(s),'.set'],'filepath',PATHOUT);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end