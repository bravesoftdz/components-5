//**************************}
//{ FastScript v1.0          }
//{ Forms demo 1             }
//{**************************/

// Form2 is predefined object 
// - the main form of this application


  Form2.Caption = "It works!";
  Form2.Status.Lines.Text := "Text changed !";
  Form2.Status.Font.Style = fsBold + fsItalic;
  ShowMessage("Look at status window.");
  Form2.Status.Font.Style = 0;
