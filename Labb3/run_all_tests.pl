
% For sicstus: use_module(library(lists)).  before consulting the file.

run_all_tests(ProgramToTest) :-
    catch(consult(ProgramToTest),
          B,
          (write('Could not consult \"'), write(ProgramToTest),
           write('\": '), write(B), nl, halt)),
    all_valid_ok(['valid000.txt','valid001.txt','valid002.txt','valid004.txt','valid005.txt',
'valid006.txt','valid011.txt','valid012.txt','valid014.txt','valid016.txt',
'valid018.txt','valid022.txt','valid023.txt','valid024.txt','valid031.txt',
'valid032.txt','valid035.txt','valid036.txt','valid037.txt','valid038.txt',
'valid042.txt','valid043.txt','valid053.txt','valid054.txt','valid056.txt',
'valid060.txt','valid061.txt','valid063.txt','valid065.txt','valid068.txt',
'valid070.txt','valid073.txt','valid079.txt','valid081.txt','valid085.txt',
'valid086.txt','valid087.txt','valid093.txt','valid098.txt','valid099.txt',
'valid102.txt','valid107.txt','valid112.txt','valid117.txt','valid121.txt',
'valid124.txt','valid133.txt','valid136.txt','valid137.txt','valid145.txt',
'valid146.txt','valid147.txt','valid151.txt','valid153.txt','valid157.txt',
'valid161.txt','valid163.txt','valid173.txt','valid175.txt','valid176.txt',
'valid181.txt','valid182.txt','valid186.txt','valid187.txt','valid188.txt',
'valid190.txt','valid192.txt','valid193.txt','valid199.txt','valid201.txt',
'valid203.txt','valid215.txt','valid218.txt','valid219.txt','valid220.txt',
'valid224.txt','valid225.txt','valid226.txt','valid229.txt','valid232.txt',
'valid233.txt','valid242.txt','valid245.txt','valid249.txt','valid255.txt',
'valid259.txt','valid263.txt','valid265.txt','valid269.txt','valid271.txt',
'valid274.txt','valid275.txt','valid276.txt','valid279.txt','valid280.txt',
'valid281.txt','valid289.txt','valid290.txt','valid301.txt','valid304.txt',
'valid305.txt','valid314.txt','valid322.txt','valid327.txt','valid346.txt',
'valid348.txt','valid351.txt','valid355.txt','valid356.txt','valid360.txt',
'valid364.txt','valid366.txt','valid380.txt','valid381.txt','valid389.txt',
'valid391.txt','valid393.txt','valid394.txt','valid397.txt','valid398.txt',
'valid400.txt','valid403.txt','valid407.txt','valid409.txt','valid410.txt',
'valid411.txt','valid417.txt','valid420.txt','valid421.txt','valid426.txt',
'valid438.txt','valid441.txt','valid443.txt','valid447.txt','valid451.txt',
'valid453.txt','valid455.txt','valid459.txt','valid460.txt','valid465.txt',
'valid468.txt','valid474.txt','valid479.txt','valid493.txt','valid506.txt',
'valid515.txt','valid516.txt','valid518.txt','valid519.txt','valid521.txt',
'valid523.txt','valid530.txt','valid541.txt','valid550.txt','valid552.txt',
'valid558.txt','valid559.txt','valid578.txt','valid585.txt','valid586.txt',
'valid588.txt','valid592.txt','valid593.txt','valid594.txt','valid597.txt',
'valid598.txt','valid599.txt','valid609.txt','valid621.txt','valid627.txt',
'valid628.txt','valid631.txt','valid635.txt','valid640.txt','valid648.txt',
'valid650.txt','valid652.txt','valid653.txt','valid661.txt','valid664.txt',
'valid666.txt','valid667.txt','valid668.txt','valid670.txt','valid673.txt',
'valid675.txt','valid686.txt','valid687.txt','valid689.txt','valid699.txt',
'valid703.txt','valid706.txt','valid710.txt','valid715.txt','valid721.txt',
'valid728.txt','valid738.txt','valid747.txt','valid753.txt','valid756.txt',
'valid768.txt','valid785.txt','valid792.txt','valid797.txt','valid800.txt',
'valid806.txt','valid811.txt','valid814.txt','valid823.txt','valid826.txt',
'valid832.txt','valid833.txt','valid835.txt','valid836.txt','valid839.txt',
'valid840.txt','valid842.txt','valid843.txt','valid849.txt','valid852.txt',
'valid855.txt','valid859.txt','valid862.txt','valid865.txt','valid872.txt',
'valid873.txt','valid874.txt','valid882.txt','valid883.txt','valid887.txt',
'valid888.txt','valid896.txt','valid903.txt','valid905.txt','valid910.txt',
'valid911.txt','valid912.txt','valid914.txt','valid917.txt','valid934.txt',
'valid939.txt','valid951.txt','valid953.txt','valid968.txt','valid986.txt',
'valid987.txt','valid999.txt','our_valid.txt']),
    all_invalid_ok([
'invalid989.txt','invalid990.txt','invalid991.txt','invalid993.txt','invalid995.txt',
'invalid996.txt','invalid997.txt','invalid998.txt','our_invalid.txt']),
    halt.
    
all_valid_ok([]).
all_valid_ok([Test | Remaining]) :-
    write(Test), 
    (verify(Test), write(' passed');
    write(' failed. The proof is valid but your program rejected it!')),
    nl, all_valid_ok(Remaining).

all_invalid_ok([]).
all_invalid_ok([Test | Remaining]) :-
    write(Test), 
    (\+verify(Test), write(' passed');
    write(' failed. The proof is invalid but your program accepted it!')),
    nl, all_invalid_ok(Remaining).
