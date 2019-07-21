function extract_ERSP_ITC(PATHIN,PATHOUT,pretime,postiom,low_cycles,high_cycles,low_fre,high_fre,time_counts,frepad)

cd(PATHIN)
list=dir('*.set');
len=length(list); 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
for s=1:len 
    EEG = pop_loadset('filename',[num2str(s),'.set'],'filepath',PATHIN);
    for elec = 1:EEG.nbchan
        disp(num2str(elec));
        [ersp,itc,powbase,times,freqs,erspboot,itcboot]=pop_newtimef(EEG, 1, elec, [pretime*1000  postiom*1000-2], [low_cycles high_cycles] ,'elocs', EEG.chanlocs, 'chaninfo',...
           EEG.chaninfo, 'caption', 'P6', 'baseline',[0], 'freqs', [low_fre high_fre],'topovec', 1, 'ntimesout',time_counts,'plotersp', 'off', 'plotitc' , 'off', 'plotphase', 'off', 'padratio',frepad,'basenorm', 'on', 'trialbase', 'full');
        Timefreq{elec}.ersp=ersp;
        Timefreq{elec}.itc=itc;
        Timefreq{elec}.powbase=powbase;
        Timefreq{elec}.times=times;
        Timefreq{elec}.freqs=freqs;
        Timefreq{elec}.erspboot=erspboot;
        Timefreq{elec}.itcboot=itcboot;
    end
    save([PATHOUT,num2str(s),'.mat'],'Timefreq');
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];  
    close all;  
end
   























