function remove_trials(PATHIN,PATHOUT,pretime,postime,limit)


if ~exist(PATHOUT)
    mkdir(PATHOUT);
end
cd(PATHIN)
list=dir('*.set');
len=length(list);
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% Loop over subjects 
for s=1:len 
    EEG = pop_loadset('filename',[num2str(s),'.set'],'filepath',PATHIN);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    EEG = pop_eegthresh(EEG,1,[1:EEG.nbchan] ,-limit,limit,pretime,postime,0,0);
    EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
    A=EEG.reject.rejthresh;
    EEG = pop_rejepoch( EEG, A ,0);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
    DATA=mean(EEG.data,3);
    save([PATHOUT,num2str(s),'.mat'],'DATA');
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset( EEG, 'filename',[num2str(s),'.set'],'filepath',PATHOUT);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end   







    













