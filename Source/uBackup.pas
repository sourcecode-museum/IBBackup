unit uBackup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls, IBServices, RXCtrls, RxGIF, Mask,
  ToolEdit, uFuncVB;

type
  Tfrm_Backup = class(TForm)
    IB_Restore: TIBRestoreService;
    Panel2: TPanel;
    Image1: TImage;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    RxLabel1: TRxLabel;
    rdgOpcao: TRadioGroup;
    Panel4: TPanel;
    imgFinalizar: TImage;
    imgAvancar: TImage;
    imgVoltar: TImage;
    lblFinalizar: TLabel;
    lblAvancar: TLabel;
    lblVoltar: TLabel;
    pnlArquivo: TPanel;
    GroupBox1: TGroupBox;
    File_GDB: TFilenameEdit;
    lblArqBackup: TLabel;
    Label1: TLabel;
    re_LOG: TRichEdit;
    File_GBK: TFilenameEdit;
    IB_Backup: TIBBackupService;
    lblOperacao: TLabel;
    procedure FormActivate(Sender: TObject);

    procedure bt_CANCClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure File_GDBBeforeDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure imgFinalizarClick(Sender: TObject);
    procedure imgAvancarClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure File_GDBChange(Sender: TObject);
    procedure File_GBKChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function CurrText: TTextAttributes;
    procedure Restaurar();
  end;

var
  frm_Backup: Tfrm_Backup;

implementation

  Uses uPrincipal, u_Configuracao;

{$R *.DFM}

function Tfrm_Backup.CurrText: TTextAttributes;
begin
  if re_LOG.SelLength > 0 then Result := re_LOG.SelAttributes
  else Result := re_LOG.DefAttributes;
end;

// Prepara algumas informações

procedure Tfrm_Backup.FormActivate(Sender: TObject);
begin
  File_GDB.Text := frm_Configuracao.File_GDB.Text;
  File_GBK.Text := frm_Configuracao.File_GBK.Text;
end;

// Executa a RESTAURAÇÃO DO ARQUIVO

procedure Tfrm_Backup.Restaurar();
var
  cDateTime: TDateTime;
  cPath: String;
  cArquivo: TextFile;
  cLinha: String;

begin
    frm_Principal.Timer1.Enabled := False;

  IB_Restore.DataBaseName.Clear;
  IB_Restore.BackupFile.Clear;

  IB_Restore.DataBaseName.Add( File_GDB.Text );
  IB_Restore.BackupFile.Add( File_GBK.Text );

  lblOperacao.Caption := 'Operação de Restauração';

  if IB_Restore.Active then begin
     MessageBeep(0);

     MessageDlg( 'É necessário aguardar o encerramento do'
               + #13 + 'processo já em andamento.', mtWarning, [mbOk], 0 );
     Abort;
   end;

  MessageBeep(0);

  if MessageDlg( 'Tem CERTEZA que deseja restaura a cópia de segurança.',
              mtConfirmation, [mbYes, mbNo], 0 ) <> mrYes then
    Abort;

  cPath := ExtractFilePath( Application.ExeName );

  cPath := cPath + 'RESTORE.LOG';

  AssignFile( cArquivo, cPath );
  ReWrite( cArquivo );


  try
    IB_Restore.Active := True;

    IB_Restore.ServiceStart;

    cDateTime := Now;

    cLinha := '*** Início da RESTAURAÇÃO às ' +
              FormatDateTime( 'dd/mm/yyyy hh:mm:ss', cDateTime );


    re_LOG.Lines.Insert( 0, cLinha );
    re_LOG.SelStart := 0;
    re_LOG.SelLength := Length(cLinha);
    re_LOG.SelText;
    Self.CurrText.Color := clGreen;
    Application.ProcessMessages;

    WriteLn( cArquivo, cLinha );

    re_LOG.Lines.Insert( 0, '' );
    WriteLn( cArquivo, cLinha );

    while not IB_Restore.Eof do begin
      cLinha := IB_Restore.GetNextLine;

      re_LOG.Lines.Insert( 0, cLinha );
      re_LOG.SelStart := 0;
      re_LOG.SelLength := Length(cLinha);
      re_LOG.SelText;
      Self.CurrText.Color := clBlack;

      WriteLn( cArquivo, cLinha );
      Application.ProcessMessages;
    end;

  except
    IB_Restore.Active := False;

    cLinha := '*** FALHA NA RESTAURAÇÃO às ' +
                                        FormatDateTime( 'dd/mm/yyyy hh:mm:ss', Now );
    re_LOG.Lines.Insert( 0, cLinha );
    re_LOG.SelStart := 0;
    re_LOG.SelLength := Length(cLinha);
    re_LOG.SelText;
    Self.CurrText.Color := clRed;
    Self.CurrText.Style := Self.CurrText.Style + [fsBold];
    Application.ProcessMessages;
    
    WriteLn( cArquivo, cLinha );

  end;

  if IB_Restore.Active then begin
     IB_Restore.Active := False;

     cLinha := '*** Fim da RESTAURAÇÃO às ' +
                 FormatDateTime( 'dd/mm/yyyy hh:mm:ss', Now ) + ' - Duração: ' +
                            FormatDateTime( 'dd/mm/yyyy hh:mm:ss', Now - cDateTime );


    re_LOG.Lines.Insert( 0, cLinha );
    re_LOG.SelStart := 0;
    re_LOG.SelLength := Length(cLinha);
    re_LOG.SelText;
    Self.CurrText.Color := clGreen;

    Application.ProcessMessages;

    WriteLn( cArquivo, cLinha );
  end;

  CloseFile( cArquivo );
end;


procedure Tfrm_Backup.bt_CANCClick(Sender: TObject);
begin
   if IB_Restore.Active then begin
     MessageBeep(0);

     MessageDlg( 'É necessário aguardar o encerramento do'
               + #13 + 'processo já em andamento.', mtWarning, [mbOk], 0 );
   end else
     Close;
end;


procedure Tfrm_Backup.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then
     bt_CANCClick( nil );
end;


procedure Tfrm_Backup.FormCreate(Sender: TObject);
begin
  Caption := frm_Principal.cVersao;
end;

procedure Tfrm_Backup.File_GDBBeforeDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
  if File_GDB.Text = '' then
    File_GDB.InitialDir := ExtractFilePath(Application.ExeName);
end;

procedure Tfrm_Backup.imgFinalizarClick(Sender: TObject);
begin
   if IB_Restore.Active or IB_Backup.Active then begin
     MessageBeep(0);

     MessageDlg( 'É necessário aguardar o encerramento do'
               + #13 + 'processo já em andamento.', mtWarning, [mbOk], 0 );
   end else
     Close;
end;

procedure Tfrm_Backup.imgAvancarClick(Sender: TObject);
begin
  if lblAvancar.Caption = '&Avançar' then begin
    pnlArquivo.Visible := True;
    imgVoltar.Visible := True;
    lblVoltar.Visible := True;

    if rdgOpcao.ItemIndex = 0 then
      lblAvancar.Caption := '&Backup'
    else
      lblAvancar.Caption := '&Restaurar';

  end else begin
    if lblAvancar.Caption = '&Backup' then
       if IB_Restore.Active then begin
         MessageBeep(0);

         MessageDlg( 'É necessário aguardar o encerramento do'
                     + #13 + 'processo já em andamento.', mtWarning, [mbOk], 0 );
       end else
         frm_Principal.SalvarBackup

    else
      Self.Restaurar;
  end;
end;

procedure Tfrm_Backup.imgVoltarClick(Sender: TObject);
begin
  lblOperacao.Caption := '';

  lblAvancar.Caption := '&Avançar';
  pnlArquivo.Visible := False;
  imgVoltar.Visible := False;
  lblVoltar.Visible := False;
end;

procedure Tfrm_Backup.File_GDBChange(Sender: TObject);
var
    sGDB : string;
begin
    file_gdb.Text := Replace(file_gdb.Text,'"','');
    sGDB := file_gdb.Text;
    if sGDB <> '' then
        File_GBK.Text := Copy(sGDB,1,Length(sGDB)-3) + 'GBK'
    else
        File_GBK.Text := '';
end;

procedure Tfrm_Backup.File_GBKChange(Sender: TObject);
begin
    file_gbk.Text := Replace(file_gbk.Text,'"','');
end;

procedure Tfrm_Backup.FormDestroy(Sender: TObject);
begin
    frm_Principal.Timer1.Enabled := True;
end;

procedure Tfrm_Backup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    frm_Principal.Timer1.Enabled := True;
end;

end.
