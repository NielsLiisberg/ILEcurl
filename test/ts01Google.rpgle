**FREE
ctl-opt copyright('System & Method (C), 2020');
ctl-opt decEdit('0,') datEdit(*YMD.) main(main);
ctl-opt bndDir('ILECURL');
//  -----------------------------------------------------------------------------
//   By     Date       PTF     Description
//   ------ ---------- ------- ---------------------------------------------------
//   NLI    22.03.2020         New program
//   -----------------------------------------------------------------------------
/include headers/ILEcurl.rpgle


//   -----------------------------------------------------------------------------
dcl-proc main ;

    dcl-s res varchar(32700);
    res = ic_curl ('https://google.com':'-k');
    ic_joblog (res);

end-proc;
