unit u_LOG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls;

type
  Tfrm_LOG = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    re_LOG2: TRichEdit;
    re_LOG1: TRichEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);

    function Size_Arquivo( cArquivo: String ): Integer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOG: Tfrm_LOG;

implementation

  Uses u_Progresso, uPrincipal;

{$R *.DFM}


procedure Tfrm_LOG.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = 27 then
    Close;

  if Shift = [ssCtrl] then
    case Key of
      VK_NEXT: PageControl1.SelectNextPage( True );
      VK_PRIOR: PageControl1.SelectNextPage( False );
    end;

end;


procedure Tfrm_LOG.FormActivate(Sender: TObject);
var
  cLinha: String;
  cPath: String;
  cArquivo: TextFile;
  nSize: Integer;

begin
  frm_LOG.OnActivate := nil;
  frm_LOG.Repaint;

  // Backup

  cPath := ExtractFilePath( Application.ExeName );

  re_LOG1.Lines.Clear;
  re_LOG2.Lines.Clear;

  frm_uProgress := Tfrm_uProgress.Create( Owner );

  with frm_uProgress do begin
    Show;

    ProgressBar1.Position := 0;
    ProgressBar2.Position := 0;

    Update;
  end;

  if FileExists( cPath + 'BACKUP.LOG' ) then begin

    nSize := Size_Arquivo( cPath + 'BACKUP.LOG' );

    frm_uProgress.ProgressBar1.Max := nSize;

    AssignFile( cArquivo, cPath + 'BACKUP.LOG' );
    Reset( cArquivo );

    re_LOG1.Lines.Clear;

    while not Eof( cArquivo ) do begin
      ReadLn( cArquivo, cLinha );

      re_LOG1.Lines.Insert( 0, cLinha );

      frm_uProgress.ProgressBar1.Position :=
                    frm_uProgress.ProgressBar1.Position + Length( cLinha );

      frm_uProgress.Update;
    end;

    CloseFile( cArquivo );
  end;


  // Restauração

  if FileExists( cPath + 'RESTORE.LOG' ) then begin

    nSize := Size_Arquivo( cPath + 'RESTORE.LOG' );

    frm_uProgress.ProgressBar2.Max := nSize;

    AssignFile( cArquivo, cPath + 'RESTORE.LOG' );
    Reset( cArquivo );

    re_LOG2.Lines.Clear;

    while not Eof( cArquivo ) do begin
      ReadLn( cArquivo, cLinha );

      re_LOG2.Lines.Insert( 0, cLinha );

      frm_uProgress.ProgressBar2.Position :=
                    frm_uProgress.ProgressBar2.Position + Length( cLinha );

      frm_uProgress.Update;
    end;

    CloseFile( cArquivo );
  end;

  frm_uProgress.Hide;
  frm_uProgress.Free;
end;


function Tfrm_LOG.Size_Arquivo(cArquivo: String): Integer;
begin
  try
    with TFileStream.Create( cArquivo, fmOpenRead or
                                               fmShareExclusive ) do begin
       try
         Result := Size;
       finally
         Free;
       end;
    end;
  except
    Result := 0;
  end;

end;

procedure Tfrm_LOG.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   frm_LOG.OnActivate := FormActivate;
end;


procedure Tfrm_LOG.FormCreate(Sender: TObject);
begin
  Caption := frm_Principal.cVersao;
end;

end.
