unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, TimerLst, RXShell, ExtCtrls;

type
  Tfrm_Principal = class(TForm)
    RxTrayIcon1: TRxTrayIcon;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Configurar1: TMenuItem;
    N2: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    N3: TMenuItem;
    LOGdaltimacpia1: TMenuItem;
    Timer1: TTimer;
    BackupRestore1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Configurar1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RestaurarCpiadeSegurana1Click(Sender: TObject);

    procedure LOGdaltimacpia1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure BackupRestore1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    nMinutos: Integer;
    lAutomatico: Boolean;
    cVersao: string;

    function SalvarBackup() : Boolean;
  end;

var
  frm_Principal: Tfrm_Principal;

implementation

uses u_Configuracao, uBackup, u_LOG, u_Splash;

{$R *.DFM}

procedure Tfrm_Principal.Sair1Click(Sender: TObject);
begin
   frm_Principal.Close;
end;

procedure Tfrm_Principal.Configurar1Click(Sender: TObject);
begin
   frm_Configuracao.ShowModal;
end;                 

procedure Tfrm_Principal.Timer1Timer(Sender: TObject);
var
  bIniciar:  Boolean;
  sTime: String;

begin
    bIniciar := False;

    with frm_Configuracao do begin
        if gr_BACKUP.ItemIndex = 1 then begin
            sTime := FormatDateTime( 'hh:mm', Now );

            bIniciar := ( sTime = mk_H1.Text ) or
                        ( sTime = mk_H2.Text ) or
                        ( sTime = mk_H3.Text ) or
                        ( sTime = mk_H4.Text ) or
                        ( sTime = mk_H5.Text ) or
                        ( sTime = mk_H6.Text );

        end else if ( gr_BACKUP.ItemIndex = 2 ) and
                    ( nMinutos >= frm_Configuracao.se_MINU.Value ) then begin

            bIniciar := True;
        end;    //if
    end;    //with

    if bIniciar then begin
        lAutomatico := True;
        frm_Backup := TFrm_Backup.Create( Owner );
        with frm_Backup do begin
            frm_Backup.Show;
            imgAvancarClick(nil);
            Update;
            if Self.SalvarBackup then begin
                Hide;
                Free;
            end;
            nMinutos := 0;
        end;
    end;

    lAutomatico := False;
    Inc( nMinutos );
    //if nMinutos > frm_Configuracao.se_MINU.Value then nMinutos := 0;
end;


procedure Tfrm_Principal.FormCreate(Sender: TObject);
begin
   nMinutos := 0;
   lAutomatico := False;
   cVersao := 'IBBackup v2.0';

   Caption := cVersao;
end;          

procedure Tfrm_Principal.RestaurarCpiadeSegurana1Click(Sender: TObject);
begin

end;


// Executa a cópia de segurança
function Tfrm_Principal.SalvarBackup(): boolean;
var
  cDateTime: TDateTime;
  cPath: String;
  cArquivo: TextFile;
  cLinha: String;

begin
  frm_Principal.Timer1.Enabled := False;
           
  cPath := ExtractFilePath( Application.ExeName );
  cPath := cPath + 'BACKUP.LOG';

  AssignFile( cArquivo, cPath );
  ReWrite( cArquivo );

  with frm_Backup do begin
    IB_Backup.BackupFile.Clear;
    IB_Backup.DatabaseName := File_GDB.Text;
    IB_Backup.BackupFile.Add( File_GBK.Text );

    lblOperacao.Caption := 'Operação de Backup';

    try
      IB_Backup.Active := True;
      IB_Backup.ServiceStart;

      cDateTime := Now;
      re_LOG.Lines.Clear;

      cLinha := '*** Início do BACKUP às ' +
                                  FormatDateTime( 'dd/mm/yyyy hh:mm:ss', cDateTime );

      re_LOG.Lines.Insert( 0, cLinha );
      re_LOG.SelStart := 0;
      re_LOG.SelLength := Length(cLinha);
      re_LOG.SelText;
      frm_Backup.CurrText.Color := clGreen;
      Application.ProcessMessages;

      WriteLn( cArquivo, cLinha );

      re_LOG.Lines.Insert( 0, '' );
      WriteLn( cArquivo, '' );

      while not IB_Backup.Eof do begin
        cLinha := IB_Backup.GetNextLine;

        re_LOG.Lines.Insert( 0, cLinha );
        re_LOG.SelStart :=  0;
        re_LOG.SelLength := Length(cLinha);
        re_LOG.SelText;
        frm_Backup.CurrText.Color := clBlack;
        Application.ProcessMessages;

        WriteLn( cArquivo, cLinha );

        if lAutomatico then  Update;
      end;
      Result := True;
    except
      Result := False;
      IB_Backup.Active := False;

      cLinha := '*** FALHA DURANTE O BACKUP às ' +
                                        FormatDateTime( 'dd/mm/yyyy hh:mm:ss', Now );

      re_LOG.Lines.Insert( 0, cLinha );
      re_LOG.SelStart := 0;
      re_LOG.SelLength := Length(cLinha);
      re_LOG.SelText;
      frm_Backup.CurrText.Color := clRed;
      frm_Backup.CurrText.Style := CurrText.Style + [fsBold];
      Application.ProcessMessages;

      WriteLn( cArquivo, cLinha );

      if lAutomatico then Update;
    end;

    if IB_Backup.Active then begin
      IB_Backup.Active := False;

      cLinha := '*** Fim do BACKUP às ' +
                   FormatDateTime( 'dd/mm/yyyy hh:mm:ss', Now ) + ' - Duração: ' +
                   FormatDateTime( 'dd/mm/yyyy hh:mm:ss', Now - cDateTime );

      re_LOG.Lines.Insert( 0, cLinha );
      re_LOG.SelStart := 0;
      re_LOG.SelLength := Length(cLinha);
      re_LOG.SelText;
      frm_Backup.CurrText.Color := clGreen;
      Application.ProcessMessages;

      WriteLn( cArquivo, cLinha );

      if lAutomatico then Update;
    end;

    CloseFile( cArquivo );
  end;
end;


procedure Tfrm_Principal.LOGdaltimacpia1Click(Sender: TObject);
begin
   frm_LOG.ShowModal;
end;

procedure Tfrm_Principal.Sobre1Click(Sender: TObject);
begin
  frm_uSplash := Tfrm_uSplash.Create( Owner );

  with frm_uSplash do begin
    ShowModal;
    Hide;
    Free;
  end;
end;

procedure Tfrm_Principal.BackupRestore1Click(Sender: TObject);
begin
  frm_Backup.ShowModal;
  nMinutos := 0;
end;

end.
