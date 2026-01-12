PROGRAM PLC_PRG_1
VAR
  intvar: INT; 
  stringvar: STRING; 
  fbinst: fublo2; 
  erg1: INT; 
  erg2: STRING; 
  fbinst2: fublo2;
END_VAR

fbinst.fbin := 10;
fbinst.fbin2 := 'CoDeSys';
fbinst.fbinst := 0;

fublo2(fbinst := fbinst, fbout => strul);

erg1 := strul.ivar;
erg2 := strul.stvar;

fbinst2.fbin := erg1;
fbinst2.fbin2 := erg2;
fbinst2.fbinst := intvar;

fublo2(fbinst := fbinst2, fbout => stringvar);
END_PROGRAM