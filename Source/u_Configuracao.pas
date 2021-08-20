unit u_Configuracao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Spin, StdCtrls, Mask, ExtCtrls, Buttons, ToolEdit, WinXP, uFuncVB;

type
  Tfrm_Configuracao = class(TForm)
    Panel1: TPanel;
    gr_BACKUP: TRadioGroup;
    grpHora: TGroupBox;
    Label3: TLabel;
    mk_H1: TMaskEdit;
    Label4: TLabel;
    mk_H2: TMaskEdit;
    mk_H4: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    mk_H3: TMaskEdit;
    Label7: TLabel;
    Label8: TLabel;
    mk_H6: TMaskEdit;
    mk_H5: TMaskEdit;
    btnSalvar: TButton;
    WinXP1: TWinXP;
    btnCancelar: TButton;
    grpMinuto: TGroupBox;
    grpPath: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    File_GBK: TFilenameEdit;
    File_GDB: TFilenameEdit;
    se_MINU: TSpinEdit;
    Label9: TLabel;
    procedure bt_PATH1Click(Sender: TObject);
    procedure bt_PATH2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Ler_Configuracao;
    procedure se_MINUChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure mk_H1Exit(Sender: TObject);
    procedure mk_H2Exit(Sender: TObject);
    procedure mk_H3Exit(Sender: TObject);
    procedure mk_H5Exit(Sender: TObject);
    procedure mk_H6Exit(Sender: TObject);
    procedure mk_H4Exit(Sender: TObject);
    procedure File_GDBChange(Sender: TObject);
    procedure File_GDBBeforeDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure File_GBKChange(Sender: TObject);
    procedure gr_BACKUPClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure ControleTela(IdxView : integer);
  public
    { Public declarations }
  end;

var
  frm_Configuracao: Tfrm_Configuracao;

implementation

uses uPrincipal;

{$R *.DFM}


// Qual a base de dados

procedure Tfrm_Configuracao.bt_PATH1Click(Sender: TObject);
begin
end;


// Como vai salvar

procedure Tfrm_Configuracao.bt_PATH2Click(Sender: TObject);
begin
end;

// Grava os dados

procedure Tfrm_Configuracao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

end;

// Faz a leitura da configuração do backup

procedure Tfrm_Configuracao.Ler_Configuracao;
var
  cPath: String;
  cFile: TextFile;
  cLinha: String;

begin
  cPath := ExtractFilePath( Application.ExeName );

  AssignFile( cFile, cPath + 'BACKUP.CFG' );

  if FileExists( cPath + 'BACKUP.CFG' ) then
    Reset( cFile )
  else
    frm_Configuracao.ShowModal;

  // Agendamento Selecionado
  ReadLn( cFile, cLinha );
  gr_BACKUP.ItemIndex := StrToInt( cLinha );

  // Horas Programadas
  ReadLn( cFile, cLinha );
  mk_H1.Text := Trim( cLinha );

  ReadLn( cFile, cLinha );
  mk_H2.Text := Trim( cLinha );

  ReadLn( cFile, cLinha );
  mk_H3.Text := Trim( cLinha );

  ReadLn( cFile, cLinha );
  mk_H4.Text := Trim( cLinha );

  ReadLn( cFile, cLinha );
  mk_H5.Text := Trim( cLinha );

  ReadLn( cFile, cLinha );
  mk_H6.Text := Trim( cLinha );


  // Intervalo programado
  ReadLn( cFile, cLinha );
  se_MINU.Value := StrToInt( cLinha );

  // Caminho do arquivo de dados
  ReadLn( cFile, cLinha );
  File_GDB.Text := Trim( cLinha );

  // Caminho para salvar o backup e o nome do arquivo de backup
  ReadLn( cFile, cLinha );
  File_GBK.Text := Trim( cLinha );

  CloseFile( cFile );
end;


procedure Tfrm_Configuracao.se_MINUChange(Sender: TObject);
begin
  frm_Principal.nMinutos := 0;
end;


procedure Tfrm_Configuracao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then
     Close;
end;


procedure Tfrm_Configuracao.FormCreate(Sender: TObject);
begin
  Caption := frm_Principal.cVersao;
  Self.Ler_Configuracao;
end;


procedure Tfrm_Configuracao.mk_H1Exit(Sender: TObject);
begin
  if ( mk_H1.Text <> '  :  ' ) then
    try
      StrToTime( mk_H1.Text );

    except
      MessageBeep(0);
      MessageDlg( 'Hora informada inválida.', mtWarning, [mbOk], 0 );

      mk_H1.SetFocus;
      mk_H1.SelectAll;

      Abort;
    end

end;

procedure Tfrm_Configuracao.mk_H2Exit(Sender: TObject);
begin
  if ( mk_H2.Text <> '  :  ' ) then
    try
      StrToTime( mk_H2.Text );

    except
      MessageBeep(0);
      MessageDlg( 'Hora informada inválida.', mtWarning, [mbOk], 0 );

      mk_H2.SetFocus;
      mk_H2.SelectAll;

      Abort;
    end

end;

procedure Tfrm_Configuracao.mk_H3Exit(Sender: TObject);
begin
  if ( mk_H3.Text <> '  :  ' ) then
    try
      StrToTime( mk_H3.Text );

    except
      MessageBeep(0);
      MessageDlg( 'Hora informada inválida.', mtWarning, [mbOk], 0 );

      mk_H3.SetFocus;
      mk_H3.SelectAll;

      Abort;
    end

end;

procedure Tfrm_Configuracao.mk_H5Exit(Sender: TObject);
begin
  if ( mk_H5.Text <> '  :  ' ) then
    try
      StrToTime( mk_H5.Text );

    except
      MessageBeep(0);
      MessageDlg( 'Hora informada inválida.', mtWarning, [mbOk], 0 );

      mk_H5.SetFocus;
      mk_H5.SelectAll;

      Abort;
    end

end;

procedure Tfrm_Configuracao.mk_H6Exit(Sender: TObject);
begin
  if ( mk_H6.Text <> '  :  ' ) then
    try
      StrToTime( mk_H6.Text );

    except
      MessageBeep(0);
      MessageDlg( 'Hora informada inválida.', mtWarning, [mbOk], 0 );

      mk_H6.SetFocus;
      mk_H6.SelectAll;

      Abort;
    end

end;

procedure Tfrm_Configuracao.mk_H4Exit(Sender: TObject);
begin
  if ( mk_H4.Text <> '  :  ' ) then
    try
      StrToTime( mk_H4.Text );

    except
      MessageBeep(0);
      MessageDlg( 'Hora informada inválida.', mtWarning, [mbOk], 0 );

      mk_H4.SetFocus;
      mk_H4.SelectAll;

      Abort;
    end

end;

procedure Tfrm_Configuracao.File_GDBChange(Sender: TObject);
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

procedure Tfrm_Configuracao.File_GDBBeforeDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
  if File_GDB.Text = '' then
    File_GDB.InitialDir := ExtractFilePath(Application.ExeName);
end;

procedure Tfrm_Configuracao.btnCancelarClick(Sender: TObject);
begin
    Self.Close;
end;

procedure Tfrm_Configuracao.btnSalvarClick(Sender: TObject);
var
  cPath: String;
  cFile: TextFile;
begin
  ActiveControl := nil;

  cPath := ExtractFilePath( Application.ExeName );

  AssignFile( cFile, cPath + 'BACKUP.CFG' );
  ReWrite( cFile );

  // Agendamento Selecionado
  WriteLn( cFile, IntToStr( gr_BACKUP.ItemIndex ) );

  // Horas Programadas
  WriteLn( cFile, mk_H1.Text );
  WriteLn( cFile, mk_H2.Text );
  WriteLn( cFile, mk_H3.Text );
  WriteLn( cFile, mk_H4.Text );
  WriteLn( cFile, mk_H5.Text );
  WriteLn( cFile, mk_H6.Text );

  // Intervalo programado
  WriteLn( cFile, IntToStr( se_MINU.Value ) );

  // Caminho do arquivo de dados
  WriteLn( cFile, File_GDB.Text );

  // Caminho para salvar o backup e o nome do arquivo de backup
  WriteLn( cFile, File_GBK.Text );

  CloseFile( cFile );
  Self.Close;
end;

procedure Tfrm_Configuracao.File_GBKChange(Sender: TObject);
begin
    file_gbk.Text := Replace(file_gbk.Text,'"','');
end;

procedure Tfrm_Configuracao.gr_BACKUPClick(Sender: TObject);
begin
    Self.ControleTela(gr_BACKUP.ItemIndex);
end;

procedure Tfrm_Configuracao.ControleTela(IdxView : integer);
begin
    grpHora.Visible := IdxView = 1;
    grpMinuto.Visible := IdxView = 2;
    grpPath.Visible := IdxView <> 0;
end;

procedure Tfrm_Configuracao.FormActivate(Sender: TObject);
begin
    Self.ControleTela(gr_BACKUP.ItemIndex);
end;

end.
