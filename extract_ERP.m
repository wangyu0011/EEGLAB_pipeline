function extract_ERP(PATHIN,PATHOUT)

%   input: 
%   输入路径�?PATHIN   
%   输出路径�?PATHOUT
%   extract_events={  'S  1'  'S  2'  'S  3'  }
cd(PATHIN)
list=dir('*.set');
len=length(list); 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
l=1;
for s=1:len 
    try
        EEG = pop_loadset('filename',[num2str(s),'.set'],'filepath',PATHIN);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        DATA=mean(EEG.data,3);
        save([PATHOUT,num2str(s),'.mat'],'DATA');
        STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
        l=l+1;
    catch
    end    
end