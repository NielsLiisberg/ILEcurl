**FREE

/if defined( ILECURL_DEF)
    /eof
/endif
/define  ILECURL_DEF

dcl-pr ic_curl varchar(32760);
    url    varchar(256)   const options(*varsize);
    parms  varchar(32760) const options(*varsize:*nopass);
    data   varchar(32760) const options(*varsize:*nopass) ccsid(*UTF8);    
end-pr;

dcl-pr ic_loadFromStream varchar(32760);
    fileName    varchar(256)   value;
end-pr;

dcl-pr ic_writeToStream ;
    fileName    varchar(256)   value;
    inbuf       varchar(32760) const options(*varsize) ccsid(*UTF8);    
end-pr;

dcl-pr ic_jobLog int(10) extproc('Qp0zLprintf');
    fmtstr pointer value options(*string); // logMsg
end-pr;




