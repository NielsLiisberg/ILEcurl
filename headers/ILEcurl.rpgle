**FREE
      /if defined( ILECURL_DEF)
      /eof
      /endif
      /define  ILECURL_DEF

        dcl-pr ic_curl rtnparm varchar(32760);
            url    varchar(256)   const options(*varsize);
            parms  varchar(32760) const options(*varsize:*nopass);
        end-pi;

