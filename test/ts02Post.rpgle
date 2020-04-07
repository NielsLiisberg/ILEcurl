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

    dcl-s req     like(IC_LONGUTF8VARCHAR); 
    dcl-s res     like(IC_LONGUTF8VARCHAR); 
    dcl-c appkey  'xxZiVLkVMPE7-ECxvEaJIbZ5nD4QS63bUM63ww-ZxXOi_w'; // <<< Put your applicaton key here

    req = ('-
        { -
            "model_id": "en-es", -
            "text"    : "Good afternoon my friends" -
	    }-   
    ');

    res = ic_curl (
        'https://gateway.watsonplatform.net/language-translator/api/v3/translate?version=2018-05-01':
        '-k -X POST -
         -H "Content-Type: application/json" - 
         --user apikey:' + appkey: 
        req
    );
    
    ic_joblog (%char(res));

end-proc;
