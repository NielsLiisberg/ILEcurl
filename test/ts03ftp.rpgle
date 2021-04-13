**FREE
ctl-opt copyright('System & Method (C), 2020');
ctl-opt decEdit('0,') datEdit(*YMD.) main(main);
ctl-opt bndDir('ILECURL');
//  -----------------------------------------------------------------------------
//   By     Date       PTF     Description
//   ------ ---------- ------- ---------------------------------------------------
//   NLI    22.04.2021         New program
//   -----------------------------------------------------------------------------
/include headers/ILEcurl.rpgle


//   -----------------------------------------------------------------------------
//   This sample show how to put a file to FTP server
//   Notes: 
//   1) here we use the namefmt 1 which allow us to put data onto a IBM i
//
//   2) The double slash in the url // lets us address from the root
//
//   3) The --verbose gets all the feedback into the "res" variable 
//
//   4) The URL here contains @ in user / password which requires your job 
//   to have set the jobccsid to let it convert to ascii corectly
//
//   This is just inspiration - cUrl cand do lots of cool stuff
//   -----------------------------------------------------------------------------

dcl-proc main ;

    dcl-s res varchar(32700);
    res = ic_curl (
        'ftp://USER:PASSWORD@localhost//tmp/xyz.txt':
        '--verbose -T "/tmp/demo.txt" -Q "SITE NAMEFMT 1"'
    );
    ic_joblog (res);

end-proc;
