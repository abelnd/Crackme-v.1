unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls,registry;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  reg        : TRegistry;
  openResult : Boolean;
  today      : TDateTime;
begin
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_CURRENT_USER;

  if (not reg.KeyExists('Software\MyCompanyName\MyApplication\crackme')) then
    begin
      MessageDlg('Key not found! Created now.',
					        mtInformation, mbOKCancel, 0);
    end;
  reg.Access := KEY_WRITE;
  openResult := reg.OpenKey('Software\MyCompanyName\MyApplication\crackme',True);
 
  if not openResult = True then
    begin
      MessageDlg('Unable to create key! Exiting.',
                  mtError, mbOKCancel, 0);

    end;
 
  { Checking if the values exist and inserting when neccesary }
 
  if not reg.KeyExists('Creation\ Date') then
    begin
      today := Now;
  		reg.WriteDateTime('Creation\ Date', today);
    end;
 
  if not reg.KeyExists('Licenced\ To') then
    begin
  		reg.WriteString('Licenced\ To', 'MySurname\ MyFirstName');
    end;
 
  if not reg.KeyExists('App\ Location') then
    begin
  		reg.WriteExpandString('App\ Location',
                            '%PROGRAMFILES%\MyCompanyName\MyApplication\');
    end;
 
  if not reg.KeyExists('Projects\ Location') then
    begin
  		reg.WriteExpandString('Projects\ Location',
                            '%USERPROFILE%\MyApplication\Projects\');
    end;
 
  reg.CloseKey();
  reg.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Application.MessageBox('Si te gusto el Crackme. visita www.crackmes.apuromafo.net o www.perucrackers.net', 'Hasta la Proxima ', MB_OK);
Application.Terminate;

end;

end.
