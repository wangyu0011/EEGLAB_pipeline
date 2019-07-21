function remove_marker(PATHIN,PATHOUT)
%   input: 
%   输入路径�?PATHIN   
%   输出路径�?PATHOUT
cd(PATHIN)
list=dir('*.set');
len=length(list); 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
l=1;
for s=1:len
    try
        EEG = pop_loadset('filename',[num2str(s),'.set'],'filepath',PATHIN);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        A=EEG.event;
        [x,y]=size(A);
        for i=1:y
            try
               if strcmp(A(i).type,'5sec')
                    A(i)=[];
               end  
            catch
            end    
        end  
        [x1,y1]=size(A);
        for j=0:y1
            try
               if strcmp(A(j).type,'boundary')
                    A(j)=[];
               end  
            catch

            end    
        end  
        EEG.event=A;
        EEG = eeg_checkset( EEG );
        EEG = pop_saveset( EEG, 'filename',[num2str(l),'.set'],'filepath',PATHOUT);
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
        STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
        l=l+1;
    catch
    end  
end
