        ctl-opt copyright('System & Method (C), 2020');
        ctl-opt decEdit('0,') datEdit(*YMD.) main(main);
        ctl-opt bndDir('ILECURL');
        //  -----------------------------------------------------------------------------
        //   By     Date       PTF     Description
        //   ------ ---------- ------- ---------------------------------------------------
        //   NLI    22.03.2020         New program
        //   -----------------------------------------------------------------------------
        /include ILEcurl

        // Prototypes:
        dcl-pr JobLog int(10) extproc('Qp0zLprintf');
            fmtstr pointer value options(*string); // logMsg
        end-pr;


        //   -----------------------------------------------------------------------------
        dcl-proc main ;

            dcl-s  pOrderHead   pointer;
            dcl-s  pRequest     pointer;
            dcl-s  pResponse    pointer;
            dcl-s  jwt          varchar(1024);
            dcl-ds itOrderHead  likeds(json_iterator);

            res = ic_curl ('https://google.com');

            joblog (res);


        end-proc;
