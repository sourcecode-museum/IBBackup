unit u_Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, RxGIF, ExtCtrls, RXCtrls, Buttons;

type
  Tfrm_uSplash = class(TForm)
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RxLabel1: TRxLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_uSplash: Tfrm_uSplash;

implementation

uses uPrincipal;

{$R *.DFM}

procedure Tfrm_uSplash.FormCreate(Sender: TObject);
begin
  Caption := frm_Principal.cVersao;
end;

procedure Tfrm_uSplash.Image3Click(Sender: TObject);
begin
  Close;
end;

end.
