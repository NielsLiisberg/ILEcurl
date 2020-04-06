      * ---------------------------------------------------------------------
      * IFS wraps the C-functions and POSIX functions for the IFS file system
      * Need binddir QC2LE so add the follwing H-spec
      * H BndDir('QC2LE')
      * If you need the handles to C standartd files simply define:
      * /define IFS_STD_FILES
      * ---------------------------------------------------------------------
      /if not defined(IFS_DEF)
      /define IFS_DEF

     d rename          PR            10I 0 extproc('Qp0lRenameKeep')
     d  oldname                        *   value options(*string)
     d  newname                        *   value options(*string)

     d unlink          PR            10I 0 extproc('unlink')
     d   path                          *   value options(*string)

     d statDS          DS                  based(prototype_only) qualified
     d  mode                         10U 0
     d  ino                          10U 0
     d  nlink                         5U 0
     d  pad                           2A
     d  uid                          10U 0
     d  gid                          10U 0
     d  size                         10I 0
     d  atime                        10I 0
     d  mtime                        10I 0
     d  ctime                        10I 0
     d  dev                          10U 0
     d  blksize                      10U 0
     d  allocsize                    10U 0
     d  objtype                      10A
     d  filler01                      2A
     d  codepage                      5U 0
     d  reserved1                    62A
     d  ino_gen_id                   10U 0


     d stat            PR            10I 0 extproc('stat')
     d  path                           *   value options(*string)
     d  pStatDS                        *   value

     d fstat           PR            10I 0 extproc('fstat')
     d  hfile                        10I 0 value
     d  pStatDS                        *   value


     d DirDS           ds                  based(prototype_only) qualified
     d  reserved1                    16A
     d  reserved2                    10U 0
     d  fileno                       10U 0
     d  reclen                       10U 0
     d  reserved3                    10I 0
     d  reserved4                     8A
     d  nlsinfo                      12A
     d   ccsid                       10I 0 overlay(nlsinfo:1)
     d   country                      2A   overlay(nlsinfo:5)
     d   lang                         3A   overlay(nlsinfo:7)
     d   reserved5                    3A   overlay(nlsinfo:10)
     d  varnameDS                   644A
     d   varname                    640A   overlay(varnameDS:3) varying
     d   namelen                     10U 0 overlay(varnameDS:1)
     d   name                       640A   overlay(varnameDS:5)

     d mkdir           PR            10I 0 extproc('mkdir')
     d  path                           *   value options(*string)
     d  accessmode                   10U 0 value options(*nopass)

     d rmdir           PR            10I 0 extproc('rmdir')
     d  path                           *   value options(*string)

     d chdir           PR            10I 0 extproc('chdir')
     d  path                           *   value Options(*string)

     d opendir         PR              *   extproc('opendir')
     d  dirname                        *   value options(*string)

     d readdir         PR              *   extproc('readdir')
     d  hdir                           *   value

     d closedir        PR            10I 0 extproc('closedir')
     d  hdir                           *   value

     d getcwd          PR              *   extproc('getcwd')
     d  dirname                        *   value
     d  sizedirname                  10I 0 value

      // Open Flags (OpenFlags)
     d O_RDONLY        C                   1                                    Reading Only
     d O_WRONLY        C                   2                                    Writing Only
     d O_RDWR          C                   4                                    Reading & Writing
     d O_CREAT         C                   8                                    Create File if not exist
     d O_EXCL          C                   16                                   Exclusively create
     d O_CCSID         C                   32                                   Assign a CCSID
     d O_TRUNC         C                   64                                   Truncate File to 0 bytes
     d O_APPEND        C                   256                                  Append to File
     d O_SYNC          C                   1024                                 Synchronous write
     d O_DSYNC         C                   2048                                 Sync write, data only
     d O_RSYNC         C                   4096                                 Sync read
     d O_NOCTTY        C                   32768                                No controlling terminal
     d O_SHARE_RDONLY  C                   65536                                Share with readers only
     d O_SHARE_WRONLY  C                   131072                               Share with writers only
     d O_SHARE_RDWR    C                   262144                               Share with read & write
     d O_SHARE_NONE    C                   524288                               dont share
     d O_CODEPAGE      C                   8388608                              set code page
     d O_TEXTDATA      C                   16777216                             For new files - Open in text-mode
     d O_TEXT_CREAT    C                   33554432
     d O_INHERITMODE   C                   134217728
     d O_LARGEFILE     C                   536870912                            Files over 2G

      // accessMode - Is optional                                               Owner auth.
     d S_IRUSR         C                   256                                  read permission, owner
     d S_IWUSR         C                   128                                  write permission, owner
     d S_IXUSR         C                   64                                   execute/search permission, owner
     d S_IRWXU         C                   448                                  read, write, execute/search by owner
     d S_IRGRP         C                   32                                   read permission, group
     d S_IWGRP         C                   16                                   write permission, group
     d S_IXGRP         C                   8                                    execute/search permission, group
     d S_IRWXG         C                   56                                   read, write, execute/search by group
     d S_IROTH         C                   4                                    read permission, public
     d S_IWOTH         C                   2                                    write permission, public
     d S_IXOTH         C                   1                                    execute/search permission, public
     d S_IRWXO         C                   7                                    read, write, execute/search by public

      // Access flags:
      // F_OK: file exists
      // R_OK: allow read access
      // W_OK: allow write Access
      // X_OK: allow execute
     d F_OK            C                   0
     d R_OK            C                   4
     d W_OK            C                   2
     d X_OK            C                   1

     d access          PR            10I 0 extproc('access')
     d  path                           *   value Options(*string)
     d  accessmode                   10I 0 value

     d chmod           PR            10I 0 extproc('chmod')
     d  path                           *   value options(*string)
     d  accessmode                   10U 0 value

     d open            PR            10I 0 extproc('open')
     d  path                           *   value options(*string)
     d  openflags                    10I 0 value
     d  accessmode                   10U 0 value options(*nopass)
     d  codepage                     10U 0 value options(*nopass)

     d write           PR            10I 0 extproc('write')
     d  hfile                        10I 0 value
     d  buffer                         *   value
     d  bytes                        10U 0 value

     d read            PR            10I 0 extproc('read')
     d  hfile                        10I 0 value
     d  buffer                         *   value
     d  bytes                        10U 0 value

      // seek consts
     d SEEK_SET        C                   CONST(0)
     d SEEK_CUR        C                   CONST(1)
     d SEEK_END        C                   CONST(2)

     d lseek           PR            10I 0 extproc('lseek')
     d  hfile                        10I 0 value
     d  offset                       10I 0 value
     d  whence                       10I 0 value

     d close           PR            10I 0 extproc('close')
     d  hfile                        10I 0 value
      * ================================================================
      * now the buffered sream files from stdio
      *-----------------------------------------------------------------
     d fopen           PR              *   ExtProc('_C_IFS_fopen')
     d   fileName                      *   value options(*string)
     d   mode                          *   value options(*string)
      *
     d fgets           PR              *   ExtProc('_C_IFS_fgets')
     d   string                        *   value
     d   size                        10I 0 value
     d   filePtr                       *   value
      *
     d fputs           PR            10I 0 ExtProc('_C_IFS_fputs')
     d   string                        *   value options(*string)
     d   filePtr                       *   value
      *
     d fread           PR            10I 0 ExtProc('_C_IFS_fread')
     d   data                          *   value
     d   size                        10I 0 value
     d   count                       10I 0 value
     d   filePtr                       *   value
      *
     d fwrite          PR            10I 0 ExtProc('_C_IFS_fwrite')
     d   data                          *   value
     d   size                        10I 0 value
     d   count                       10I 0 value
     d   filePtr                       *   value
      *
     d fflush          PR            10U 0 ExtProc('_C_IFS_fflush')
     d   filePtr                       *   value
      *
     d fseek           PR            10I 0 ExtProc('_C_IFS_fseek')
     d   filePtr                       *   value
     d   offset                      10I 0 value
     d   whence                      10I 0 value
      *
     d ftell           PR            10I 0 ExtProc('_C_IFS_ftell')
     d   filePtr                       *   value
      *
     d fdopen          pr              *   extproc('fdopen')
     d   fildes                      10I 0 value
     d   mode                          *   value options(*string)
     d
      *
     d fclose          PR            10I 0 ExtProc('_C_IFS_fclose')
     d   filePtr                       *   value

      // Modify access time and update time on a streamfile
     d utimbufDS       DS                  based(prototype_only) qualified
     d  atime                        10I 0
     d  mtime                        10I 0

     d utime           PR            10I 0 extproc('utime')
     d  path                           *   value options(*string)
     d  utimbufDS                          likeds(utimbufDS)
      * ----------------------------------------------------------------
      * Std I/O files
      *-----------------------------------------------------------------
      /if defined(IFS_STD_FILES)
     d stdin           s               *   import('_C_IFS_stdin')
     d stdout          s               *   import('_C_IFS_stdout')
     d stderr          s               *   import('_C_IFS_stderr')
      /endif

      /endif

