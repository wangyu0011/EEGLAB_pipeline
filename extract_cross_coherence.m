function extract_cross_coherence(PATHIN,PATHOUT,pretime,postiom,low_cycles,high_cycles,low_fre,high_fre,frepad)

cd(PATHIN)
list=dir('*.set');
len=length(list); 
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
for i=1:len
    EEG = pop_loadset([PATHIN,num2str(i),'.set']);
    l=1;
    for elec = 1:EEG.nbchan-1
        for j=(elec+1):EEG.nbchan 
            [coh,mcoh,timesout,freqsout,cohboot]=pop_newcrossf( EEG, 1,elec,j, [pretime*1000  postiom*1000], [low_cycles  high_cycles] ,'type', 'phasecoher', 'topovec', [elec,j],...
                'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo,'freqs', [low_fre high_fre], 'title','Channel Fp1-Fp2 Phase Coherence','padratio',frepad,'plotamp','off','plotphase','off');
            coheren{l}.coh=coh;
            coheren{l}.mcoh=mcoh;
            coheren{l}.timesout=timesout;
            coheren{l}.freqsout=freqsout;
            coheren{l}.cohboot=cohboot;
            coheren{l}.chann=[EEG.chanlocs(elec).labels,'-',EEG.chanlocs(j).labels];
            l=l+1;
        end    
    end
    save([PATHOUT,num2str(i),'.mat'],'coheren');
    close all;  
end











