program IBBackup;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frm_Principal},
  u_Configuracao in 'u_Configuracao.pas' {frm_Configuracao},
  uBackup in 'uBackup.pas' {frm_Backup},
  u_LOG in 'u_LOG.pas' {frm_LOG},
  u_Progresso in 'u_Progresso.pas' {frm_uProgress},
  u_Splash in 'u_Splash.pas' {frm_uSplash},
  uFuncVB in 'uFuncVB.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  Application.Title := 'IBBackup';
  Application.CreateForm(Tfrm_Principal, frm_Principal);
  Application.CreateForm(Tfrm_Backup, frm_Backup);
  Application.CreateForm(Tfrm_LOG, frm_LOG);
  Application.CreateForm(Tfrm_Configuracao, frm_Configuracao);
  Application.Run;
end.
