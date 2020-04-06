**FREE      
// CMD:CRTRPGMOD 
ctl-opt copyright('System & Method (C), 2020');
ctl-opt decEdit('0,') datEdit(*YMD.) nomain;
ctl-opt bnddir('QC2LE');
    
//  -----------------------------------------------------------------------------
//   By     Date       PTF     Description
//   ------ ---------- ------- ---------------------------------------------------
//   NLI    22.03.2020         New program
//   -----------------------------------------------------------------------------
/include headers/ILEcurl.rpgle
/include headers/IFS.rpgle

//  -----------------------------------------------------------------------------
//  Curl wrapper
//  -----------------------------------------------------------------------------
dcl-proc ic_curl export;

    dcl-pi *n varchar(32760);
        url    varchar(256)   const options(*varsize);
        parms  varchar(32760) const options(*varsize:*nopass);
        data   varchar(32760) const options(*varsize:*nopass) ccsid(*UTF8);    
    end-pi;

    // Need PASE for this trick
    Dcl-Pr Qp2Shell ExtPgm('QP2SHELL');
        parm1 char(256)   const options(*varsize);
        parm2 char(256)   const options(*varsize);
        parm3 char(32760) const options(*varsize);
    End-Pr Qp2Shell;

    dcl-s cmd       varchar(32760);
    dcl-s inname    varchar(256);
    dcl-s outname   varchar(256);
    dcl-s errname   varchar(256);
    dcl-s inf       varchar(256);
    dcl-s outf      varchar(256);
    dcl-s errf      varchar(256);
    dcl-s tempf     varchar(256);
    dcl-s result    varchar(32760);
    dcl-s at        char(1) ccsid(*UTF8) inz('@');

    // Build temp names for stream files
    tempf = %xlate('.-':'__':%char(%timestamp()));
    inname  = '/tmp/' + tempf + '_in.txt';
    outname = '/tmp/' + tempf + '_out.txt';
    errname = '/tmp/' + tempf + '_err.txt';
    outf = '"' + outname  + '"';
    errf = '"' + errname + '"';
    inf  = '"' + inname  + '"';

    // use pase shell to unwrap parameters from string
    cmd = 'curl --silent --show-error "'  + url + '" '; 
    
    if %parms() >= %parmnum(parms) ;
        cmd += parms;  
    endif;

    if %parms() >=  %parmnum(data);
        ic_writeToStream (inname : data);
        cmd += ' --data-binary ' + at + inf;
    endif;
    
    cmd += ' --output ' + outf;
    cmd += ' --stderr ' + errf; 
    cmd +=';setccsid 1208 ' + outf;
    cmd +=';setccsid 1208 ' + errf;
    Qp2Shell (
        '/QOpenSys/usr/bin/sh' + x'00' :
        '-c'+ x'00' :
        cmd + x'00'
    );
    // Unpack the respons from IFS to a varchar
    result = ic_loadFromStream (errname);
    if result > '';
        result = 'ERROR:' +result;
    else;
        result = ic_loadFromStream (outname);
    endif;

    // Clean up
    unlink (inname);
    unlink (outname);
    unlink (errname);
    return result;

end-proc;
//  -----------------------------------------------------------------------------
//  load a stream file into a string
//  -----------------------------------------------------------------------------
dcl-proc ic_loadFromStream export;

    dcl-pi *n varchar(32760);
        fileName    varchar(256)   value;
    end-pi;

    dcl-ds bufds qualified;
        buf  varchar(32760);
        len  int(5) pos(1);
        data char(32760) pos(3);
    end-ds;

    dcl-s f         pointer;

    f = fopen(fileName : 'r, o_ccsid=0' );
    bufds.len = fread (%addr(bufds.data): 1: %size(bufds.data) : f);
    fclose(f);
    return bufds.buf;

end-proc;
//  -----------------------------------------------------------------------------
//  load a stream file into a string
//  -----------------------------------------------------------------------------
dcl-proc ic_writeToStream export;

    dcl-pi *n ;
        fileName    varchar(256)   value;
        inbuf       varchar(32760) const options(*varsize) ccsid(*UTF8);    
    end-pi;

    dcl-s f         pointer;
    dcl-s buf       varchar(32760) ccsid(*UTF8);    

    buf = inbuf;
    f = fopen(fileName : 'wb, o_ccsid=1208' );
    fwrite (%addr(buf:*DATA): 1: %len(buf) : f);
    fclose(f);

end-proc;
