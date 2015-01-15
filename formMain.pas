{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2014 Bennyboy
  Http://quickandeasysoftware.net
******************************************************
}

{
  BEFORE RELEASE CHECK:

  Include all the dll's and oggenc.exe
  Include the annotations
  Change build config from debug to release
  Compress with upx
  Disable ReportMemoryLeaksOnShutdown in project source
  Update readme
}

{
  Future possibilities:
  Prompt to save if annotation changes made and when exit/load new file ?
  File icons - different for each character?
  AnnotationManager - if there are no annotations loaded and you want to
    write some - need feature to create new annotation file
}

unit formMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ExtCtrls, Menus, TypInfo, System.UITypes,

  JvMenus, JvBaseDlg, JvBrowseFolder, JvExStdCtrls, JvRichEdit, JvExExtCtrls,
  JvExtComponent, JvPanel, JvEdit, JvHtControls,

  VirtualTrees,

  jclfileutils, jclsysinfo, jclstrings, jclshell,

  AdvGlowButton, AdvAppStyler, AdvMenus, AdvMenuStylers, HTMLStatusBar, TaskDialog, AdvPanel,

  uExplorerbaseunit, uExplorertypes, uTelltaleFuncs, uTelltaleSpeechExtractorConst;

type
  TfrmMain = class(TForm)
    Tree: TVirtualStringTree;
    dlgBrowseForSaveFolder: TJvBrowseForFolderDialog;
    SaveDialog1: TSaveDialog;
    pnlTop: TPanel;
    btnOpen: TAdvGlowButton;
    AdvFormStyler1: TAdvFormStyler;
    btnSaveSingleAudio: TAdvGlowButton;
    btnSaveAllAudio: TAdvGlowButton;
    btnPlaySound: TAdvGlowButton;
    dlgBrowseForOpenFolder: TJvBrowseForFolderDialog;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    btnFilterView: TAdvGlowButton;
    AdvPopupMenuFilter: TAdvPopupMenu;
    TaskDialogSaveFiles: TAdvTaskDialog;
    btnAbout: TAdvGlowButton;
    editFind: TJvEdit;
    pnlBottom: TAdvPanel;
    editAnnotAnnotation: TLabeledEdit;
    editAnnotFilename: TLabeledEdit;
    AdvPanelStyler1: TAdvPanelStyler;
    lblAnnotCategory: TLabel;
    comboboxAnnotCategory: TJvHTComboBox;
    btnAnnotAddCategory: TAdvGlowButton;
    btnAnnotClearCategorySelection: TAdvGlowButton;
    StatusBar: THTMLStatusBar;
    btnShowAnnotationPanel: TAdvGlowButton;
    btnAnnotSaveChanges: TAdvGlowButton;
    btnAnnotUndoChanges: TAdvGlowButton;
    ImageList1: TImageList;
    PopupMenuOpen: TPopupMenu;
    MenuOpenFolder: TMenuItem;
    MenuOpenFile: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Menu_BackToTheFuture_ItsAboutTime: TMenuItem;
    Menu_BackToTheFuture_GetTannen: TMenuItem;
    Menu_BackToTheFuture_CitizenBrown: TMenuItem;
    Menu_BackToTheFuture_DoubleVisions: TMenuItem;
    Menu_BackToTheFuture_OutaTime: TMenuItem;
    MenuItem3: TMenuItem;
    Menu_Bone_Boneville: TMenuItem;
    Menu_Bone_CowRace: TMenuItem;
    MenuItem4: TMenuItem;
    Menu_CSI_3Dimensions: TMenuItem;
    Menu_CSI_HardEvidence: TMenuItem;
    Menu_CSI_DeadlyIntent: TMenuItem;
    Menu_CSI_FatalConspiracy: TMenuItem;
    HectorBadgeOfCarnage1: TMenuItem;
    Menu_Hector_WeNegotiateWithTerrorists: TMenuItem;
    Menu_Hector_SenselessActsOfJustice: TMenuItem;
    Menu_Hector_BeyondReasonableDoom: TMenuItem;
    JurassicParkTheGame: TMenuItem;
    Menu_JurassicPark_EP1: TMenuItem;
    Menu_JurassicPark_EP2: TMenuItem;
    Menu_JurassicPark_EP3: TMenuItem;
    Menu_JurassicPark_EP4: TMenuItem;
    Menu_LawAndOrder_Legacies: TMenuItem;
    MenuPoker: TMenuItem;
    Menu_PokerNight_Inventory: TMenuItem;
    Menu_PokerNight_2: TMenuItem;
    MenuItem5: TMenuItem;
    Menu_PuzzleAgent_Scoggins: TMenuItem;
    Menu_PuzzleAgent_2: TMenuItem;
    MenuItem6: TMenuItem;
    Menu_SamAndMax_CultureShock: TMenuItem;
    Menu_SamAndMax_SituationComedy: TMenuItem;
    Menu_SamAndMax_MoleMobMeatball: TMenuItem;
    Menu_SamAndMax_AbeLincoln: TMenuItem;
    Menu_SamAndMax_Reality20: TMenuItem;
    Menu_SamAndMax_BrightSideMoon: TMenuItem;
    MenuItem7: TMenuItem;
    Menu_SamAndMax_IceStationSanta: TMenuItem;
    Menu_SamAndMax_MoaiBetterBlues: TMenuItem;
    Menu_SamAndMax_NightOfTheRavingDead: TMenuItem;
    Menu_SamAndMax_ChariotsOfTheDogs: TMenuItem;
    Menu_SamAndMax_WhatsNewBeelzebub: TMenuItem;
    MenuItem8: TMenuItem;
    Menu_SamAndMax_PenalZone: TMenuItem;
    Menu_SamAndMax_TombOfSammunMak: TMenuItem;
    Menu_SamAndMax_TheyStoleMaxsBrain: TMenuItem;
    Menu_SamAndMax_BeyondAlleyOfDolls: TMenuItem;
    Menu_SamAndMax_CityThatDaresNotSleep: TMenuItem;
    MenuItem9: TMenuItem;
    Menu_StrongBad_HomestarRuiner: TMenuItem;
    Menu_StrongBad_StrongBadiaTheFree: TMenuItem;
    Menu_StrongBad_BaddestOfTheBands: TMenuItem;
    Menu_StrongBad_Daneresque3: TMenuItem;
    Menu_StrongBad_8BitIsEnough: TMenuItem;
    TalesFromTheBorderlands1: TMenuItem;
    Menu_TalesFromBorderlands_Zer0Sum: TMenuItem;
    Menu_TalesFromBorderlands_AtlasMugged: TMenuItem;
    Menu_TalesFromBorderlands_CatchARide: TMenuItem;
    Menu_TalesFromBorderlands_EscapePlanBravo: TMenuItem;
    Menu_TalesFromBorderlands_TheVaultOfTheTraveler: TMenuItem;
    TalesOfMonkeyIsland1: TMenuItem;
    Menu_Monkey_ScreamingNarwhal: TMenuItem;
    Menu_Monkey_SpinnerCay: TMenuItem;
    Menu_Monkey_LairLeviathan: TMenuItem;
    Menu_Monkey_TrialExecution: TMenuItem;
    Menu_Monkey_PirateGod: TMenuItem;
    Menu_Texas_Holdem: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    Menu_WalkingDead_ANewDay: TMenuItem;
    Menu_WalkingDead_StarvedForHelp: TMenuItem;
    Menu_WalkingDead_LongRoadAhead: TMenuItem;
    Menu_WalkingDead_AroundEveryCorner: TMenuItem;
    Menu_WalkingDead_NoTimeLeft: TMenuItem;
    Menu_WalkingDead_400Days: TMenuItem;
    MenuItem12: TMenuItem;
    Menu_WalkingDead_S2_AllThatRemains: TMenuItem;
    Menu_WalkingDead_S2_AHouseDivided: TMenuItem;
    Menu_WalkingDead_S2_InHarmsWay: TMenuItem;
    Menu_WalkingDead_S2_AmidTheRuins: TMenuItem;
    Menu_WalkingDead_S2_NoGoingBack: TMenuItem;
    TheWolfAmongUs1: TMenuItem;
    Menu_WolfAmongUs_Faith: TMenuItem;
    Menu_WolfAmongUs_SmokeAndMirrors: TMenuItem;
    Menu_WolfAmongUs_ACrookedMile: TMenuItem;
    Menu_WolfAmongUs_InSheepsClothing: TMenuItem;
    Menu_WolfAmongUs_CryWolf: TMenuItem;
    WallaceandGromitsGrandAdventures1: TMenuItem;
    Menu_WallaceAndGromit_FrightOfTheBumblebees: TMenuItem;
    Menu_WallaceAndGromit_TheLastResort: TMenuItem;
    Menu_WallaceAndGromit_Muzzled: TMenuItem;
    Menu_WallaceAndGromit_TheBogeyMan: TMenuItem;
    Menu_PokerNight_Inventory_Uncensored: TMenuItem;
    FileOpenDialogFolder: TFileOpenDialog;
    OpenDialogFile: TOpenDialog;
    GameOfThrones2: TMenuItem;
    Menu_GameOfThrones_TheIceDragon: TMenuItem;
    Menu_GameOfThrones_ANestOfVipers: TMenuItem;
    Menu_GameOfThrones_SonsOfWinter: TMenuItem;
    Menu_GameOfThrones_TheSwordInTheDarkness: TMenuItem;
    Menu_GameOfThrones_TheLostLords: TMenuItem;
    Menu_GameOfThrones_IronFromIce: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: Integer);
    procedure TreeGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure btnSaveSingleAudioClick(Sender: TObject);
    procedure btnSaveAllAudioClick(Sender: TObject);
    procedure btnPlaySoundClick(Sender: TObject);
    procedure TreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormResize(Sender: TObject);
    procedure TreeDblClick(Sender: TObject);
    procedure TreeKeyPress(Sender: TObject; var Key: Char);
    procedure FilterPopupMenuHandler(Sender: TObject);
    procedure editFindChange(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure pnlBottomMinimize(Sender: TObject);
    procedure btnShowAnnotationPanelClick(Sender: TObject);
    procedure btnAnnotClearCategorySelectionClick(Sender: TObject);
    procedure btnAnnotAddCategoryClick(Sender: TObject);
    procedure editAnnotAnnotationExit(Sender: TObject);
    procedure btnAnnotSaveChangesClick(Sender: TObject);
    procedure btnAnnotUndoChangesClick(Sender: TObject);
    procedure editAnnotAnnotationKeyPress(Sender: TObject; var Key: Char);
    procedure comboboxAnnotCategoryChange(Sender: TObject);
    procedure TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure OpenPopupMenuHandler(Sender: TObject);
  private
    fChosenGame: TTelltaleGame;
    SpeechExtractor: TExplorerBaseDumper;
    MyPopUpItems: array of TMenuItem;
    procedure DoLog(logitem: string);
    procedure EnableDisableButtonsGlobal(Value: boolean);
    procedure EnableDisableButtons_TreeDependant;
    procedure OnProgress(ProgressMax: integer; ProgressPos: integer);
    procedure OnDebug(DebugText: string);
    procedure OnDoneLoading(RootNodeCount: integer);
    procedure FreeResources;
    procedure OpenSpeechFolder(FileOrFolder: string);
    procedure FilterNodes(Category: string);
    procedure ViewAllNodes;
    procedure AddFilterPopupItems;
    procedure SaveAllAudioAudioFiles(OnlySaveVisible: boolean; SaveAs: TAudioFormat);
    procedure FillAnnotationControls(NodeIndex: integer);
    function GetAnnotationFolder: string;
    function IsViewFilteredByCategory: boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses formAbout;

{$R *.dfm}


{******************   General form/button click stuff   ******************}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  EditFind.Font.Size:=20;

  dlgBrowseforSavefolder.RootDirectory:=fdDesktopDirectory;
  dlgBrowseforSavefolder.RootDirectoryPath:=GetDesktopDirectoryFolder;
  dlgBrowseforOpenfolder.RootDirectory:=fdDesktopDirectory;
  dlgBrowseforOpenfolder.RootDirectoryPath:=GetDesktopDirectoryFolder;
  SaveDialog1.InitialDir:=GetDesktopDirectoryFolder;

  StatusBar.Panels[0].Text := strAppTitle + ' ' + strAppVersion;

  {$ifdef DEBUGMODE}
    btnAbout.Caption:='DEBUG';
  {$endif}
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeResources;
end;

procedure TfrmMain.FreeResources;
var
  i: integer;
begin
  editFind.Text:='';
  tree.Clear;

  //if invalid files are opened twice in succession then none of the resources below
  //are created so need to check if they are nil
  if SpeechExtractor <> nil then
    freeandnil(SpeechExtractor);

  if MyPopUpItems <> nil then
  begin
    for i:=low(mypopupitems) to high(mypopupitems) do
      mypopupitems[i].Free;

    MyPopUpItems:=nil;
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  StatusBar.Panels[0].Enabled:=false; //stops statusbar text going wonky on vista
  StatusBar.Panels[0].Enabled:=true;
end;

procedure TfrmMain.pnlBottomMinimize(Sender: TObject);
begin
  pnlBottom.Visible:=false;
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
  {$ifdef DEBUGMODE}
var
  OutputFile: Tstringlist;
  i: integer;
  {$endif}
begin
  {$ifdef DEBUGMODE}
  if Tree.RootNodeCount <= 0 then
  begin
    DoLog(strNoFilesLoaded);
    exit;
  end;

  OutputFile:=Tstringlist.Create;
  try
    EnableDisableButtonsGlobal(false);

    OutputFile.Add(SpeechExtractor.Debug_GetGameAndPathInfo);
    OutputFile.Add('');
    OutputFile.Add(strStartedAt + datetimetostr(Now));
    OutputFile.Add('');

    for I := 0 to tree.RootNodeCount - 1 do
    begin
      OutputFile.Add(SpeechExtractor.Debug_GenerateVoxInfoString(i));
      OutputFile.Add('');
    end;  

    OutputFile.Add(strEndedAt + datetimetostr(Now));

    OutputFile.SaveToFile(ExtractFilePath(Application.Exename) + '\' + 'DEBUG_INFO_' + SpeechExtractor.Debug_GetAnnotGameName + '.txt');
  finally
    OutputFile.Free;
    EnableDisableButtonsGlobal(true);
  end;

  {$else}
    frmAbout.ShowModal;
  {$endif}
end;

procedure TfrmMain.OpenSpeechFolder(FileOrFolder: string);
begin
  if FileExists(FileOrFolder) then //Its a file
  else //Its a folder - check if it actually exists
  if DirectoryExists(FileOrFolder)=false then
  begin
    DoLog(strFolderNotFound);
    exit;
  end;

  FreeResources;
  try
    if FileExists(FileOrFolder) then //Single file mode
      SpeechExtractor:=TExplorerBaseDumper.Create(IncludeTrailingPathDelimiter(GetAnnotationFolder), OnDebug, fChosenGame, FileOrFolder)
    else //Folder mode
      SpeechExtractor:=TExplorerBaseDumper.Create(IncludeTrailingPathDelimiter(FileOrFolder), IncludeTrailingPathDelimiter(GetAnnotationFolder), OnDebug, fChosenGame);
    try
      EnableDisableButtonsGlobal(false);
      SpeechExtractor.OnDebug:=OnDebug;
      SpeechExtractor.OnProgress:=OnProgress;
      SpeechExtractor.OnDoneLoading:=OnDoneLoading;
      Tree.Clear;
      SpeechExtractor.ParseFiles;
      Tree.Header.AutoFitColumns(true);
      AddFilterPopupItems;
    finally
      EnableDisableButtonsGlobal(true);
    end;
  except
    on E: EBundleReaderException do
      DoLog(E.Message);
    on E: EResourceDetectorError do
      MessageDlg(E.Message, mtError, [mbOk], 0)
  end;
end;

procedure TfrmMain.EnableDisableButtonsGlobal(Value: boolean);
begin
  btnOpen.Enabled:=value;
  btnSaveSingleAudio.Enabled:=value;
  btnSaveAllAudio.Enabled:=value;
  tree.Enabled:=value;
  btnPlaySound.Enabled:=value;
  btnFilterView.Enabled:=value;
  btnAbout.Enabled:=value;
  editFind.Enabled:=value;
  pnlBottom.Enabled:=value;
  editAnnotFilename.Enabled:=value;
  editAnnotAnnotation.Enabled:=value;
  comboboxAnnotCategory.Enabled:=value;
  lblAnnotCategory.Enabled:=value;
  btnAnnotClearCategorySelection.Enabled:=value;
  btnAnnotAddCategory.Enabled:=value;
  btnShowAnnotationPanel.Enabled:=value;
  btnAnnotSaveChanges.Enabled:=value;
  btnAnnotUndoCHanges.Enabled:=value;

  if Value = true then
    EnableDisableButtons_TreeDependant;
end;

procedure TfrmMain.EnableDisableButtons_TreeDependant;
begin
  if Tree.RootNodeCount > 0 then
    btnSaveAllAudio.Enabled:=true
  else
    btnSaveAllAudio.Enabled:=false;


  if Tree.SelectedCount > 0 then
  begin
    btnSaveSingleAudio.Enabled:=true;
    btnPlaySound.Enabled:=true;
    editAnnotFilename.Enabled:=true;
    editAnnotAnnotation.Enabled:=true;
    comboboxAnnotCategory.Enabled:=true;
    lblAnnotCategory.Enabled:=true;
    btnAnnotClearCategorySelection.Enabled:=true;
    btnAnnotAddCategory.Enabled:=true;
    btnAnnotSaveChanges.Enabled:=true;
    btnAnnotUndoCHanges.Enabled:=true;
  end
  else
  begin
    btnSaveSingleAudio.Enabled:=false;
    btnPlaySound.Enabled:=false;
    editAnnotFilename.Enabled:=false;
    editAnnotAnnotation.Enabled:=false;
    comboboxAnnotCategory.Enabled:=false;
    lblAnnotCategory.Enabled:=false;
    btnAnnotClearCategorySelection.Enabled:=false;
    btnAnnotAddCategory.Enabled:=false;
    btnAnnotSaveChanges.Enabled:=false;
    btnAnnotUndoCHanges.Enabled:=false;
  end;
end;

procedure TfrmMain.editFindChange(Sender: TObject);
var
  i, FoundPos: integer;
  temp, prevnode: pvirtualnode;
begin
  //sometimes it still has focus when view is filtered by category
  if (editFind.Focused = false) then exit;

  if EditFind.Text = '' then
  begin
    // If view is filtered and someone clicks in the search box and out again without typing
    // anything , we dont want the view to change to show all nodes
    if IsViewFilteredByCategory = false then
      ViewAllNodes;

    exit;
  end;

  //Remove tick from all items
  for I := 0 to AdvPopupMenuFilter.Items.Count -1 do
  begin
    AdvPopupMenuFilter.Items[i].Checked:=false;
  end;

  tree.BeginUpdate;
  //Make them all visible again
  ViewAllNodes;

  temp:=tree.getfirst;
  for i:=0 to tree.rootnodecount -1 do
  begin
    FoundPos:=pos(uppercase(EditFind.Text) , uppercase(SpeechExtractor.FileNamesArray[temp.index]));
    if FoundPos=0 then //search annotation
      FoundPos:=pos(uppercase(EditFind.Text) , uppercase(SpeechExtractor.Annotation_Annotation_Array[temp.index]));

    if FoundPos > 0 then
    begin
      tree.IsVisible[temp]:=true;
    end
    else
      tree.IsVisible[temp]:=false;

    prevnode:=temp;
    temp:=tree.GetNext(prevnode);
  end;

  tree.EndUpdate;
end;

procedure TfrmMain.DoLog(LogItem: string);
begin
  StatusBar.Panels[0].Text:=LogItem;
end;




{******************   Sound Play/Save Stuff   ******************}

procedure TfrmMain.btnPlaySoundClick(Sender: TObject);
begin
  if Tree.RootNodeCount=0 then exit;
  if Tree.SelectedCount=0 then exit;

  SpeechExtractor.PlayAudio(Tree.focusednode.Index);
end;

procedure TfrmMain.btnSaveSingleAudioClick(Sender: TObject);
var
  FileName: string;
begin
  if Tree.RootNodeCount=0 then exit;
  if Tree.SelectedCount=0 then exit;


  FileName:=SpeechExtractor.FileNamesArray[Tree.focusednode.Index];

  SaveDialog1.FileName:=PathExtractFileNameNoExt(filename) ;
  if SaveDialog1.Execute = false then exit;

  DoLog(strSavingAudio  + ExtractFileName(SaveDialog1.FileName) + '...');
  EnableDisableButtonsGlobal(false);
  try
    case SaveDialog1.FilterIndex of
      1: SpeechExtractor.SaveAudioFile(Tree.focusednode.Index, ExtractFilePath(SaveDialog1.FileName), extractfilename(SaveDialog1.FileName), AUTOSELECT);
      2: SpeechExtractor.SaveAudioFile(Tree.focusednode.Index, ExtractFilePath(SaveDialog1.FileName), extractfilename(SaveDialog1.FileName), WAV);
      3: SpeechExtractor.SaveAudioFile(Tree.focusednode.Index, ExtractFilePath(SaveDialog1.FileName), extractfilename(SaveDialog1.FileName), OGG);
      4: SpeechExtractor.SaveAudioFile(Tree.focusednode.Index, ExtractFilePath(SaveDialog1.FileName), extractfilename(SaveDialog1.FileName), MP3);
    else
      DoLog(strUnknownSaveType);
      exit;
    end;

    DoLog(strDone);
  finally
    EnableDisableButtonsGlobal(true);
    StatusBar.Panels[1].Progress.Position:=0;
  end;
end;

procedure TfrmMain.btnSaveAllAudioClick(Sender: TObject);
var
  ExecuteResult, RadioButtonResult: integer;
  Format: TAudioFormat;
begin
  ExecuteResult:=TaskDialogSaveFiles.Execute;
  RadioButtonResult:=TaskDialogSaveFiles.RadioButtonResult;

  case RadioButtonResult of
    200:  Format:=AUTOSELECT;
    201:  Format:=WAV;
    202:  Format:=OGG;
    203:  Format:=MP3;
  else
    DoLog(strUnknownSaveType);
    Exit;
  end;

  case ExecuteResult of
    2:    Exit; //Cancel was pressed
    100:  SaveAllAudioAudioFiles(False, Format);
    101:  begin
            if Tree.VisibleCount=0 then
              DoLog(strNoFilesToSave)
            else
              SaveAllAudioAudioFiles(true, Format);
          end
    else
          exit;
  end;
end;

procedure TfrmMain.SaveAllAudioAudioFiles(OnlySaveVisible: boolean; SaveAs: TAudioFormat);
var
  VisibleArray: array of integer;
  i: integer;
  TheNode, tempnode: pvirtualnode;
begin
  if Tree.RootNodeCount=0 then exit;
  if dlgBrowseforSaveFolder.Execute = false then exit;

  EnableDisableButtonsGlobal(false);
  try
    if OnlySaveVisible=false then
    begin
      DoLog(strSavingAllAudio);
      SpeechExtractor.SaveAllAudioFiles(dlgBrowseForSaveFolder.Directory, SaveAs);
    end
    else
    begin
      if Tree.VisibleCount=0 then exit;
      DoLog(strSavingAllVisibleAudio);

      Setlength(VisibleArray, Tree.VisibleCount);

      TheNode := nil;
      for I := 0 to High(VisibleArray) do
      begin
        if i = 0 then TheNode:=Tree.GetFirstVisible
        else
        begin
          TempNode:=Tree.GetNextVisible(TheNode);
          TheNode:=TempNode;
        end;

        VisibleArray[i]:=TheNode.Index;
      end;

      SpeechExtractor.SaveSpecifiedAudioFiles(dlgBrowseForSaveFolder.Directory, VisibleArray, SaveAs);
      VisibleArray := nil;
    end;
  finally
    EnableDisableButtonsGlobal(true);
    DoLog(strDone);
    StatusBar.Panels[1].Progress.Position:=0;
  end;
end;



{******************   Category Filtering Stuff   ******************}

function TfrmMain.IsViewFilteredByCategory: boolean;
var
  i: integer;
begin
  result:=false;
  for I := 0 to AdvPopupMenuFilter.Items.Count -1 do
  begin
    if AdvPopupMenuFilter.Items[i].Checked then
      result:=true;
  end;
end;

procedure TfrmMain.FilterNodes(Category: string);
var
  i: integer;
  prevnode, tempnode: pvirtualnode;
begin
  if Tree.RootNodeCount=0 then exit;

  Tree.BeginUpdate;
  try
    prevnode:=Tree.GetFirst;
    if SpeechExtractor.Annotation_Category_Array[prevnode.Index]=Category then
      Tree.IsVisible[prevnode]:=true
    else
      Tree.IsVisible[prevnode]:=false;
    for i:=0 to Tree.RootNodeCount -2 do
    begin
      if SpeechExtractor.Annotation_Category_Array[prevnode.index + 1]=Category then
        Tree.IsVisible[Tree.GetNext(prevnode)]:=true
      else
        Tree.IsVisible[Tree.GetNext(prevnode)]:=false;

      tempnode:=Tree.GetNext(prevnode);
      prevnode:=tempnode;
    end;
    Tree.Selected [Tree.focusednode]:=false;
  finally
    Tree.EndUpdate;
  end;

end;

procedure TfrmMain.ViewAllNodes;
var
  i: integer;
  prevnode, tempnode: pvirtualnode;
begin
  if Tree.RootNodeCount=0 then exit;

  Tree.BeginUpdate;
  try
    prevnode:=Tree.GetFirst;
    Tree.IsVisible[prevnode]:=true;
    for i:=0 to Tree.RootNodeCount -2 do
    begin
      Tree.IsVisible[Tree.GetNext(prevnode)]:=true;
      tempnode:=Tree.GetNext(prevnode);
      prevnode:=tempnode;
    end;
    Tree.Selected [Tree.focusednode]:=false;
  finally
    Tree.EndUpdate;
  end;

end;

procedure TfrmMain.FilterPopupMenuHandler(Sender: TObject);
var
  temp: string;
  i: integer;
begin
  if Tree.RootNodeCount=0 then exit;

  editFind.Text:=''; //doing editFind.clear doesnt show the 'search' default text
  tree.SetFocus; //take the focus away from the search editbox if it has it

  with Sender as TMenuItem do
  begin
    temp:=caption;
    StrReplace(temp, '&', '',[rfIgnoreCase, rfReplaceAll]);
    if temp = strNoCategory then
      FilterNodes('')
    else
    if temp = 'View all files' then
      ViewAllNodes
    else
      FilterNodes(temp);

    DoLog('Filtered view by category: ' + temp);
  end;

  //Remove tick from all items
  for I := 0 to AdvPopupMenuFilter.Items.Count -1 do
  begin
    AdvPopupMenuFilter.Items[i].Checked:=false;
  end;

  //Add tick to the item
  with Sender as TMenuItem do
  begin
    AdvPopupMenuFilter.Items[tag].Checked:=true;
  end;
end;

procedure TfrmMain.AddFilterPopupItems;
var
  AvailableCategories: TStringList;
  temp: string;
  i: integer;
begin
  AvailableCategories:=TStringList.Create;
  try
    //Loop through the categories and them to the string list
    for i:=0 to tree.RootNodeCount -1 do
    begin
      temp:=SpeechExtractor.Annotation_Category_Array[i];
      if temp = ''  then temp:=strNoCategory;

      //See if its already in the list, if its not add it.
      if AvailableCategories.IndexOf(temp) = -1 then
        AvailableCategories.Add(temp);
    end;
    AvailableCategories.Sort;

    //Add categories to the hidden annotation edit combobox
    comboboxAnnotCategory.Clear;
    comboboxAnnotCategory.Items.AddStrings(AvailableCategories);
    //Now remove the 'No category' item from the combobox
    i:=comboboxAnnotCategory.Items.IndexOf(strNoCategory);
    if i > -1 then comboboxAnnotCategory.Items.Delete(i);


    //Now add the popups
    setlength(MyPopupItems, AvailableCategories.Count + 2); //+2 for 'all files' and line break
    for i:=low(mypopupitems) to high(mypopupitems)-2 do
    begin
      MyPopUpItems[i]:=TMenuItem.Create(Self);
      MyPopUpItems[i].Caption:=AvailableCategories[i];
      MyPopUpItems[i].tag:=i + 2;
      AdvPopupMenuFilter.Items.add(MyPopupItems[i]);
      MyPopUpItems[i].OnClick:=FilterPopupMenuHandler;

      //icons
      //MyPopUpItems[i].ImageIndex:=GetImageIndex(FileTypes[i]);
    end;

    //Add 'All files' menu item
    i:=high(mypopupitems);
    MyPopUpItems[i]:=TMenuItem.Create(Self);
    MyPopUpItems[i].Caption:=strViewAllFiles;
    MyPopUpItems[i].tag:=0;
    MyPopUpItems[i].Checked:=true;
    //MyPopUpItems[i].ImageIndex:=5;
    AdvPopupMenuFilter.Items.Insert(0, MyPopUpItems[i]);
    MyPopUpItems[i].OnClick:=FilterPopupMenuHandler;

    //Add line break menu item
    i:=high(mypopupitems)-1;
    MyPopUpItems[i]:=TMenuItem.Create(Self);
    MyPopUpItems[i].Caption:='-';
    MyPopUpItems[i].tag:=1;
    MyPopUpItems[i].Checked:=true;
    //MyPopUpItems[i].ImageIndex:=5;
    AdvPopupMenuFilter.Items.Insert(1, MyPopUpItems[i]);
  finally
    AvailableCategories.Free;
  end;
end;





{******************   Tree Stuff   ******************}

procedure TfrmMain.TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
  case Column of
    0: Celltext:= SpeechExtractor.Annotation_Category_Array[node.index];
    1: Celltext:= SpeechExtractor.Annotation_Annotation_Array[node.index];
    2: Celltext:= SpeechExtractor.Annotation_AudioLength_Array[node.index];
    3: Celltext := SpeechExtractor.FileNamesArray[node.index];
  end;
end;

procedure TfrmMain.TreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if column <> 0 then exit;
  if Kind = ikOverlay then exit;

  if column=0 then
    ImageIndex:=5;
end;

procedure TfrmMain.TreeKeyPress(Sender: TObject; var Key: Char);
begin
  if Tree.SelectedCount=0 then exit;

  if key = #13 then
    btnPlaySound.Click;
end;

procedure TfrmMain.TreeGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := 0;
end;

procedure TfrmMain.TreeDblClick(Sender: TObject);
begin
  if Tree.SelectedCount=0 then exit;

  btnPlaySound.Click;
end;


procedure TfrmMain.TreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  EnableDisableButtons_TreeDependant;

  if tree.SelectedCount=0 then exit;
  if pnlBottom.Visible=false then exit;

  FillAnnotationControls(tree.FocusedNode.Index);
end;






{******************   Annotation Stuff   ******************}

function TfrmMain.GetAnnotationFolder: string;
var
  strDir: string;
begin
  strdir:=ExtractFilePath(Application.ExeName) + 'Annotations';
  if DirectoryExists(strDir) then
    result:=StrDir
  else
    result:='';
end;

procedure TfrmMain.btnAnnotAddCategoryClick(Sender: TObject);
var
  value: string;
begin
  Value:=InputBox(strAddNewCategory, strCategoryName, '');
  if Value <> '' then
  begin
    comboBoxAnnotCategory.Items.Add(Value);
    comboBoxAnnotCategory.Sorted:=true;
  end;
end;

procedure TfrmMain.btnAnnotClearCategorySelectionClick(Sender: TObject);
begin
  comboboxAnnotCategory.ItemIndex:=-1;
  SpeechExtractor.WriteAnnotation(tree.FocusedNode.Index, comboboxAnnotCategory.Text, AFCategory);
  tree.RepaintNode(Tree.FocusedNode);
end;

procedure TfrmMain.btnAnnotSaveChangesClick(Sender: TObject);
begin
  editAnnotAnnotation.OnExit(frmMain);    //if focus is on control and save button is pressed
  comboboxAnnotCategory.OnChange(frmMain);
  SpeechExtractor.SaveAnnotationChanges;
end;

procedure TfrmMain.btnAnnotUndoChangesClick(Sender: TObject);
begin
  editAnnotAnnotation.OnExit(frmMain);    //if focus is on control and button is pressed
  comboboxAnnotCategory.OnChange(frmMain);  //onexit doesnt always fire
  SpeechExtractor.ReloadAnnotations;
  if tree.SelectedCount > 0 then
    FillAnnotationControls(tree.FocusedNode.Index);
  Tree.Repaint;
end;

procedure TfrmMain.btnShowAnnotationPanelClick(Sender: TObject);
begin
  if btnShowAnnotationPanel.Down then
  begin
    pnlBottom.Enabled:=true;
    pnlBottom.Visible:=true;
    if tree.SelectedCount > 0 then
      FillAnnotationControls(tree.FocusedNode.Index);
  end
  else
  begin
    pnlBottom.Enabled:=false;
    pnlBottom.Visible:=false;
  end;
end;

procedure TfrmMain.comboboxAnnotCategoryChange(Sender: TObject);
begin
  SpeechExtractor.WriteAnnotation(tree.FocusedNode.Index, comboboxAnnotCategory.Text, AFCategory);
  tree.RepaintNode(Tree.FocusedNode);
end;

procedure TfrmMain.editAnnotAnnotationExit(Sender: TObject);
begin
  SpeechExtractor.WriteAnnotation(tree.FocusedNode.Index, editAnnotAnnotation.Text, AFAnnotation);
  tree.RepaintNode(Tree.FocusedNode);
end;

procedure TfrmMain.editAnnotAnnotationKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then editAnnotAnnotation.OnExit(frmMain);
end;

procedure TfrmMain.FillAnnotationControls(NodeIndex: integer);
begin
  if tree.SelectedCount = 0 then exit;

  editAnnotFilename.Text:=SpeechExtractor.FileNamesArray[NodeIndex];
  comboboxAnnotCategory.ItemIndex:=comboboxAnnotCategory.Items.IndexOf(SpeechExtractor.Annotation_Category_Array[NodeIndex]);
  //comboboxAnnotCategory.Text:=Dumper.Annotation_Category_Array[Dumper.FileNamesArray[NodeIndex]];
  editAnnotAnnotation.Text:=SpeechExtractor.Annotation_Annotation_Array[NodeIndex];
end;



{******************   Custom Events   ******************}

procedure TfrmMain.OnDebug(DebugText: string);
begin
  DoLog(DebugText);
end;


procedure TfrmMain.OnDoneLoading(RootNodeCount: integer);
begin
  Tree.RootNodeCount:=RootNodeCount;
end;


procedure TfrmMain.OnProgress(ProgressMax: integer; ProgressPos: integer);
begin
  StatusBar.Panels[1].Progress.Max:=ProgressMax;
  StatusBar.Panels[1].Progress.Position:=(ProgressPos * 100) div ProgressMax;
end;




{******************   Open Menu Popup Handlers   ******************}
procedure TfrmMain.OpenPopupMenuHandler(Sender: TObject);
var
  SenderName, strFolder: string;
begin
  SenderName := TMenuItem(Sender).Name;
  fChosenGame := UnknownGame; //Only need to know the game for latest games

  if SenderName = 'MenuOpenFile' then
  begin
    if OpenDialogFile.Execute = false then exit;
    strFolder := OpenDialogFile.FileName;
    SenderName := 'Opened file ' + ExtractFileName(OpenDialogFile.FileName);
  end
  else
  if SenderName = 'MenuOpenFolder' then
  begin
    if Win32MajorVersion >= 6 then //Vista and above
    begin
      FileOpenDialogFolder.Title := strOpenDialogTitle;
      if FileOpenDialogFolder.Execute then
        strFolder := FileOpenDialogFolder.FileName;
    end
    else
    begin
      dlgBrowseForOpenFolder.Title := strOpenDialogTitle;
      if dlgBrowseForOpenFolder.Execute then
        strFolder := dlgBrowseForOpenFolder.Directory;
    end
  end
  else
  if SenderName = 'Menu_CSI_DeadlyIntent' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_DeadlyIntent);

    dlgBrowseForOpenFolder.Directory := strFolder;
    FileOpenDialogFolder.DefaultFolder := strFolder;

    MessageDlg(strCSIDeadlyIntent, mtInformation, [mbOk], 0);
  end
  else
  if SenderName = 'Menu_CSI_FatalConspiracy' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_FatalConspiracy);

    dlgBrowseForOpenFolder.Directory := strFolder;
    FileOpenDialogFolder.DefaultFolder := strFolder;

    MessageDlg(strCSIFatalConspiracy, mtInformation, [mbOk], 0);
  end
  else
  if SenderName = 'Menu_PokerNight_Inventory_Uncensored' then
  begin
    strFolder:=GetTelltaleGamePath(PokerNight_Inventory) + 'Localized\uncensored_english\';
    SenderName := strAfter('Menu_', SenderName);
  end
  else
  begin
    SenderName := strAfter('Menu_', SenderName);
    if SenderName = '' then MessageDlg(strMissingMenu, mtError, [mbOk], 0);

    //fChosenGame only really used by newest .ttartch2 games
    fChosenGame := TTelltaleGame(GetEnumValue(TypeInfo(TTelltaleGame), SenderName));

    //Games that need the music param for GetTelltaleGamePath
    if (SenderName = 'CSI_3Dimensions')
    then
      strFolder:=GetTelltaleGamePath(fChosenGame, Music)
    else
    //Games that need the voice param for GetTelltaleGamePath
    if (SenderName = 'CSI_HardEvidence') or
       (SenderName = 'SamAndMax_IceStationSanta') or
       (SenderName = 'SamAndMax_MoaiBetterBlues') or
       (SenderName = 'SamAndMax_NightOfTheRavingDead') or
       (SenderName = 'SamAndMax_ChariotsOfTheDogs') or
       (SenderName = 'SamAndMax_WhatsNewBeelzebub')
    then
      strFolder:=GetTelltaleGamePath(fChosenGame, Voice)
    else
      strFolder:=GetTelltaleGamePath(fChosenGame);
  end;

  OpenSpeechFolder(strFolder);

  if (Tree.RootNodeCount > 0) {and (DirectoryExists(strFolder))} then
    DoLog(strOpened + SenderName);
end;

end.
