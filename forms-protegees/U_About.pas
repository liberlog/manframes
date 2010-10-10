unit U_About;

{$DEFINE CLR}

//////////////////////////////////////////////////////////////////
// Giroux 2006
//  lb_Giroux doit avoir un caption 'Giroux'
//////////////////////////////////////////////////////////////////

interface

uses
	Windows, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
	RXCtrls, RxGIF, Animate, GIFCtrl, Dialogs, U_ConstMessage,
  JvXPButtons,
	VirtualTrees, fonctions_version, Menus;

const
	gver_F_About : T_Version = ( MCComponent : 'Fenêtre A propos' ; Unit : 'U_About' ;
																							 Owner : 'Matthieu Giroux' ;
																							 Comment : 'Répertorie les composants.' ;
																							 BugsStory   : 'Version 1.0.0.1 : Bug sur icône à la réouverture.' + #13#10
																													 + 'Version 1.0.0.0 : Gestion de versions.';
																							 UnitType : CST_TYPE_UNITE_FICHE ;
																							 Major : 1 ; Minor : 0 ; Release : 0 ; Build : 1 );

const CST_NOEUDS_RACINES = 5 ;
			CST_TYPE_APPLI		= 5 ;
type
	PCustVersion = ^T_Version ;
	TF_About = class(TForm)
		lb_NomApli: TLabel;
		lb_Giroux: TLabel;
		im_appli: TImage;
		SecretPanel1: TSecretPanel;
		Valider: TJvXPButton;
		bt_reinit: TJvXPButton;
		vt_Versioning: TVirtualStringTree;
		PopupMenu: TPopupMenu;
    Commentaires1: TMenuItem;
    Bugsenlevs1: TMenuItem;

		procedure FormActivate(Sender: TObject);
		procedure bt_reinitClick(Sender: TObject);
		procedure vt_VersioningGetText(Sender: TBaseVirtualTree;
			Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
			var CellText: WideString);
		procedure vt_VersioningInitNode(Sender: TBaseVirtualTree; ParentNode,
			Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure Commentaires1Click(Sender: TObject);
    procedure Bugsenlevs1Click(Sender: TObject);
    procedure vt_VersioningMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vt_VersioningCompareNodes(Sender: TBaseVirtualTree; Node1,
			Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
		{ Private declarations }
	private
		gi_Count1,
		gi_Count2 : Integer ;
		gnod_Fonctions	,
		gnod_BDD				,
		gnod_Composants ,
		gnod_Appli      ,
		gnod_Fenetres   : PVirtualNode ;
{$IFDEF CLR}
		procedure InitializeControls;
{$ENDIF}
  protected
		procedure DoShow ; override ;
	public
		gs_NomApli : WideString ;
		gs_Version : String ;
		gb_ShowComments : Boolean ;
		Constructor Create(AOwner: TComponent); override;
		destructor Destroy ; override ;
		{ Public declarations }
	end;

var
	F_About: TF_About;
	gic_F_AboutIcon : TIcon = nil ;

implementation

uses SysUtils ;

{$IFNDEF CLR}
{$R *.dfm}
{$ENDIF}

procedure TF_About.FormActivate(Sender: TObject);
begin
//	SecretPanel1.Active := True;
end;

procedure TF_About.bt_reinitClick(Sender: TObject);
begin
	if MessageDlg('La réinitialisation prendra effet au prochain démarrage de l''application.'
							 + #13 + 'Voulez-vous continuer ?', mtConfirmation, mbOKCancel, 0) = mrOK then Close;
end;

constructor TF_About.Create(AOwner: TComponent);

begin
	gi_Count1 := 0 ;
	gi_Count2 := -1 ;
	gb_ShowComments := False ;
	if not ( csDesigning in ComponentState ) Then
		Try
	 GlobalNameSpace.BeginWrite;
	 CreateNew(AOwner);

		Finally
		GlobalNameSpace.EndWrite;
		End
	Else
	 inherited ;
{$IFDEF CLR}	InitializeControls;
{$ENDIF}

//	ic_temp := TIcon.Create;
//	F_FenetrePrincipale.im_icones.GetIcon(2, ic_temp);
	Self.Icon.Assign(gic_F_AboutIcon);
//	ic_temp.Free;
	 
	if csDesigning in ComponentState Then
		Exit ;
	vt_Versioning.BeginUpdate ;
	vt_Versioning.Clear;
	vt_Versioning.NodeDataSize := Sizeof(T_Version) + CST_NOEUDS_RACINES ;
	vt_Versioning.RootNodeCount := CST_NOEUDS_RACINES ;
	vt_Versioning.EndUpdate;
	with vt_Versioning.Header do
		Begin
			Columns.Add;
			Columns[0].Position := 0;
			Columns[0].Width := 320;
			Columns[0].Text := 'Composantes';
			Columns.Add;
			Columns[1].Position := 1;
			Columns[1].Width := 80;
			Columns[1].Text := 'Version';
			Columns.Add;
			Columns[2].Position := 2;
			Columns[2].Width := 190;
			Columns[2].Text := 'R'#233'dacteur';
			SortColumn := 0 ;
		End ;
	PopupMenu.PopupComponent := vt_Versioning;
	PopupMenu.AutoPopup := True ;

//	im_appli.Picture.Assign(F_FenetrePrincipale.im_appli.Picture.Icon);

end;

destructor TF_About.Destroy;
begin
	inherited;
end;

procedure TF_About.DoShow;
var li_i : Integer ;
begin
	lb_NomApli.Caption := gs_NomApli;
	li_i := 1 ;
	while li_i < length ( gs_Version ) do
		Begin
			if ord ( gs_Version [ li_i ] ) = ord ( ' ' ) Then
				Begin
					gs_Version := copy ( gs_Version, li_i + 1, length ( gs_Version ) - li_i );
					li_i := 1 ;
				End ;
			inc ( li_i );
		End ;
	inherited;
end;

procedure TF_About.vt_VersioningInitNode(Sender: TBaseVirtualTree;
	ParentNode, Node: PVirtualNode;
	var InitialStates: TVirtualNodeInitStates);
	var	CustomerRecord : PCustVersion;
			Lnod_ChildNode: PVirtualNode ;
			li_UnitType : Integer ;
begin

	CustomerRecord := Sender.GetNodeData(Node);
//	if then
//		begin
			if  ( gi_Count2 < 0 )
			and ( Sender.GetNodeLevel (Node) = 0 ) Then
				begin
					li_UnitType := -1 ;
					Initialize(CustomerRecord^);
					case gi_Count1 of
						0 : Begin
									CustomerRecord.McComponent := 'Base de données' ;
									CustomerRecord.Owner       := 'Giroux' ;
									gnod_bdd := Node ;
								End ;
						1 : Begin
									gnod_Appli := Node ;
									while gi_Count2 <= high ( gt_McVersioning ) do
										Begin
											inc ( gi_Count2 );
											if gt_McVersioning [ gi_Count2 ].UnitType = CST_TYPE_UNITE_APPLI Then
												Begin
													CustomerRecord.McComponent := gt_McVersioning [ gi_Count2 ].McComponent ;
													CustomerRecord.McUnit      := gt_McVersioning [ gi_Count2 ].McUnit ;
													CustomerRecord.Comment     := gt_McVersioning [ gi_Count2 ].Comment ;
													CustomerRecord.BugsStory   := gt_McVersioning [ gi_Count2 ].BugsStory ;
													CustomerRecord.Owner       := gt_McVersioning [ gi_Count2 ].Owner ;
													CustomerRecord.UnitType    := gt_McVersioning [ gi_Count2 ].UnitType ;
													CustomerRecord.Major       := gt_McVersioning [ gi_Count2 ].Major ;
													CustomerRecord.Minor       := gt_McVersioning [ gi_Count2 ].Minor ;
													CustomerRecord.Release     := gt_McVersioning [ gi_Count2 ].Release ;
													CustomerRecord.Build       := gt_McVersioning [ gi_Count2 ].Build ;
													Break ;
												End ;
											if gi_Count2 = high ( gt_McVersioning ) Then
												Begin
													vt_Versioning.DeleteNode ( Node );
													gnod_Appli := Nil ;
												End ;
										End ;
								End ;
						2 : Begin
									CustomerRecord.McComponent := 'Fenêtres' ;
									li_UnitType := 2 ;
									gnod_Fenetres := Node ;
								End ;
						3 : Begin
									CustomerRecord.McComponent := 'Composants' ;
									li_UnitType := 3;
									gnod_Composants := Node ;
								End ;
						4 : Begin
									CustomerRecord.McComponent := 'Fonctions' ;
									li_UnitType := 1 ;
									gnod_Fonctions := Node ;
								End ;
						End;
					gi_Count2 := -1 ;
					if li_UnitType > 0 Then
						while gi_Count2 <= high ( gt_McVersioning ) do
							Begin
								inc ( gi_Count2 );
								if li_UnitType = gt_McVersioning [ gi_Count2 ].UnitType Then
									case li_UnitType of
										1 : Begin
													Lnod_ChildNode := vt_Versioning.AddChild ( gnod_Fonctions );
													vt_Versioning.ValidateNode ( Lnod_ChildNode, False );
												End ;
										2 : Begin
													Lnod_ChildNode := vt_Versioning.AddChild ( gnod_Fenetres );
													vt_Versioning.ValidateNode ( Lnod_ChildNode, False );
												End ;
										3 : Begin
													Lnod_ChildNode := vt_Versioning.AddChild ( gnod_Composants );
													vt_Versioning.ValidateNode ( Lnod_ChildNode, False );
												End ;
									End ;
							End ;
					inc ( gi_Count1 );
					gi_Count2 := -1 ;
				end
			else if ( Sender.GetNodeLevel (Node) > 0 ) then//gi_Count2 <= high ( gt_McVersioning ) then
				begin
					Initialize(CustomerRecord^);
					CustomerRecord.McComponent := gt_McVersioning [ gi_Count2 ].McComponent ;
					CustomerRecord.McUnit      := gt_McVersioning [ gi_Count2 ].McUnit ;
					CustomerRecord.Comment     := gt_McVersioning [ gi_Count2 ].Comment ;
					CustomerRecord.BugsStory   := gt_McVersioning [ gi_Count2 ].BugsStory ;
					CustomerRecord.UnitType    := gt_McVersioning [ gi_Count2 ].UnitType ;
					CustomerRecord.Owner       := gt_McVersioning [ gi_Count2 ].Owner ;
					CustomerRecord.Major       := gt_McVersioning [ gi_Count2 ].Major ;
					CustomerRecord.Minor       := gt_McVersioning [ gi_Count2 ].Minor ;
					CustomerRecord.Release     := gt_McVersioning [ gi_Count2 ].Release ;
					CustomerRecord.Build       := gt_McVersioning [ gi_Count2 ].Build ;
				end;
end;

///////////////////////////////////////////////////
// Procedure : vst_dateGetText
// Description : Affichage des dates dans la liste
///////////////////////////////////////////////////
procedure TF_About.vt_VersioningGetText(Sender: TBaseVirtualTree;
	Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
	var CellText: WideString);

Var
	// Données du VirtualTreeView
	CustomerRecord : PCustVersion;
begin
	CustomerRecord    := Sender.GetNodeData   ( Node );
	if Sender.GetNodeLevel ( Node ) = 1 Then
		Begin
			Case Column of
				0 : CellText := CustomerRecord.MCComponent ;
				1 : CellText := fs_VersionToText ( CustomerRecord^ ) ;
				2 : CellText := CustomerRecord.Owner ;
				Else CellText := '';
			End ;
		End
	Else
		Begin
			Case Column of
				0 : CellText := CustomerRecord.MCComponent ;
				1 : if Node = gnod_BDD Then
							CellText := gs_Version
							Else
								if Node = gnod_Appli Then
									CellText := fs_VersionToText ( CustomerRecord^ )
								Else
									 CellText := '' ;
				2 : if ( Node = gnod_BDD ) or ( Node = gnod_Appli ) Then
							CellText := CustomerRecord.Owner
						Else
							CellText := '';
			End ;
		End
end;


procedure TF_About.Commentaires1Click(Sender: TObject);
var CustomerRecord : PCustVersion;
begin
	CustomerRecord := vt_Versioning.GetNodeData ( vt_Versioning.GetFirstSelected  );

	Showmessage ( 'Commentaires sur la composante ' + CustomerRecord.MCComponent + #13#10 +
								'Unité ' + CustomerRecord.MCUnit + #13#10 + #13#10 +
								CustomerRecord.Comment );
end;

procedure TF_About.Bugsenlevs1Click(Sender: TObject);
var CustomerRecord : PCustVersion;
begin
	CustomerRecord := vt_Versioning.GetNodeData ( vt_Versioning.GetFirstSelected  );

	Showmessage ( 'Historique des bugs enlevés sur ' + CustomerRecord.MCComponent + #13#10 +
								'Unité ' + CustomerRecord.MCUnit + #13#10 + #13#10 +
								CustomerRecord.BugsStory );

end;

procedure TF_About.vt_VersioningMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	lpoi_Coordonnees : TPoint ;
begin
		// Trigger header popup if there's one.
		if ( Button = mbRight )
		and gb_ShowComments
		and ( vt_Versioning.GetFirstSelected <> nil ) 
		and ( vt_Versioning.GetFirstSelected.FirstChild = nil ) then
		begin
			lpoi_Coordonnees := vt_Versioning.ClientToScreen(Point(X, Y));
			PopupMenu.Popup ( lpoi_Coordonnees.X, lpoi_Coordonnees.Y );
		end;
end;


procedure TF_About.vt_VersioningCompareNodes(Sender: TBaseVirtualTree;
	Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var CustomerRecord1 : PCustVersion;
		CustomerRecord2 : PCustVersion;
begin
	CustomerRecord1 := Sender.GetNodeData(Node1);
	CustomerRecord2 := Sender.GetNodeData(Node2);

	if ( Sender.GetNodeLevel ( Node1 ) = 1 )
	and ( Sender.GetNodeLevel ( Node1 ) = Sender.GetNodeLevel ( Node2 ))
	and ( CustomerRecord1.MCComponent > CustomerRecord2.MCComponent ) Then
		Result := 1 ;

end;

{$IFDEF CLR}
procedure TF_About.InitializeControls;
begin
  // Initalizing all controls...
  lb_NomApli := TLabel.Create(Self);
  lb_Microcelt := TLabel.Create(Self);
  im_appli := TImage.Create(Self);
  SecretPanel1 := TSecretPanel.Create(Self);
  Valider := TJvXPButton.Create(Self);
  bt_reinit := TJvXPButton.Create(Self);
  vt_Versioning := TVirtualStringTree.Create(Self);
  PopupMenu := TPopupMenu.Create(Self);
  Commentaires1 := TMenuItem.Create(Self);
  Bugsenlevs1 := TMenuItem.Create(Self);
  
  with lb_NomApli do
  begin
    Name := 'lb_NomApli';
    Parent := Self;
    Left := 192;
    Top := 13;
    Width := 249;
    Height := 20;
    Alignment := taCenter;
    AutoSize := False;
    Caption := 'Inconnu';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlue;
    Font.Height := -16;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentFont := False;
    IsControl := True;
  end;
  
  with lb_Microcelt do
  begin
    Name := 'lb_Microcelt';
    Parent := Self;
    Left := 528;
    Top := 12;
    Width := 78;
    Height := 20;
    Alignment := taCenter;
    Caption := 'Microcelt ';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clBlack;
    Font.Height := -16;
    Font.Name := 'MS Sans Serif';
    Font.Style := [fsBold];
    ParentFont := False;
  end;
  
  with im_appli do
  begin
    Name := 'im_appli';
    Parent := Self;
    Left := 8;
    Top := 8;
    Width := 76;
    Height := 32;
    Center := True;
  end;
  
  with SecretPanel1 do
  begin
    Name := 'SecretPanel1';
    if SecretPanel1.ClassType.InheritsFrom(TControl) then TControl(SecretPanel1).Parent := self;
    if IsPublishedProp(SecretPanel1, 'Left') then SetOrdProp(SecretPanel1, 'Left', 112);
    if IsPublishedProp(SecretPanel1, 'Top') then SetOrdProp(SecretPanel1, 'Top', 64);
    if IsPublishedProp(SecretPanel1, 'Width') then SetOrdProp(SecretPanel1, 'Width', 297);
    if IsPublishedProp(SecretPanel1, 'Height') then SetOrdProp(SecretPanel1, 'Height', 137);
    Interval := 50;
    Lines.Add('----------------------------------------------------------------' +
      '-------------------------');
    Lines.Add('Design eXperience '#169' 2002  M. Hoffmann');
    Lines.Add('Copyright '#169' 1998, 1999, 2000 GJL Software - April 2000');
    Lines.Add('scExcelExport November 2001 Stefan Cruysberghs');
    Lines.Add('----------------------------------------------------------------' +
      '-------------------------');
    Lines.Add('');
    Lines.Add('R'#233'alisation Microcelt Juin 2004');
    Lines.Add('');
    Lines.Add('----------------------------------------------------------------' +
      '-------------------------');
    TextStyle := bvRaised;
    BevelOuter := bvNone;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clTeal;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 0;
    Visible := False;
  end;
  
  with Valider do
  begin
    Name := 'Valider';
    if Valider.ClassType.InheritsFrom(TControl) then TControl(Valider).Parent := self;
    if IsPublishedProp(Valider, 'Left') then SetOrdProp(Valider, 'Left', 528);
    if IsPublishedProp(Valider, 'Top') then SetOrdProp(Valider, 'Top', 369);
    Caption := '&OK';
    TabOrder := 1;
    ModalResult := 1;
  end;
  
  with bt_reinit do
  begin
    Name := 'bt_reinit';
    if bt_reinit.ClassType.InheritsFrom(TControl) then TControl(bt_reinit).Parent := self;
    if IsPublishedProp(bt_reinit, 'Left') then SetOrdProp(bt_reinit, 'Left', 16);
    if IsPublishedProp(bt_reinit, 'Top') then SetOrdProp(bt_reinit, 'Top', 369);
    Hint := 'R'#233'initialisation des tailles';
    ParentShowHint := False;
    ShowHint := True;
    OnClick := bt_reinitClick;
    Caption := 'R'#233'initialiser';
    TabOrder := 2;
  end;
  
  with vt_Versioning do
  begin
    Name := 'vt_Versioning';
    if vt_Versioning.ClassType.InheritsFrom(TControl) then TControl(vt_Versioning).Parent := self;
    if IsPublishedProp(vt_Versioning, 'Left') then SetOrdProp(vt_Versioning, 'Left', 0);
    if IsPublishedProp(vt_Versioning, 'Top') then SetOrdProp(vt_Versioning, 'Top', 48);
    if IsPublishedProp(vt_Versioning, 'Width') then SetOrdProp(vt_Versioning, 'Width', 617);
    if IsPublishedProp(vt_Versioning, 'Height') then SetOrdProp(vt_Versioning, 'Height', 313);
    Header.AutoSizeIndex := 0;
    Header.Font.Charset := DEFAULT_CHARSET;
    Header.Font.Color := clWindowText;
    Header.Font.Height := -11;
    Header.Font.Name := 'MS Sans Serif';
    Header.Font.Style := [];
    Header.Options := [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible];
    Header.Style := hsXPStyle;
    PopupMenu := PopupMenu;
    TabOrder := 3;
    TreeOptions.AutoOptions := [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes];
    TreeOptions.PaintOptions := [toPopupMode, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages];
    TreeOptions.SelectionOptions := [toFullRowSelect, toRightClickSelect];
    OnCompareNodes := vt_VersioningCompareNodes;
    OnGetText := vt_VersioningGetText;
    OnInitNode := vt_VersioningInitNode;
    OnMouseUp := vt_VersioningMouseUp;
  end;
  
  with PopupMenu do
  begin
    Name := 'PopupMenu';
    Parent := Self;
  end;
  
  with Commentaires1 do
  begin
    Name := 'Commentaires1';
    PopupMenu.Items.Add(Commentaires1);
    Caption := 'Commentaires';
    OnClick := Commentaires1Click;
  end;
  
  with Bugsenlevs1 do
  begin
    Name := 'Bugsenlevs1';
    PopupMenu.Items.Add(Bugsenlevs1);
    Caption := 'Bugs enlev'#233's';
    OnClick := Bugsenlevs1Click;
  end;

  // Form's PMEs'
  Left := 282;
  Top := 193;
  BorderIcons := [biSystemMenu];
  BorderStyle := bsSingle;
  Caption := #192' propos';
  ClientHeight := 396;
  ClientWidth := 616;
  Color := clBtnFace;
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clBlack;
  Font.Height := -11;
  Font.Name := 'MS Sans Serif';
  Font.Style := [];
  Position := poScreenCenter;
  OnActivate := FormActivate;
end;
{$ENDIF}

initialization
	p_ConcatVersion ( gver_F_About );
	gic_F_AboutIcon := TIcon.Create ;
finalization
	if assigned ( gic_F_AboutIcon ) Then
		Begin
			if  gic_F_AboutIcon.HandleAllocated Then
			  gic_F_AboutIcon.ReleaseHandle ;
			gic_F_AboutIcon.Free ;
			gic_F_AboutIcon := Nil ;
		End ;
end.

