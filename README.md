# ILEcurl


ILEcurl an opensource wrapper for the cURL tool, make it easy to use cURL from and RPG program like:

```
dcl-proc main ;

    dcl-s res varchar(32700);
    res = ic_curl ('https://google.com':'-k');
    ic_joblog (res);

end-proc;
```



### Installation

Installation of ILEcurl should be done with `git` and `gmake` (GNU Make), which are available via `yum` - you can read more about [yum here](https://bitbucket.org/ibmi/opensource/src/master/docs/yum/).

ILEcurl is a two step process. ILEcurl requires you to build from source, but this step has been totally automated for you. To install ILEcurl, you need to use the pase environment (with `ssh` for example) and with a couple of seconds you can have the project built. No need to download save files, upload them or restore them.

```
git -c http.sslVerify=false clone https://github.com/NielsLiisberg/ILEcurl.git
cd ILEcurl
gmake
```

This will create:

* The `ILEcurl` library
* `ILEcurl/ILEcurl` service program.
* `ILEcurl/QRPGLESRC.ILEcurl` for the ILEcurl API prototypes.
* `Test` folder with examples .
* `ILEcurl/ILEcurl` binding directory, with the `ILEcurl` object on it.

### Using ILEcurl
the syntax is 

```
  result = ic_curl ( url : curlparms : inputdata);
````
#### result
The result is produced in UTF-8 but will automatically converted to EBCDIC by the prototypes, so if
you are using only basic letters you can simply use plain RPG variables - otherwise look in the UTF-8 examples

#### url
The url can use the protocols http and https

#### cURL parameters 
This is the extra curl command parameter - note the `input` parameter is a separate parameter so you don't 
have to escape the input

#### input data
Like the result it is transferred in UTF-8 and converted by the prototype. The contents type ( form, json, XML etc) can be used however you need to set the `Content-type`  accordingly

for more information about cURL parameters please read:

https://curl.haxx.se/docs/manpage.html


### Release
To install the release, run:
```
CRTLIB ILECURL
CPYFRMSTMF FROMSTMF('./release/release.savf') TOMBR('/QSYS.lib/ILECURL.lib/RELEASE.FILE') MBROPT(*REPLACE) CVTDTA(*NONE)
RSTLIB SAVLIB(ILECURL) DEV(*SAVF) SAVF(ILECURL/RELEASE)
