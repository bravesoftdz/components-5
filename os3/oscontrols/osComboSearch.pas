{* osComboSearch
 * In�cio da documenta��o, o componente j� funciona mas n�o estava documentado
 * Respons�vel: Ricardo N. Acras
 * Altera��es:
 *        => 07/10/2005 - Tornar o componente DB free, para poder funcionar
 *                        sem estar ligado a um banco de dados.
 *          - verifica��o do dataSource e dataSet nos momentos em que � feito o
 *            acesso ao field. Caso n�o exista um field dever� fazer um
 *            tratamento diferenciado.
 *          - cria��o das propriedades ReturnedValue e ReturnTextField. A
 *            primeira serve para guardar o valor retornado, caso este n�o possa
 *            ser guardado num field. A segunda � o nome do campo na tela de
 *            busca que deve ser mostrado no componente, isto por que, quando
 *            n�o se tem field, n�o da pra fazer o lookup
}

unit osComboSearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, wwdbedit, Wwdotdot, osCustomSearchFrm, dbclient, db,
  provider, wwDataInspector;

type
  TReturnSearchEvent = procedure(Sender: TObject; Dataset: TDataset) of object;

  TosComboSearch = class(TwwDBComboDlg)
  private
    FSearchDlg: TCustomSearchForm;
    FReturnField: string;
    FFilterDefName: string;
    FAutoSearchNumber: integer;
    FReturnedValue: variant;
    FOnReturnSearch: TReturnSearchEvent;
    FAllowClearKey: boolean;
    FFilterDefParams: TStringList;
    FReturnLookupField: string;
    FOnCancelSearch: TReturnSearchEvent;
    FReturnTextField: string;
    FRuntimeFilter: string;
    function GetFilterDefName: string;
    procedure SetReturnField(const Value: string);
    procedure SetFilterDefName(const Value: string);
    procedure HandlerCustomDlg(Sender: TObject);
    procedure HandlerExit(Sender: TObject);
    procedure SetAutoSearchNumber(const Value: integer);
    procedure SetFilterDataProvider(const Value: TCustomProvider);
    function GetFilterDataProvider: TCustomProvider;
    function getModified: Boolean;
    procedure SetSearchDlg(const Value: TCustomSearchForm);
  protected
    procedure Loaded; override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure SendFilterDefParams;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ReturnedValue: variant read FReturnedValue;
    property isModified: Boolean read getModified;
    property RuntimeFilter: string read FRuntimeFilter write FRuntimeFilter;
    property SearchDlg: TCustomSearchForm read FSearchDlg write SetSearchDlg;
    procedure ClearFilter;
    procedure Execute;
    procedure GetParamsHandler(Sender: TObject);    
  published
    property FilterDataProvider : TCustomProvider read GetFilterDataProvider write SetFilterDataProvider;
    property FilterDefName: string read GetFilterDefName write SetFilterDefName;
    property ReturnField: string read FReturnField write SetReturnField;
    property ReturnLookupField: string read FReturnLookupField write FReturnLookupField;
    property ReturnTextField: string read FReturnTextField write FReturnTextField;
    property AutoSearchNumber: integer read FAutoSearchNumber write SetAutoSearchNumber default 3;
    property AllowClearKey : boolean read FAllowClearKey write FAllowClearKey;
    property FilterDefParams: TStringList read FFilterDefParams write FFilterDefParams;
    property OnReturnSearch: TReturnSearchEvent read FOnReturnSearch write FOnReturnSearch;
    property OnCancelSearch: TReturnSearchEvent read FOnCancelSearch write FOnCancelSearch;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('OS Controls', [TosComboSearch]);
end;

{ TosComboSearch }

constructor TosComboSearch.Create(AOwner: TComponent);
begin
  inherited;
  FSearchDlg := TCustomSearchForm.Create(Application);
  FSearchDlg.ConsultaCombo.GetParams := GetParamsHandler;
  OnCustomDlg := HandlerCustomDlg;
  OnExit := HandlerExit;
  FAutoSearchNumber := 3;
  FFilterDefParams := TStringList.Create;
  Modified := false;
end;

function TosComboSearch.GetFilterDataProvider: TCustomProvider;
begin
  Result := FSearchDlg.DataProvider;
end;

function TosComboSearch.GetFilterDefName: string;
begin
  Result := FFilterDefName;
end;

procedure TosComboSearch.HandlerCustomDlg(Sender: TObject);
var
  Dataset: TDataset;
begin
  FSearchDlg.RuntimeFilter := RuntimeFilter;
  SendFilterDefParams;
  if FSearchDlg.Execute('', FAutoSearchNumber) then
  begin
    //Application.ProcessMessages;
    if FSearchDlg.Selected then
    begin

      if (TwwDBComboDlg(Sender).DataSource <> nil) AND
         (TwwDBComboDlg(Sender).DataSource.DataSet <> nil) then
      begin
        Dataset := TwwDBComboDlg(Sender).DataSource.Dataset;
        //Dataset.DisableControls;
        Dataset.Edit;
        if ReturnField <> '' then
        begin
          if FReturnLookupField = '' then
            FReturnLookupField := FReturnField;
          FReturnedValue := FSearchDlg.GetFieldValue(FReturnLookupField);
          Dataset.FieldByName(ReturnField).Value := FReturnedValue;
        end;
        { TODO : Verificar a necessidade do m�todo  RefreshCalcFields }
        //TClientDataset(Dataset).RefreshCalcFields;
        //Dataset.EnableControls;
      end
      else
      begin
        if FReturnLookupField = '' then
          FReturnLookupField := FReturnField;
        FReturnedValue := FSearchDlg.GetFieldValue(FReturnLookupField);
        Text := FSearchDlg.GetFieldValue(FReturnTextField);
      end;
      Modified := false;
      if Assigned(FOnReturnSearch) then
        FOnReturnSearch(Self, FSearchDlg.FilterDataset);
      Modified := false;
    end;
  end
  else
  begin
    FReturnedValue := Integer(-1);
    if Assigned(FOnCancelSearch) then
      FOnCancelSearch(Self, FSearchDlg.FilterDataset);
  end;
  Modified := false;Modified := false;Modified := false;
end;

procedure TosComboSearch.HandlerExit(Sender: TObject);
var
  Dataset: TDataset;

  begin
  FSearchDlg.RuntimeFilter := RuntimeFilter;
  if (Modified) and (Trim(Text) <> '') then
  begin
    if FSearchDlg.Execute(TosComboSearch(Sender).Text, FAutoSearchNumber) then
    begin
      if FSearchDlg.Selected then
      begin
        if FReturnLookupField = '' then
          FReturnLookupField := FReturnField;
        FReturnedValue := FSearchDlg.GetFieldValue(FReturnLookupField);
        Text := FSearchDlg.GetFieldValue(FReturnTextField);
        //se o componente estiver "deitado" em um dataInspector, como deve
        //ocorrer no caso de filtro dentro de filtro, seta tamb�m o texto do
        //n� do dataInspector
        if (parent is TwwDataInspector) then
          TwwDataInspector(parent).GetItemByRow(TwwDataInspector(parent).Row).EditText := text;

        if (TwwDBComboDlg(Sender).DataSource <> nil)
           AND (TwwDBComboDlg(Sender).DataSource.DataSet <> nil) then
        begin
          Dataset := TwwDBComboDlg(Sender).DataSource.Dataset;
          Dataset.DisableControls;
          Dataset.Edit;
          if ReturnField <> '' then
            if  Dataset.FieldByName(ReturnField).Value <> FReturnedValue then
              Dataset.FieldByName(ReturnField).Value := FReturnedValue;
          //TPersistClientDS(Dataset).RefreshCalcFields;
          Dataset.EnableControls;
          Modified := false;
        end;
        if Assigned(FOnReturnSearch) then
          FOnReturnSearch(Self, FSearchDlg.FilterDataset);
      end;
    end
    else
    begin
      FReturnedValue := Integer(-1);
      if Assigned(FOnCancelSearch) then
        FOnCancelSearch(Self, FSearchDlg.FilterDataset);
    end;
  end;
end;

procedure TosComboSearch.KeyUp(var Key: Word; Shift: TShiftState);
var
  Dataset: TDataset;
begin
  if ((Key=vk_delete) or (Key=vk_back)) and
     ((Text='') or (SelLength=Length(Text))) and
     (FReturnField <> '') then
  begin
    FReturnedValue := -1;
    if (Self.DataSource <> nil)
       AND (self.DataSource.DataSet <> nil) then
    begin
      Dataset := Self.DataSource.Dataset;
      Dataset.DisableControls;
      Dataset.Edit;
      Dataset.FieldByName(ReturnField).Clear;
      Dataset.EnableControls;
    end;
  end;
  inherited KeyUp(Key, Shift);
end;

procedure TosComboSearch.Loaded;
begin
  inherited;
  FSearchDlg.FilterDefName := FFilterDefName;
end;

procedure TosComboSearch.SetAutoSearchNumber(const Value: integer);
begin
  FAutoSearchNumber := Value;
end;

procedure TosComboSearch.SetFilterDataProvider(const Value: TCustomProvider);
begin
  if Value <> FSearchDlg.DataProvider then
    FSearchDlg.DataProvider := Value;
end;

procedure TosComboSearch.SetReturnField(const Value: string);
begin
  FReturnField := Value;
end;

procedure TosComboSearch.SetFilterDefName(const Value: string);
begin
  if Value <> FFilterDefName then
  begin
    FFilterDefName := Value;
    if Assigned(FSearchDlg) then
      FSearchDlg.FilterDefName := Value;
  end;
end;

procedure TosComboSearch.ClearFilter;
begin
  FSearchDlg.ClearFilter;
end;

destructor TosComboSearch.Destroy;
begin
  FFilterDefParams.Free;
  if (not application.terminated) and (Assigned(FSearchDlg)) then
    FreeAndNil(FSearchDlg);

  inherited;
end;

{-------------------------------------------------------------------------
�Objetivo�� > Enviar par�metros para a pesquisa no filtro
�Par�metros > Conforme documenta��o
�Retorno��� >
�Cria��o��� >
�Observa��es> Nunca pode ser chamada diretamente pelo c�digo
�Atualiza��o> 08/02/2005 Ricardo N. Acras
                  Altera��o na busca do par�metro. Trocado paramByName por
                    findParam. ParamByName da erro caso o par�metro n�o
                    exista. Acontece que o SendFilterDefParams � disparado
                    em alguns momentos em que os par�metros ainda n�o
                    foram criados.
�------------------------------------------------------------------------}
procedure TosComboSearch.SendFilterDefParams;
var
  i: integer;
  Param: TParam;
  Dataset: TDataset;
begin
  if FFilterDefParams.Count > 0 then
  begin
    if (TwwDBComboDlg(self).DataSource = nil)
           OR (TwwDBComboDlg(self).DataSource.DataSet = nil) then
      raise Exception.Create('Imposs�vel mandar par�metros sem um DataSet atribu�do.');

    Dataset := TwwDBComboDlg(Self).DataSource.Dataset;
    for i:=0 to FFilterDefParams.Count-1 do
    begin
      Param := FSearchDlg.ConsultaCombo.Params.FindParam(FFilterDefParams[i]);
      if Assigned(Param) then
        Param.Value := Dataset.FieldByName(FFilterDefParams[i]).Value;
    end;
  end;
end;

procedure TosComboSearch.GetParamsHandler(Sender: TObject);
begin
  SendFilterDefParams;
end;

function TosComboSearch.getModified: Boolean;
begin
  result := Modified;
end;

procedure TosComboSearch.Execute;
begin
  HandlerCustomDlg(self);
end;


procedure TosComboSearch.SetSearchDlg(const Value: TCustomSearchForm);
var
  prov: TCustomProvider;
  defName: string;
begin
  prov := FilterDataProvider;
  FSearchDlg := Value;
  FilterDataProvider := prov;
  FSearchDlg.ConsultaCombo.GetParams := GetParamsHandler;
  defName := FilterDefName;
  FilterDefName := '';
  FilterDefName := defName;
end;

end.

