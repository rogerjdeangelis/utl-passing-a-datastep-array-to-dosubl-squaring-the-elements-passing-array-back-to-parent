Passing a datastep array to dosubl squaring the elements passing array back to parent

github
https://tinyurl.com/y7dl5zq7
https://github.com/rogerjdeangelis/utl-passing-a-datastep-array-to-dosubl-squaring-the-elements-passing-array-back-to-parent

This is purely an academic execise to show that it is possible.
We need help from SAS to simplify this code.

I don't think this is possible with FCMP. may be doable with DS2, but why bother.
For most problems DS2 is to complex, although the datastep needs 128bit floats.

This has major applications especially if storage can be shared with R and Python.
DOSUBL can create a table and open=defer in the parent can make the table availalble
to the parent. Shared HASH storage?


Pwesistent HASH (pass hash results to mutiple DOSUBL's.
github
https://github.com/rogerjdeangelis/utl_hash_persistent


EXAMPLE OUTPUT  (squaring elements of an array)
--------------

Before  DOSUBL

ARY1=1
ARY2=2
ARY3=3

After   DOSUBL and passed to parent

ARY1=1
ARY2=4
ARY3=9


* SOLUTION;
==========

data want;
array ary[3] 8 (1,2,3);
call symputx('adrAns',put(addrlong(ary[1]),$hex16.));
put "before " /
   ary[1] = /
   ary[2]= /
   ary[3]= ;
rc=dosubl('
data _null_;
  do _i_=1 to 3;
    num  =2 * input(peekclong (ptrlongadd ("&adrAns"x,(_i_-1)*8),8),rb8.);
    call  pokelong(num,ptrlongadd ("&adrAns"x,(_i_-1)*8),8);
  end;
run;quit;
');
put "AFTER " /
   ary[1] = /
   ary[2]= /
   ary[3]= ;
run;quit;


