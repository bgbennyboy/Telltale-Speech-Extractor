{
  part of: MP3FileUtils v0.5

  -------------------------------------------------------

  The contents of this file are subject to the Mozilla Public License
  Version 1.1 (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS IS"
  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
  License for the specific language governing rights and limitations
  under the License.

  The Original Code is U_CharCode, part of MP3FileUtils.

  The Initial Developer of the Original Code is Daniel Gaussmann,
  mail@gausi.de. Portions created by the Initial Developer are
  Copyright (C) 2005-2009 the Initial Developer. All Rights Reserved.

  Contributor(s): (none yet)

  Alternatively, the contents of this file may be used under the terms
  of the GNU Lesser General Public License Version 2.1 or later
  (the  "LGPL"), in which case the provisions of LGPL are applicable
  instead of those above. If you wish to allow use of your version of
  this file only under the terms of the LGPL and not to allow others to use
  your version of this file under the MPL, indicate your decision by
  deleting the provisions above and replace them with the notice and
  other provisions required by the LGPL. If you do not delete
  the provisions above, a recipient may use your version of this file
  under either the MPL or the LGPL License.

  -------------------------------------------------------

  Use this unit to detect the probably used codepage of an Ansi-tagged
  mp3-file.

  Idea behind this function here:

      * Count the greek, hebrew, cyrillic, ... symbols in the filename
        to get the language
      * choose a codepage for this language.
        Note: Not every codepage is supported

  Note: This is a workaround. You _should_really_ use Unicode-formats
        (utf-16, utf-8) for chars beyond #255
        It seems to work pretty well, but there can be no guarantee for
        proper functionality!

}


unit U_CharCode;

interface

uses
  SysUtils, Classes, Windows;

type

  {$IFNDEF UNICODE}
      UnicodeString = WideString;
  {$ENDIF}

  TCodePage = record
      Description: string;
      CodePage: Cardinal;
      Index: integer;
  end;

  TConvertOptions = record
      Greek    : TCodePage;
      Cyrillic : TCodePage;
      Hebrew   : TCodePage;
      Arabic   : TCodePage;
      Thai     : TCodePage;
      Korean   : TCodePage;
      Chinese  : TCodePage;
      Japanese : TCodePage;
      // If you want to store user settings for Unicode/Ansi-Handling,
      // the following two settings may be useful as well.
      // Use the settings from here in your ID3v*Tag-Objects
      AlwaysWriteUnicode : Boolean;
      AutoDetectCodePage : Boolean;
  end;


const
    DefaultCharCode : TCodePage = (Description: 'System default'; CodePage: CP_ACP; Index: 0);

    GreekEncodings : Array[0..1] of TCodePage =
        ( (Description: 'MS Windows Greek'; CodePage: 1253; Index:0),
          (Description: 'IBM PC Greek'    ; CodePage: 727 ; Index:1));

    CyrillicEncodings : Array[0..2] of TCodePage =
        ( (Description: 'MS Windows Cyrillic'; CodePage: 1251; Index:0),
          (Description: 'IBM PC Cyrillic'    ; CodePage: 855;  Index:1),
          (Description: 'ISO 8859-5 Latin/Cyrillic'; CodePage: 28595; Index:2));

    HebrewEncodings : Array[0..2] of TCodePage =
        ( (Description: 'MS Windows Hebrew';       CodePage: 1255;  Index:0),
          (Description: 'Hebrew (DOS)';            CodePage: 862;   Index:1),
          (Description: 'ISO 8859-8 Latin/Hebrew'; CodePage: 28598; Index:2));

    ArabicEncodings : Array[0..2] of TCodePage =
        ((Description: 'MS Windows Arabisch';       CodePage: 1256;  Index:0),
         (Description: 'Arabisch (DOS)';            CodePage: 720;   Index:1),
         (Description: 'ISO 8859-6 Latin/Arabisch'; CodePage: 28596; Index:2));

    ThaiEncodings : Array[0..0] of TCodePage =
        ((Description: 'MS Windows Thai'; CodePage: 874;   Index:0));

    ChineseEncodings : Array[0..1] of TCodePage =
        ( (Description: 'Traditional Chinese (Big5)'; CodePage: 950; Index:0 ),
          (Description: 'Simplified Chinese GBK'    ; CodePage: 936; Index:1));

    KoreanEncodings : Array[0..0] of TCodePage =
        ( (Description: 'MS Korean'; CodePage: 949;   Index:0));

    JapaneseEncodings : Array[0..0] of TCodePage =
        ( (Description: 'Japanese Shift-JIS'; CodePage: 932;   Index:0));


// Get Codepage and use user-settings, if more than one codepage is supported by this unit
function GetCodepage(aFilename: UnicodeString; Options: TConvertOptions): TCodePage; overload;

// get codepage and return the first matching codepage
function GetCodepage(aFilename: UnicodeString): TCodePage; overload;

implementation


function GetCodepage(aFilename: UnicodeString; Options: TConvertOptions): TCodePage;
var Greek, Cyrillic, Hebrew, Arabic, Thai, Korean, Chinese, Japanese: integer;
    i, max: integer;
begin
  Greek    := 0;  Cyrillic := 0;
  Hebrew   := 0;  Arabic   := 0;
  Thai     := 0;  Korean   := 0;
  Chinese  := 0;  Japanese := 0;
  
  for i:= 1 to length(aFilename) do
  begin
    case Longint(aFilename[i]) of
      $0384..$03CE : inc(Greek);
      $0401..$045F : inc(Cyrillic);
      $05D1..$05EA : inc(Hebrew);
      $061B..$0652 : inc(Arabic);
      $0E01..$0E5B : inc(Thai);
      $AC02..$CEFF : inc(Korean);       //Hangeul
      $3041..$30F6 : inc(Japanese);     //Hiragana / Katakana
      $3105..$3129 : inc(Chinese);      //Bopomofo / Zhuyin
      $4E00..$9F67 : begin              // Ideographs,
                        inc(Japanese);  // common in these languages (?)
                        inc(Chinese);
                        inc(Korean);
                     end;
    end;
  end;

  result := DefaultCharCode;
  max := 0;

  if Greek > max then
  begin
    max := Greek  ;
    result := Options.Greek;
  end;

  if Cyrillic > max then
  begin
    max := Cyrillic  ;
    result := Options.Cyrillic;
  end;

  if Hebrew > max then
  begin
    max := Hebrew    ;
    result := Options.Hebrew;
  end;

  if Arabic > max then
  begin
    max := Arabic    ;
    result := Options.Arabic;
  end;

  if Thai > max then
  begin
    max := Thai      ;
    result := Options.Thai;
  end;

  if Korean > max then
  begin
    max := Korean    ;
    result := Options.Korean;
  end;

  if Japanese > max then
  begin
    max := Japanese  ;
    result := Options.Japanese;
  end;

  if (Chinese >= max) And (max>0) then  // chinese ">=" max, not ">" because:
  begin                                 // Chinese, korean, japanese use some common signs
    //max := Chinese;                   // Probably the language is chinese, if only these common signs are used.
    result := Options.Chinese;
  end;
end;


function GetCodepage(aFilename: UnicodeString): TCodePage; overload;
var Greek, Cyrillic, Hebrew, Arabic, Thai, Korean, Chinese, Japanese: integer;
    i, max: integer;
begin
  Greek    := 0;  Cyrillic := 0;
  Hebrew   := 0;  Arabic   := 0;
  Thai     := 0;  Korean   := 0;
  Chinese  := 0;  Japanese := 0;

  for i:= 1 to length(aFilename) do
  begin
    case Longint(aFilename[i]) of
      $0384..$03CE : inc(Greek);
      $0401..$045F : inc(Cyrillic);
      $05D1..$05EA : inc(Hebrew);
      $061B..$0652 : inc(Arabic);
      $0E01..$0E5B : inc(Thai);
      $AC02..$CEFF : inc(Korean);
      $3041..$30F6 : inc(Japanese);
      $3105..$3129 : inc(Chinese);
      $4E00..$9F67 : begin
                        inc(Japanese);
                        inc(Chinese);
                        inc(Korean);
                     end;
    end;
  end;

  result := DefaultCharCode;
  max := 0;

  if Greek > max then
  begin
    max := Greek  ;
    result := GreekEncodings[0];
  end;

  if Cyrillic > max then
  begin
    max := Cyrillic  ;
    result := CyrillicEncodings[0];
  end;

  if Hebrew > max then
  begin
    max := Hebrew    ;
    result := HebrewEncodings[0];
  end;

  if Arabic > max then
  begin
    max := Arabic    ;
    result := ArabicEncodings[0];
  end;

  if Thai > max then
  begin
    max := Thai      ;
    result := ThaiEncodings[0];
  end;

  if Korean > max then
  begin
    max := Korean    ;
    result := KoreanEncodings[0];
  end;

  if Japanese > max then
  begin
    max := Japanese  ;
    result := JapaneseEncodings[0];
  end;

  if (Chinese >= max) And (max>0) then
  begin
    //max := Chinese;
    result := ChineseEncodings[0];
  end;
end;
end.

