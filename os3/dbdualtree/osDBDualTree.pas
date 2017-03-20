unit osDBDualTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, ComCtrls, DB,
  Variants, StdCtrls, StrUtils;

type
  TNodeSelectEvent = procedure(LeafSelected: boolean) of object;

  TVariantRef = class(TObject)
  private
    FValue: Variant;
  public
    constructor Create(AValue: Variant);
    property Value: Variant read FValue;
  end;

  TosDBDualTree = class(TCustomPanel)
  private
    FLeftTree: TTreeView;
    FRightTree: TTreeView;

    FLeftLabel: TLabel;
    FRightLabel: TLabel;

    FToLeftButton: TButton;
    FToRightButton: TButton;

    FAssociationDataSet: TDataSet;
    FAssociationField: TField;
    FAssociationFieldName: string;

    FSourceDataSet: TDataSet;
    FSourceField: TField;
    FSourceFieldName: string;

{ DONE : Arranjar um nome mais sugestivo para FSourceFieldCount (e.g.
  LevelCount) }
    FLevelCount: integer;
    FSourceDescFields: array of TField;
    FSourceDescFieldNames: TStrings;

    FOnNodeSelect: TNodeSelectEvent;
    FOnLeftNodeSelect: TNodeSelectEvent;

{ TODO : Encontrar um modo mais elegante de impedir que o evento OnNodeSelect
  seja disparado durante o m�todo Clear }
    FClearing: boolean;

    procedure SetAssociationFieldName(const Value: string);
    procedure SetSourceFieldName(const Value: string);
    procedure SetSourceDescFieldNames(const Value: TStrings);

{ DONE : Remover este m�todo sobrecarregado quando se estiver certo da
  finalidade do m�todo FindOrCreateNode }

{ DONE : Talvez seja melhor este m�todo receber o TVariantRef j� criado. Dessa
  forma n�o ser� necess�rio criar novos objetos (e excluir outros) ao fazer o
  movimento dos registros }
{ DONE : Verificar a necessidade de cada par�metro do m�todo FindOrCreateNode e
  mudar o seu nome, caso sua funcionalidade seja alterada (e.g. CreateNode) }
    procedure CreateNode(TreeView: TTreeView;
      const Captions: array of string; FieldIDRef: TVariantRef);

    procedure MoveSelectedNodes(FromTree, ToTree: TTreeView);
{ DONE : UpdateDataSet n�o � um nome bom para este m�todo e ele poderia ser
  local ao m�todo MoveSelectedNodes }

    procedure ToLeftButtonClick(Sender: TObject);
    procedure ToRightButtonClick(Sender: TObject);

    procedure RightTreeChange(Sender: TObject; Node: TTreeNode);
    procedure LeftTreeChange(Sender: TObject; Node: TTreeNode);

    procedure RightTreeEnter(Sender: TObject);
    procedure LeftTreeEnter(Sender: TObject);


    procedure ResizeComponents;
    function GetAssociationCaption: string;
    function GetSourceCaption: string;
    procedure SetAssociationCaption(const Value: string);
    procedure SetSourceCaption(const Value: string);

  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;

    procedure Resize; override;
    procedure Loaded; override;

    procedure DoNodeSelect(LeafSelected: boolean);
    procedure DoLeftNodeSelect(LeafSelected: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Expand;
    procedure Load;
    procedure Filter(Filtro: string);
    procedure Clear;

// Just to test memory leaks
    procedure MoveRandomly(Direction: boolean);

    property AssociationTree: TTreeView read FRightTree;
    property SourceTree: TTreeView read FLeftTree;

  published
    property AssociationDataSet: TDataSet
        read FAssociationDataSet write FAssociationDataSet;
    property AssociationFieldName: string
        read FAssociationFieldName write SetAssociationFieldName;
    property SourceDataSet: TDataSet
        read FSourceDataSet write FSourceDataSet;
    property SourceFieldName: string
        read FSourceFieldName write SetSourceFieldName;
    property SourceDescFieldNames: TStrings
        read FSourceDescFieldNames write SetSourceDescFieldNames;

    property OnNodeSelect: TNodeSelectEvent
        read FOnNodeSelect write FOnNodeSelect;
    property OnLeftNodeSelect: TNodeSelectEvent
        read FOnLeftNodeSelect write FOnLeftNodeSelect;

    property AssociationCaption: string
        read GetAssociationCaption write SetAssociationCaption;
    property SourceCaption: string
        read GetSourceCaption write SetSourceCaption;

    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('OS Controls', [TosDBDualTree]);
end;

{ TVariantRef }

constructor TVariantRef.Create(AValue: Variant);
begin
  FValue := AValue;
end;

{ TosDBDualTree }

{ DONE : Fazer o componente reagir a mudan�as do DataSet e posicionar-se nele
  quando o usu�rio clicar em uma folha da �rvore }

{ TODO : Fazer o componente reagir a mudan�as do DataSet }

{ TODO : Copiar o estado de expans�o ao mover registros de uma �rvore para
  outra }

{ DONE : Permitir a inser��o de labels para os TreeView's }

{ TODO : Permitir que os n�s da �rvore sejam ordenados alfabeticamente }

procedure TosDBDualTree.Clear;
var
  Node: TTreeNode;
begin
  FClearing := True;

  Node := FLeftTree.Items.GetFirstNode;
  while Node <> nil do
  begin
    if Node.Data <> nil then
      TVariantRef(Node.Data).Free;

    Node := Node.GetNext;
  end;
  FLeftTree.Items.Clear;

  Node := FRightTree.Items.GetFirstNode;
  while Node <> nil do
  begin
    if Node.Data <> nil then
      TVariantRef(Node.Data).Free;

    Node := Node.GetNext;
  end;
  FRightTree.Items.Clear;

  FClearing := False;
end;

constructor TosDBDualTree.Create(AOwner: TComponent);
begin
  inherited;

  FClearing := False;
  BevelOuter := bvNone;

  // Previne o controle de tentar definir o pr�prio Caption
  ControlStyle := ControlStyle - [csSetCaption];
{ TODO : Acertar o caption em design-time }
  Caption := '';

  FLeftLabel := TLabel.Create(Self);
  FLeftLabel.Top := 0;
  FLeftLabel.Left := 0;
  FLeftLabel.AutoSize := False;
  FLeftLabel.Alignment := taCenter;
  FLeftLabel.Parent := Self;

  FRightLabel := TLabel.Create(Self);
  FRightLabel.Top := 0;
  FRightLabel.AutoSize := False;
  FRightLabel.Alignment := taCenter;
  FRightLabel.Parent := Self;

  FLeftTree := TTreeView.Create(Self);
  FLeftTree.Left := 0;
  FLeftTree.Top := 16;
//  FLeftTree.Align := alLeft;
  FLeftTree.Anchors := [akLeft, akTop, akBottom];
  FLeftTree.MultiSelect := True;
  FLeftTree.MultiSelectStyle := [msControlSelect, msShiftSelect];
  FLeftTree.ReadOnly := True;
  FLeftTree.Parent := Self;
  FLeftTree.HideSelection := False;
  FLeftTree.SortType := stText;
  FLeftTree.OnChange := LeftTreeChange;
  FLeftTree.OnEnter := LeftTreeEnter;

  FRightTree := TTreeView.Create(Self);
  FRightTree.Top := 16;
//  FRightTree.Align := alRight;
  FRightTree.Anchors := [akTop, akRight, akBottom];
  FRightTree.MultiSelect := True;
  FRightTree.MultiSelectStyle := [msControlSelect, msShiftSelect];
  FRightTree.ReadOnly := True;
  FRightTree.Parent := Self;
  FRightTree.OnChange := RightTreeChange;
  FRightTree.HideSelection := False;
  FRightTree.SortType := stText;
  FRightTree.OnEnter := RightTreeEnter;

  FToLeftButton := TButton.Create(Self);
  FToLeftButton.Caption := '<';
  FToLeftButton.Height := 25;
  FToLeftButton.Width := 25;

  FToLeftButton.OnClick := ToLeftButtonClick;
  FToLeftButton.Parent := Self;

  FToRightButton := TButton.Create(Self);
  FToRightButton.Caption := '>';
  FToRightButton.Height := 25;
  FToRightButton.Width := 25;

  FToRightButton.OnClick := ToRightButtonClick;
  FToRightButton.Parent := Self;

  FLevelCount := 0;
  FSourceDescFieldNames := TStringList.Create;
end;

destructor TosDBDualTree.Destroy;
begin
  Finalize(FSourceDescFields);
  FSourceDescFieldNames.Free;
  inherited;
end;

procedure TosDBDualTree.DoNodeSelect(LeafSelected: boolean);
begin
  if Assigned(FOnNodeSelect) then
    FOnNodeSelect(LeafSelected);
end;


procedure TosDBDualTree.Expand;
var
  x : integer;
begin
  for x := 0 to FLeftTree.Items.Count - 1 do
      FLeftTree.Items.Item[x].Expand(True);
  for x := 0 to FRightTree.Items.Count - 1 do
      FRightTree.Items.Item[x].Expand(True);
end;

procedure TosDBDualTree.CreateNode(TreeView: TTreeView;
  const Captions: array of string; FieldIDRef: TVariantRef);
var
  i: integer;
  TreeNode,
  SearchNode: TTreeNode;
begin
  Assert(Length(Captions) = FLevelCount, 'The length of Captions must be '
      + 'be the count of fields in SourceDataSet');

{ DONE : Este m�todo n�o parece ter sido muito bem desenhado. O valor nil
  atribu�do a TreeNode n�o parece ser muito coerente, uma vez que o m�todo deve
  acabar com um TreeNode diferente de nil. Talvez exista um modo de remover o
  primeiro 'if' do loop 'for' }

 { DONE : Do modo como est� constru�do as �rvores nunca conter�o nomes
   repetidos. Isso causa um efeito colateral ao mostrar os dados do
   ClientDataSet. Se existem dois registros com o mesmo nome na mesma �rvore,
   aparecer� somente um registro nesta. Se ele for movido para a outra �rvore e
   for feito um Load novamente, o registro com nome repetido aparecer� nas duas
   �rvores. Seria mais conveniente se o componente aceitasse nomes repetidos na
   mesma �rvore. }
  TreeNode := nil;
  for i := 0 to FLevelCount - 2 do
  begin
    if TreeNode = nil then
      SearchNode := TreeView.Items.GetFirstNode
    else
      SearchNode := TreeNode.getFirstChild;

    while (SearchNode <> nil) and (SearchNode.Text <> Captions[i]) do
      SearchNode := SearchNode.getNextSibling;

    if SearchNode = nil then
      TreeNode := TreeView.Items.AddChild(TreeNode, Captions[i])
    else
      TreeNode := SearchNode;
  end;

  TreeNode := TreeView.Items.AddChild(TreeNode, Captions[FLevelCount - 1]);

  Assert(TreeNode <> nil, 'TreeNode must not be nil at the end of the ' +
      'insertion. This can be caused by a null list of fields in ' +
      'FSourceFieldNames');

{ DONE : Provavelmente este teste (Result = fcCreated) dever� desaparecer. O
  bookmark ser� atribu�do ao n� incodicionalmente }
  TreeNode.Data := FieldIDRef;
end;

function TosDBDualTree.GetAssociationCaption: string;
begin
  Result := FRightLabel.Caption;
end;

function TosDBDualTree.GetSourceCaption: string;
begin
  Result := FLeftLabel.Caption;
end;

procedure TosDBDualTree.Load;
var
  i, j: integer;
  Bookmark: TBookmark;
  Values: array of string;
  DataSetActive: boolean;
begin
{ TODO : Criar uma propriedade para o usu�rio escolher se deseja mostrar as
  linhas }

  DataSetActive := FSourceDataSet.Active;
  Bookmark := nil;

  if FLevelCount = 1 then
  begin
    FLeftTree.ShowRoot := False;
    FRightTree.ShowRoot := False;
  end;

  Clear;

  if DataSetActive then
  begin
    FSourceDataSet.DisableControls;
    Bookmark := FSourceDataSet.GetBookmark;
  end
  else
    FSourceDataSet.Active := True;

  SetLength(Values, FLevelCount);

  try
    FSourceDataSet.First;
    for i := 0 to FSourceDataSet.RecordCount - 1 do
    begin

      for j := 0 to FLevelCount - 1 do
        try
          Values[j] := FSourceDescFields[j].AsString;
        except
          Values[j] := '';
        end;

      if FAssociationDataSet.Locate(FAssociationFieldName,
          VarArrayOf([FSourceField.Value]), []) then
        CreateNode(FRightTree, Values,
            TVariantRef.Create(FSourceField.Value))
      else
        CreateNode(FLeftTree, Values,
            TVariantRef.Create(FSourceField.Value));

      FSourceDataSet.Next;
    end;

  finally
    Finalize(Values);

    if DataSetActive then
    begin
      FSourceDataSet.GotoBookmark(Bookmark);
      FSourceDataSet.FreeBookmark(Bookmark);
      FSourceDataSet.EnableControls;
    end
    else
      FSourceDataSet.Active := False;
  end;

{ TODO : Encontrar um modo mais elegante de manter os itens ordenados }
  FLeftTree.SortType := stNone;
  FLeftTree.SortType := stText;
  FRightTree.SortType := stNone;
  FRightTree.SortType := stText;
end;

procedure TosDBDualTree.Filter(Filtro: string);
var
  I, count: integer;
begin
  Self.Load;

  count := Self.FLeftTree.Items.Count;

  if (count > 0) and (Length(Trim(Filtro)) > 0) then
  begin
    for I := count - 1 downto 0 do
      if not ContainsText(AnsiUpperCase(FLeftTree.Items.Item[I].Text), AnsiUpperCase(Filtro)) then
        FLeftTree.Items.Delete(FLeftTree.Items.Item[I])
      else
        //OutputDebugString(PChar('N�o Removido'));
  end;

end;

procedure TosDBDualTree.MoveRandomly(Direction: boolean);
var
  j: integer;

begin
  if Direction then
  begin
    if FLeftTree.Items.Count >= 2 then
    begin
      j := Random(FLeftTree.Items.Count);
      FLeftTree.Items.Item[j].Selected := True;
      j := Random(FLeftTree.Items.Count);
      FLeftTree.Items.Item[j].Selected := True;
      MoveSelectedNodes(FLeftTree, FRightTree);
    end;

  end
  else
  begin
    if FRightTree.Items.Count >= 2 then
    begin
      j := Random(FRightTree.Items.Count);
      FRightTree.Items.Item[j].Selected := True;
      j := Random(FRightTree.Items.Count);
      FRightTree.Items.Item[j].Selected := True;
      MoveSelectedNodes(FRightTree, FLeftTree);
    end;

  end;
end;

procedure TosDBDualTree.Loaded;
var
  i: integer;
begin
  inherited;
  ResizeComponents;

{ TODO : Arranjar um modo mais elegante de inicializar o array de fields e sua
  contagem }
  if Assigned(FSourceDataSet) then
  begin
    FLevelCount := FSourceDescFieldNames.Count;
    SetLength(FSourceDescFields, FLevelCount);
    for i := 0 to FLevelCount - 1 do
      FSourceDescFields[i] :=
          FSourceDataSet.FindField(FSourceDescFieldNames[i]);
  end;
  if Assigned(FSourceDataSet) then
    FSourceField := FSourceDataSet.FindField(FSourceFieldName);
  if Assigned(FAssociationDataSet) then
    FAssociationField := FAssociationDataSet.FindField(FAssociationFieldName);

end;

procedure TosDBDualTree.MoveSelectedNodes(FromTree, ToTree: TTreeView);
  procedure UpdateDataSet(Node: TTreeNode);
  begin
    Assert(Node.Level = FLevelCount - 1, 'UpdateDataSet cannot handle tree '
        + 'branches (only leaves)');

    Assert((Node.Owner.Owner = FLeftTree) or (Node.Owner.Owner = FRightTree),
        'The owner of the node must be one of the TreeViews in the control');

    if Node.Owner.Owner = FRightTree then
    begin
      Assert(FAssociationDataSet.Locate(FAssociationFieldName,
          VarArrayOf([TVariantRef(Node.Data).Value]), []), 'Could not locate '
          + 'the corresponding field in the dataset. Maybe the dataset has '
          + 'changed while it was been edited by the control');

      FAssociationDataSet.Locate(FAssociationFieldName,
          VarArrayOf([TVariantRef(Node.Data).Value]), []);
      FAssociationDataSet.Delete;
    end
    else
    begin
      Assert(not FAssociationDataSet.Locate(FAssociationFieldName,
          VarArrayOf([TVariantRef(Node.Data).Value]), []), 'A field with the '
          + 'same ID was found in the dataset before inserting the new record. '
          + 'Maybe the dataset has changed while it was been edited by the '
          + 'control');

      FAssociationDataSet.Append;
      FAssociationField.Value := TVariantRef(Node.Data).Value;
      FAssociationDataSet.Post;
    end;
  end;
var
  Captions: array of string;
  Level, j,
  SelIndex: integer;
  Parent, Node: TTreeNode;
begin
{ TODO : Impedir a movimenta��o de registros sem que pelo menos um n� esteja
  visivelmente selecionado }

  SetLength(Captions, FLevelCount);
  try
    SelIndex := Integer(FromTree.SelectionCount) - 1;
    while SelIndex >= 0 do
    begin

      Node := FromTree.Selections[SelIndex];
      Level := Node.Level;

      Parent := Node;
      for j := Level downto 0 do
      begin
        Captions[j] := Parent.Text;
        Parent := Parent.Parent;
      end;

      j := Level;
      repeat
        if Node.HasChildren then
        begin
          Node := Node.getFirstChild;
          Inc(j);
          Captions[j] := Node.Text;
          continue;
        end;

        Parent := Node.Parent;
        if j = FLevelCount - 1 then
        begin
          CreateNode(ToTree, Captions, TVariantRef(Node.Data));
          UpdateDataSet(Node);
{ DONE : Quando o m�todo FindOrCreateNode receber o TVariantRef j� constru�do
  n�o ser� mais necess�rio (e nem poder�) apagar o objeto ap�s mov�-lo }
        end;
        if Node.Selected then
          Dec(SelIndex);
        Node.Delete;
        Node := Parent;

        Dec(j);
      until (Node = nil) or (j < Level) and (Node.HasChildren);

    end;
  finally
    Finalize(Captions);
  end;
{ TODO : Encontrar um modo mais elegante de manter os itens ordenados }
  ToTree.SortType := stNone;
  ToTree.SortType := stText;
end;

procedure TosDBDualTree.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FAssociationDataSet then
      FAssociationDataSet := nil
    else if AComponent = FSourceDataSet then
      FSourceDataSet := nil;
  end;
end;

procedure TosDBDualTree.Resize;
begin
  inherited;
  ResizeComponents;
end;

procedure TosDBDualTree.ResizeComponents;
begin
  FLeftTree.Width := (Width - 39) div 2;
  FLeftTree.Height := Height - 16;

  FRightTree.Width := FLeftTree.Width + 1 - Width mod 2;
  FRightTree.Left := Width - FRightTree.Width;
  FRightTree.Height := FLeftTree.Height;

  FLeftLabel.Width := FLeftTree.Width;

  FRightLabel.Left := FRightTree.Left;
  FRightLabel.Width := FRightTree.Width;

  FToRightButton.Top := 16 + (Height - 73) div 2;
  FToRightButton.Left := FLeftTree.Width + 7;

  FToLeftButton.Top := FToRightButton.Top + 32;
  FToLeftButton.Left := FToRightButton.Left;
end;

procedure TosDBDualTree.RightTreeChange(Sender: TObject; Node: TTreeNode);
begin
  if not FClearing then
  begin
    if Node.Level = FLevelCount - 1 then
    begin
{ TODO : Descobrir por que o Locate n�o funciona se n�o for feito um
  TDataSet.First primeiro. O caso de teste usava o form Cargo, com um detalhe
  (fun��o) para o cargo e tr�s detalhes (processos) para a fun��o }
      FAssociationDataSet.First;

      Assert(FAssociationDataSet.Locate(FAssociationFieldName,
          VarArrayOf([TVariantRef(Node.Data).Value]), []), 'Could not locate the '
          + 'corresponding field in the dataset. Maybe the dataset has changed '
          + 'while it was been edited by the control');

      FAssociationDataSet.Locate(FAssociationFieldName,
          VarArrayOf([TVariantRef(Node.Data).Value]), []);
      DoNodeSelect(True);
    end
    else
      DoNodeSelect(False);
  end;
end;

procedure TosDBDualTree.SetAssociationFieldName(const Value: string);
begin
  FAssociationFieldName := Value;
  if Assigned(FAssociationDataSet) then
    FAssociationField := FAssociationDataSet.FindField(Value);
end;

procedure TosDBDualTree.SetAssociationCaption(const Value: string);
begin
  FRightLabel.Caption := Value;
end;

procedure TosDBDualTree.SetSourceCaption(const Value: string);
begin
  FLeftLabel.Caption := Value;
end;

procedure TosDBDualTree.SetSourceDescFieldNames(const Value: TStrings);
var
  i: integer;
begin
  FSourceDescFieldNames.Assign(Value);

  if Assigned(FSourceDataSet) then
  begin
    FLevelCount := FSourceDescFieldNames.Count;
    SetLength(FSourceDescFields, FLevelCount);
    for i := 0 to FLevelCount - 1 do
      FSourceDescFields[i] :=
          FSourceDataSet.FindField(FSourceDescFieldNames[i]);
  end;
end;

procedure TosDBDualTree.SetSourceFieldName(const Value: string);
begin
  FSourceFieldName := Value;
  if Assigned(FSourceDataSet) then
    FSourceField := FSourceDataSet.FindField(Value);
end;

procedure TosDBDualTree.ToLeftButtonClick(Sender: TObject);
begin
  MoveSelectedNodes(FRightTree, FLeftTree);
end;

procedure TosDBDualTree.ToRightButtonClick(Sender: TObject);
begin
  MoveSelectedNodes(FLeftTree, FRightTree);
end;

procedure TosDBDualTree.DoLeftNodeSelect(LeafSelected: boolean);
begin
  if Assigned(FOnLeftNodeSelect) then
    FOnLeftNodeSelect(LeafSelected);
end;

procedure TosDBDualTree.LeftTreeChange(Sender: TObject; Node: TTreeNode);
begin
  if not FClearing then
  begin
    if Node.Level = FLevelCount - 1 then
    begin
      if FSourceDataSet.Active then
      begin
        FSourceDataSet.First;

        Assert(FSourceDataSet.Locate(FSourceFieldName,
            VarArrayOf([TVariantRef(Node.Data).Value]), []), 'Could not locate the '
            + 'corresponding field in the dataset. Maybe the dataset has changed '
            + 'while it was been edited by the control');

        FSourceDataSet.Locate(FSourceFieldName,
            VarArrayOf([TVariantRef(Node.Data).Value]), []);
        DoLeftNodeSelect(True);
      end;
    end
    else
      DoLeftNodeSelect(False);
  end;
end;

procedure TosDBDualTree.LeftTreeEnter(Sender: TObject);
begin
  if Assigned(FLeftTree.Selected) then
    LeftTreeChange(FLeftTree, FLeftTree.Selected);
end;

procedure TosDBDualTree.RightTreeEnter(Sender: TObject);
begin
  if Assigned(FRightTree.Selected) then
    RightTreeChange(FRightTree, FRightTree.Selected);
end;

end.




