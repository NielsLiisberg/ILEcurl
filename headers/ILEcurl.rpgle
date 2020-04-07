**FREE

/if defined( ILECURL_DEF)
    /eof
/endif
/define  ILECURL_DEF
                                 
dcl-s IC_LONGUTF8VARCHAR varchar(1048572:4) ccsid(*utf8) template;

dcl-pr ic_curl like(IC_LONGUTF8VARCHAR) rtnparm ;
    url    varchar(256)   const options(*varsize);
    parms  varchar(32760) const options(*varsize:*nopass);
    data   like(IC_LONGUTF8VARCHAR)  const options(*varsize:*nopass);    
end-pr;

dcl-pr ic_readFromStream like(IC_LONGUTF8VARCHAR) rtnparm;
    fileName    varchar(256)   value;
end-pr;

dcl-pr ic_writeToStream ;
    fileName    varchar(256)   value;
    inbuf       like(IC_LONGUTF8VARCHAR)  options(*varsize);    
end-pr;

dcl-pr ic_jobLog int(10) extproc('Qp0zLprintf');
    fmtstr pointer value options(*string); // logMsg
end-pr;




