�
 TFORM1 0>  TPF0TForm1Form1Left� TopkBorderStylebsDialogCaptionDB demoClientHeight�ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style OldCreateOrderPositionpoScreenCenterPixelsPerInch`
TextHeight TButtonButton1LeftTopWidthKHeightCaption
Run ScriptTabOrder OnClickButton1Click  TMemoMemo1LeftTop$Width�Height�Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.Stringsvar  DBForm: TForm;  Table: TTable;  DataSource: TDataSource;  Grid: TDBGrid;begin  DBForm := TForm.Create(nil);'  DBForm.SetBounds(100, 100, 400, 400);  !  Table := TTable.Create(DBForm);"  Table.DatabaseName := 'DBDEMOS';#  Table.TableName := 'customer.db';  Table.Open; +  DataSource := TDataSource.Create(DBForm);  DataSource.DataSet := Table; !  Grid := TDBGrid.Create(DBForm);   Grid.DataSource := DataSource;  Grid.Parent := DBForm;  Grid.Align := alClient;   DBForm.ShowModal;  DBForm.Free;end. 
ParentFontTabOrder  	TfsScript	fsScript1
SyntaxTypePascalScriptLeftpTop  TfsFormsRTTIfsFormsRTTI1Left� Top  
TfsBDERTTI
fsBDERTTI1Left� Top  TfsDBCtrlsRTTIfsDBCtrlsRTTI1Left� Top  	TfsPascal	fsPascal1Left� Top   