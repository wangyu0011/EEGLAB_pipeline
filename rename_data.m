function rename_data(PATHIN,PATHOUT)
%%
cd(PATHIN);
list=dir('*.set');
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
for i=1:length(list)
    EEG = pop_loadset('filename',[num2str(i),'.set'],'filepath',PATHIN);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    for j=1:EEG.trials
        EEG.event(j).type='1';
    end
    EEG = pop_editset(EEG, 'setname', 'ERP_data');
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',['sub',num2str(i),'.set'],'filepath',PATHOUT);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end