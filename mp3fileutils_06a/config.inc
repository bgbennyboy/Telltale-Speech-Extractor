{
  part of:
  
  -------------------------------------------------------
  MP3FileUtils v0.5
  Copyright (C) 2005-2009, Daniel Gaussmann
                           mail@gausi.de
  All rights reserved.
  -------------------------------------------------------
}



{
  Compiler-Switch-TNT:
  For reading files with "unicode filenames", some methods/types from the
  "TNT Unicode Controls" can be used:
    - WideFileExists and
    - TTntFileStream
  If you do not want to use this, only Ansi-Filenames are supported
  (in Delphi 2007 or earlier).  
}

{.$DEFINE USE_TNT_COMPOS}



{
  Delphi 2009: Unicode-capable by default. TNTs ar not needed.
               => Deactivate use of TNTs
}


{$IFDEF UNICODE}
    {$UNDEF USE_TNT_COMPOS}
{$ENDIF}


