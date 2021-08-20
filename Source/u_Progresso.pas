unit u_Progresso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  Tfrm_uProgress = class(TForm)
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_uProgress: Tfrm_uProgress;

implementation

uses uPrincipal;

{$R *.DFM}


procedure Tfrm_uProgress.FormCreate(Sender: TObject);
begin
  Caption := frm_Principal.cVersao;
end;

end.
