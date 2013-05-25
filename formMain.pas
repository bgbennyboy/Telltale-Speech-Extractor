{
******************************************************
  Telltale Speech Extractor
  Copyright (c) 2007 - 2013 Bennyboy
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
  Dialogs, StdCtrls, ImgList, ComCtrls, ExtCtrls, Menus, XPMan,

  JvMenus, JvBaseDlg, JvBrowseFolder, JvExStdCtrls, JvRichEdit, JvExExtCtrls,
  JvExtComponent, JvPanel, JvEdit, JvHtControls,

  VirtualTrees, PngImageList,

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
    PngImageList1: TPngImageList;
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
    popupOpen: TAdvPopupMenu;
    MenuItemOpenFolder: TMenuItem;
    N2: TMenuItem;
    Bone1: TMenuItem;
    MenuItemOpenBone1: TMenuItem;
    MenuItemOpenBone2: TMenuItem;
    CrimeSceneInvestigation1: TMenuItem;
    MenuItemOpenCSI: TMenuItem;
    MenuItemOpenCSIHardEvidence: TMenuItem;
    SamAndMaxSeason11: TMenuItem;
    MenuItemOpenCultureShock: TMenuItem;
    MenuItemOpenSituationComedy: TMenuItem;
    MenuItemOpenMoleMobMeatball: TMenuItem;
    MenuItemOpenAbeLincoln: TMenuItem;
    MenuItemOpenReality20: TMenuItem;
    MenuItemOpenBrightSideOfTheMoon: TMenuItem;
    SamAndMaxSeason21: TMenuItem;
    MenuItemOpenIceStationSanta: TMenuItem;
    MenuItemOpenMoaiBetterBlues: TMenuItem;
    MenuItemOpenNightOfTheRavingDead: TMenuItem;
    MenuItemOpenChariotsoftheDogs: TMenuItem;
    MenuItemOpenWhatsNewBeelzebub: TMenuItem;
    StrongBadSeason11: TMenuItem;
    MenuItemOpenStrongBadEP1: TMenuItem;
    MenuItemOpenStrongBadEP2: TMenuItem;
    MenuItemOpenStrongBadEP3: TMenuItem;
    MenuItemOpenStrongBadEP4: TMenuItem;
    MenuItemOpenStrongBadEP5: TMenuItem;
    alesOfMonkeyIsland1: TMenuItem;
    MenuItemOpenMonkeyEP1: TMenuItem;
    MenuItemOpenMonkeyEP2: TMenuItem;
    MenuItemOpenMonkeyEP3: TMenuItem;
    MenuItemOpenMonkeyEP4: TMenuItem;
    MenuItemOpenMonkeyEP5: TMenuItem;
    MenuItemOpenTexas: TMenuItem;
    WallaceAndGromitS1: TMenuItem;
    MenuItemOpenWallaceEP1: TMenuItem;
    MenuItemOpenWallaceEP2: TMenuItem;
    MenuItemOpenWallaceEP3: TMenuItem;
    MenuItemOpenWallaceEP4: TMenuItem;
    MenuItemOpenCSIDeadlyIntent: TMenuItem;
    SamAndMaxSeason31: TMenuItem;
    MenuItemOpenSamNMax305: TMenuItem;
    MenuItemOpenSamNMax304: TMenuItem;
    MenuItemOpenSamNMax303: TMenuItem;
    MenuItemOpenSamNMax302: TMenuItem;
    MenuItemOpenSamNMax301: TMenuItem;
    PuzzleAgent1: TMenuItem;
    MenuItemOpenPuzzleAgentScoggins: TMenuItem;
    PokerNight: TMenuItem;
    MenuItemOpenCSIFatalConspiracy: TMenuItem;
    MenuItemOpenPokerInventory: TMenuItem;
    MenuItemOpenPokerInventory_Uncensored: TMenuItem;
    BackToTheFuture2: TMenuItem;
    MenuItemOpenBTTF5: TMenuItem;
    MenuItemOpenBTTF4: TMenuItem;
    MenuItemOpenBTTF3: TMenuItem;
    MenuItemOpenBTTF2: TMenuItem;
    MenuItemOpenBTTF1: TMenuItem;
    Hector1: TMenuItem;
    MenuItemHector101: TMenuItem;
    MenuItemOpenPuzzleAgent2: TMenuItem;
    MenuItemHector103: TMenuItem;
    MenuItemHector102: TMenuItem;
    JurassicParkTheGame1: TMenuItem;
    MenuItemJurassicPark104: TMenuItem;
    MenuItemJurassicPark103: TMenuItem;
    MenuItemJurassicPark102: TMenuItem;
    MenuItemJurassicPark101: TMenuItem;
    MenuItemOpenLawAndOrderLegacies: TMenuItem;
    MenuItemWalkingDeadS1: TMenuItem;
    MenuItemOpenWalkingDead102: TMenuItem;
    MenuItemOpenWalkingDead101: TMenuItem;
    MenuItemOpenWalkingDead103: TMenuItem;
    MenuItemOpenWalkingDead104: TMenuItem;
    MenuItemOpenWalkingDead105: TMenuItem;
    MenuItemOpenPoker2: TMenuItem;
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
    SpeechExtractor: TExplorerBaseDumper;
    MyPopUpItems: array of TMenuItem;
    procedure DoLog(logitem: string);
    procedure EnableDisableButtonsGlobal(Value: boolean);
    procedure EnableDisableButtons_TreeDependant;
    procedure OnProgress(ProgressMax: integer; ProgressPos: integer);
    procedure OnDebug(DebugText: string);
    procedure OnDoneLoading(RootNodeCount: integer);
    procedure FreeResources;
    procedure OpenSpeechFolder(Folder: string);
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

procedure TfrmMain.OpenSpeechFolder(Folder: string);
begin
  if DirectoryExists(Folder)=false then
  begin
    DoLog(strFolderNotFound);
    exit;
  end;

  FreeResources;
  try
    SpeechExtractor:=TExplorerBaseDumper.Create(IncludeTrailingPathDelimiter(Folder), IncludeTrailingPathDelimiter(GetAnnotationFolder), OnDebug);
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
  except on E: EBundleReaderException do
    DoLog(E.Message);
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
  SenderName, strFolder, strOpenedGame: string;
begin
  SenderName := tmenuitem(sender).Name;

  strFolder:='';
  strOpenedGame:='';

  if SenderName = 'MenuItemOpenFolder' then
  begin
    if dlgBrowseForOpenFolder.Execute then
    begin
      strFolder:=dlgBrowseForOpenFolder.Directory;
      strOpenedGame:=dlgBrowseForOpenFolder.Directory;
    end;
  end
  else
  if SenderName = 'MenuItemOpenBone1' then
  begin
    strFolder:=GetTelltaleGamePath(Bone_Boneville);
    strOpenedGame:='Bone Out From Boneville';
  end
  else
  if SenderName = 'MenuItemOpenBone2' then
  begin
    strFolder:=GetTelltaleGamePath(Bone_CowRace);
    strOpenedGame:='Bone The Great Cow Race';
  end
  else
  if SenderName = 'MenuItemOpenCSI' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_3Dimensions, Music);
    strOpenedGame:='CSI 3 Dimensions of Murder';
  end
  else
  if SenderName = 'MenuItemOpenCSIHardEvidence' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_HardEvidence, Voice);
    strOpenedGame:='CSI Hard Evidence';
  end
  else
  if SenderName = 'MenuItemOpenCSIDeadlyIntent' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_DeadlyIntent);
    strOpenedGame:='CSI Deadly Intent';

    dlgBrowseForOpenFolder.Directory := strFolder;

    ShowMessage('CSI Deadly Intent has the audio for each of its 5 parts stored in separate folders. ' +
                'You''ll need to load the speech from each part manually.' + #13#13 +
                'To do this click "Open Folder", scroll down to the "Pack" folder, select one of the CSI5 folders and click the "Go" button.'
                + #13#13 +
                'For example, select the CSI501 folder to load speech from the first part.');

  end
  else
  if SenderName = 'MenuItemOpenCSIFatalConspiracy' then
  begin
    strFolder:=GetTelltaleGamePath(CSI_FatalConspiracy);
    strOpenedGame:='CSI Fatal Conspiracy';

    dlgBrowseForOpenFolder.Directory := strFolder;

    ShowMessage('CSI Fatal Conspiracy has the audio for each of its 5 parts stored in separate folders. ' +
                'You''ll need to load the speech from each part manually.' + #13#13 +
                'To do this click "Open Folder", scroll down to the "Pack" folder, select one of the CSI6 folders and click the "Go" button.'
                + #13#13 +
                'For example, select the CSI601 folder to load speech from the first part.');

  end
  else
  if SenderName = 'MenuItemOpenCultureShock' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_CultureShock);
    strOpenedGame:='Sam and Max Culture Shock';
  end
  else
  if SenderName = 'MenuItemOpenSituationComedy' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_SituationComedy);
    strOpenedGame:='Sam and Max Situation Comedy';
  end
  else
  if SenderName = 'MenuItemOpenMoleMobMeatball' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_MoleMobMeatball);
    strOpenedGame:='Sam and Max The Mole the Mob and the Meatball';
  end
  else
  if SenderName = 'MenuItemOpenAbeLincoln' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_AbeLincoln);
    strOpenedGame:='Sam and Max Abe Lincoln Must Die';
  end
  else
  if SenderName = 'MenuItemOpenReality20' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_Reality20);
    strOpenedGame:='Sam and Max Reality 2.0';
  end
  else
  if SenderName = 'MenuItemOpenBrightSideOfTheMoon' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_BrightSideMoon);
    strOpenedGame:='Sam and Max Bright Side of the Moon';
  end
  else
  if SenderName = 'MenuItemOpenIceStationSanta' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_IceStationSanta, Voice);
    strOpenedGame:='Sam and Max Ice Station Santa';
  end
  else
  if SenderName = 'MenuItemOpenMoaiBetterBlues' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_MoaiBetterBlues, Voice);
    strOpenedGame:='Sam and Max Moai Better Blues';
  end
  else
  if SenderName = 'MenuItemOpenNightOfTheRavingDead' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_NightOfTheRavingDead, Voice);
    strOpenedGame:='Sam and Max Night Of The Raving Dead';
  end
  else
  if SenderName = 'MenuItemOpenChariotsoftheDogs' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_ChariotsOfTheDogs, Voice);
    strOpenedGame:='Sam and Max Chariots Of The Dogs';
  end
  else
  if SenderName = 'MenuItemOpenWhatsNewBeelzebub' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_WhatsNewBeelzebub, Voice);
    strOpenedGame:='Sam and Max What''s New, Beelzebub';
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP1' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_HomestarRuiner);
    strOpenedGame:='Strong Bad Homestar Ruiner';
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP2' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_StrongBadiaTheFree);
    strOpenedGame:='Opened: Strong Bad Strong Badia the Free';
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP3' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_BaddestOfTheBands);
    strOpenedGame:='Strong Bad Baddest of the Bands';
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP4' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_Daneresque3);
    strOpenedGame:='Strong Bad Daneresque 3';
  end
  else
  if SenderName = 'MenuItemOpenStrongBadEP5' then
  begin
    strFolder:=GetTelltaleGamePath(StrongBad_8BitIsEnough);
    strOpenedGame:='Strong Bad 8-Bit Is Enough';
  end
  else
  if SenderName = 'MenuItemOpenTexas' then
  begin
    strFolder:=GetTelltaleGamePath(Texas_Holdem);
    strOpenedGame:='Telltale Texas Holdem';
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP1' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_FrightOfTheBumblebees);
    strOpenedGame:='Wallace and Gromit Fright of the Bumblebees';
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP2' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_TheLastResort);
    strOpenedGame:='Wallace and Gromit The Last Resort';
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP3' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_Muzzled);
    strOpenedGame:='Wallace and Gromit Muzzled!';
  end
  else
  if SenderName = 'MenuItemOpenWallaceEP4' then
  begin
    strFolder:=GetTelltaleGamePath(WallaceAndGromit_TheBogeyMan);
    strOpenedGame:='Wallace and Gromit The Bogey Man';
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP1' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_ScreamingNarwhal);
    strOpenedGame:='Launch of the Screaming Narwhal';
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP2' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_SpinnerCay);
    strOpenedGame:='The Siege of Spinner Cay';
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP3' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_LairLeviathan);
    strOpenedGame:='Lair of the Leviathan';
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP4' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_TrialExecution);
    strOpenedGame:='The Trial and Execution of Guybrush Threepwood';
  end
  else
  if SenderName = 'MenuItemOpenMonkeyEP5' then
  begin
    strFolder:=GetTelltaleGamePath(Monkey_PirateGod);
    strOpenedGame:='Rise of the Pirate God';
  end
  else
  if SenderName = 'MenuItemOpenSamNMax301' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_PenalZone);
    strOpenedGame:='The Penal Zone';
  end
  else
  if SenderName = 'MenuItemOpenSamNMax302' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_TombOfSammunMak);
    strOpenedGame:='The Tomb of Sammun-Mak';
  end
  else
  if SenderName = 'MenuItemOpenSamNMax303' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_TheyStoleMaxsBrain);
    strOpenedGame:='They Stole Max''s Brain!';
  end
  else
  if SenderName = 'MenuItemOpenSamNMax304' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_BeyondAlleyOfDolls);
    strOpenedGame:='Beyond the Alley of the Dolls';
  end
  else
  if SenderName = 'MenuItemOpenSamNMax305' then
  begin
    strFolder:=GetTelltaleGamePath(SamAndMax_CityThatDaresNotSleep);
    strOpenedGame:='The City That Dares Not Sleep';
  end
  else
  if SenderName = 'MenuItemOpenPuzzleAgentScoggins' then
  begin
    strFolder:=GetTelltaleGamePath(PuzzleAgent_Scoggins);
    strOpenedGame:='The Mystery of Scoggins';
  end
  else
  if SenderName = 'MenuItemOpenPuzzleAgent2' then
  begin
    strFolder:=GetTelltaleGamePath(PuzzleAgent_2);
    strOpenedGame:='Puzzle Agent 2';
  end
  else
  if SenderName = 'MenuItemOpenPokerInventory' then
  begin
    strFolder:=GetTelltaleGamePath(PokerNight_Inventory);
    strOpenedGame:='Poker Night At The Inventory';
  end
  else
  if SenderName = 'MenuItemOpenPokerInventory_Uncensored' then
  begin
    strFolder:=GetTelltaleGamePath(PokerNight_Inventory) + 'Localized\uncensored_english\';
    strOpenedGame:='Poker Night At The Inventory';
  end
  else
  if SenderName = 'MenuItemOpenPoker2' then
  begin
    strFolder:=GetTelltaleGamePath(PokerNight_2);
    strOpenedGame:='Poker Night 2';
  end
  else
  if SenderName = 'MenuItemOpenBTTF1' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_ItsAboutTime);
    strOpenedGame:='BTTF - It''s About Time';
  end
  else
  if SenderName = 'MenuItemOpenBTTF2' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_GetTannen);
    strOpenedGame:='BTTF - Get Tannen!';
  end
  else
  if SenderName = 'MenuItemOpenBTTF3' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_CitizenBrown);
    strOpenedGame:='BTTF - Citizen Brown';
  end
  else
  if SenderName = 'MenuItemOpenBTTF4' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_DoubleVisions);
    strOpenedGame:='BTTF - Double Visions';
  end
  else
  if SenderName = 'MenuItemOpenBTTF5' then
  begin
    strFolder:=GetTelltaleGamePath(BackToTheFuture_OutaTime);
    strOpenedGame:='BTTF - Outa Time';
  end
  else
  if SenderName = 'MenuItemHector101' then
  begin
    strFolder:=GetTelltaleGamePath(Hector_WeNegotiateWithTerrorists);
    strOpenedGame:='Hector - We Negotiate with Terrorists';
  end
  else
  if SenderName = 'MenuItemHector102' then
  begin
    strFolder:=GetTelltaleGamePath(Hector_SenselessActsOfJustice);
    strOpenedGame:='Hector - Senseless Acts Of Justice';
  end
  else
  if SenderName = 'MenuItemHector103' then
  begin
    strFolder:=GetTelltaleGamePath(Hector_BeyondReasonableDoom);
    strOpenedGame:='Hector - Beyond Reasonable Doom';
  end
  else
  if SenderName = 'MenuItemJurassicPark101' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_Ep1);
    strOpenedGame:='Jurassic Park - Episode 1';
  end
  else
  if SenderName = 'MenuItemJurassicPark102' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_Ep2);
    strOpenedGame:='Jurassic Park - Episode 2';
  end
  else
  if SenderName = 'MenuItemJurassicPark103' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_Ep3);
    strOpenedGame:='Jurassic Park - Episode 3';
  end
  else
  if SenderName = 'MenuItemJurassicPark104' then
  begin
    strFolder:=GetTelltaleGamePath(JurassicPark_Ep4);
    strOpenedGame:='Jurassic Park - Episode 4';
  end
  else
  if SenderName = 'MenuItemOpenLawAndOrderLegacies' then
  begin
    strFolder:=GetTelltaleGamePath(LawAndOrder_Legacies);
    strOpenedGame:='Law And Order: Legacies';

    dlgBrowseForOpenFolder.Directory := strFolder;

    ShowMessage('Law And Order Legacies has the audio for each of its 5 parts stored in separate folders. ' +
                'You''ll need to load the speech from each part manually.' + #13#13 +
                'To do this click "Open Folder", scroll down to the "Pack" folder, select one of the folders and click the "Go" button.'
                + #13#13 +
                'For example, select the LawAndOrder102 folder to load speech from the first part.');

  end
  else
  if SenderName = 'MenuItemOpenWalkingDead101' then
  begin
    strFolder:=GetTelltaleGamePath(WalkingDead_ANewDay);
    strOpenedGame:='The Walking Dead - A New Day';
  end
  else
  if SenderName = 'MenuItemOpenWalkingDead102' then
  begin
    strFolder:=GetTelltaleGamePath(WalkingDead_StarvedForHelp);
    strOpenedGame:='The Walking Dead - Starved For Help';
  end

  else
  if SenderName = 'MenuItemOpenWalkingDead103' then
  begin
    strFolder:=GetTelltaleGamePath(WalkingDead_LongRoadAhead);
    strOpenedGame:='The Walking Dead - Long Road Ahead';
  end

  else
  if SenderName = 'MenuItemOpenWalkingDead104' then
  begin
    strFolder:=GetTelltaleGamePath(WalkingDead_AroundEveryCorner);
    strOpenedGame:='The Walking Dead - Around Every Corner';
  end

  else
  if SenderName = 'MenuItemOpenWalkingDead105' then
  begin
    strFolder:=GetTelltaleGamePath(WalkingDead_NoTimeLeft);
    strOpenedGame:='The Walking Dead - No Time Left';
  end;

  OpenSpeechFolder(strFolder);

  if (Tree.RootNodeCount > 0) and (DirectoryExists(strFolder)) then
    DoLog(strOpened + strOpenedGame);
end;

end.
