        ctl-opt copyright('System & Method (C), 2020');
        ctl-opt decEdit('0,') datEdit(*YMD.) nomain;
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


        //  -----------------------------------------------------------------------------
        //  Curl wrapper
        //  -----------------------------------------------------------------------------
        dcl-proc il_curl;

            dcl-pi *n varchar(32760);
                url    varchar(256)   const options(*varsize);
                parms  varchar(32760) const options(*varsize);
            end-pi;

            // Need PASE for this trick
            Dcl-Pr Qp2Shell ExtPgm('QP2SHELL');
                parm1 char(256)   const options(*varsize);
                parm2 char(256)   const options(*varsize);
                parm3 char(32760) const options(*varsize);
            End-Pr Qp2Shell;

            dcl-s cmd       varchar(32760);
            dcl-s outname   varchar(256);
            dcl-s errname   varchar(256);
            dcl-s outf      varchar(256);
            dcl-s errf      varchar(256);
            dcl-s tempf     varchar(256);
            dcl-s result    varchar(32760);
			dcl-s at        char(1) ccsid(*UTF8) inz('@');

            // Build temp names for stream files
            tempf = %xlate('.-':'__':%char(%timestamp()));
            outname = '/tmp/' + tempf + '_out.txt';
            errname = '/tmp/' + tempf + '_err.txt';
            outf = '"' + outname  + '"';
            errf = '"' + errname + '"';

            // use deafult shell to unwrap parameters from string
            cmd = 'curl "'  + url + '" ' + parms  + ' -o ' + outf;
			cmd += ' --silent --stderr ' + errf 
			cmd += ' --data-binary ' + at + inputf
            cmd +=';setccsid 1208 ' + outf;
            cmd +=';setccsid 1208 ' + errf;
            Qp2Shell (
                '/QOpenSys/usr/bin/sh' + x'00' :
                '-c'+ x'00' :
                cmd + x'00'
            );
            // Unpack the respons from IFS to a varchar
            result = loadFromStream (errname);
			if result > '';
				result = 'ERROR:' +result;
			else;
	            result = loadFromStream (outname);
			endif;
	
            // Clean up
            unlink (outname);
            unlink (errname);
            return result;

        end-proc;
        //  -----------------------------------------------------------------------------
        //  load a stream file into a string
        //  -----------------------------------------------------------------------------
        dcl-proc loadFromStream ;

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
