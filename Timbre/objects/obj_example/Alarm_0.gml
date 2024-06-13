// Remember the Good Old Days of GameMaker 8.1 and before?
// Remember the super customizable Mark Overmars PopupBox?
// Well, they're back, and potentially better than ever...

// All Parts of the Dialogs have Editable Text
// Not only useful to change the wording of it
// Also good for creating your own tranlations 
// American English is the Language by Default
// There are Two Other Language Localizations:
DialogSetLocaleToAmericanEnglish();
//DialogSetLocaleToSimplifiedChinese();
//DialogSetLocaleToBrazilianPortuguese();

// Set Filter For File Dialogs
var lpFilter = "Supported Image Files (*.png *.gif *.jpg *.jpeg)|*.png;*.gif;*.jpg;*.jpeg|PNG Image Files (*.png)|*.png|GIF Image Files (*.gif)|*.gif|JPEG Image Files (*.jpg *.jpeg)|*.jpg;*.jpeg";

// Set Window Size for File Dialogs
DialogSetWindowSize(720, 360);

// Set Caption for Regular Dialogs
EnvironmentSetVariable("IMGUI_DIALOG_CAPTION", window_get_caption());

// Do Not Show Any Dialog in Borderless Mode (Default Behavior):
EnvironmentSetVariable("IMGUI_DIALOG_NOBORDER", string(false));

// Do Not Allow File Dialogs to be Resizeable (Default Behavior):
EnvironmentSetVariable("IMGUI_DIALOG_RESIZE", string(false));

// Do Not Display Any Dialog as a Fullscreen Window (Default Behavior):
EnvironmentSetVariable("IMGUI_DIALOG_FULLSCREEN", string(false));

// Select a Custom Theme for All Dialogs 
// Classic=-1, Dark=0, Light=1, Custom=2
// Example themes -1 to 1 are from ImGui
EnvironmentSetVariable("IMGUI_DIALOG_THEME", string(2));

// Set the Custom Color Theme 
// Color Scheme (R,G,B=0,1,2) 
EnvironmentSetVariable("IMGUI_TEXT_COLOR_0", string(1));
EnvironmentSetVariable("IMGUI_TEXT_COLOR_1", string(1));
EnvironmentSetVariable("IMGUI_TEXT_COLOR_2", string(1));
EnvironmentSetVariable("IMGUI_HEAD_COLOR_0", string(0.35));
EnvironmentSetVariable("IMGUI_HEAD_COLOR_1", string(0.35));
EnvironmentSetVariable("IMGUI_HEAD_COLOR_2", string(0.35));
EnvironmentSetVariable("IMGUI_AREA_COLOR_0", string(0.05));
EnvironmentSetVariable("IMGUI_AREA_COLOR_1", string(0.05));
EnvironmentSetVariable("IMGUI_AREA_COLOR_2", string(0.05));
EnvironmentSetVariable("IMGUI_BODY_COLOR_0", string(1));
EnvironmentSetVariable("IMGUI_BODY_COLOR_1", string(1));
EnvironmentSetVariable("IMGUI_BODY_COLOR_2", string(1));
EnvironmentSetVariable("IMGUI_POPS_COLOR_0", string(0.07));
EnvironmentSetVariable("IMGUI_POPS_COLOR_1", string(0.07));
EnvironmentSetVariable("IMGUI_POPS_COLOR_2", string(0.07));

// Set Folder to Load All Fonts (Not Recursive):
DialogSetFontFolder(working_directory + "fonts");

// You also may set the Font by Combining a List of Files based on a Line-Feed "\n" Separated String
// Absolute Paths for Every File in the List of TTF and OTF files you choose are Recommended for Use
//EnvironmentSetVariable("IMGUI_FONT_FILES", working_directory + "fonts/Righteous-Regular.ttf\n...\n...\n...");

// Desired Font Size:
DialogSetFontSize(20);

// Show OK-Only Message Box
ShowMessage("This is a dialog box. Click OK to continue.");

// Show Yes/No Question Box
ShowQuestion("Here is a question box. Yes or no?");

// Show Yes/No/Cancel Question Box
ShowQuestionExt("Here is yet another question box. Yes, no, or cancel?");

// Select One Existing File and Echo the Result On-Open-Button
var lpDialogResult = GetOpenFileName(lpFilter, @'Select a file', "", @'Open');
if (lpDialogResult != "") ShowMessage(lpDialogResult);

// Select One (or More) Existing File(s) and Echo the Result On-Open-Button
lpDialogResult = GetOpenFileNames(lpFilter, @'Select one or more files', "", @'Open');
if (lpDialogResult != "") ShowMessage(lpDialogResult);

// Select One New (or Existing) File and Echo the Result On-Save-Button
lpDialogResult = GetSaveFileName(lpFilter, @'Untitled.png', "", @'Save As');
if (lpDialogResult != "") ShowMessage(lpDialogResult);

// Select One Existing Directory and Echo the Result On-Open-Button
lpDialogResult = GetDirectory("Select Directory", "");
if (lpDialogResult != "") ShowMessage(lpDialogResult);

// Enter a String in the TextBox and Echo the Result if the Result is Not Empty
lpDialogResult = GetString("Enter a string in the input box below:", "ENTER TEXT HERE");
if (lpDialogResult != "") ShowMessage(lpDialogResult);

// Enter a Number in the TextBox and Echo the Result if the Result is Not Zero
var nDialogResult = GetNumber("Enter a number in the input box below:", 404);
if (nDialogResult != 0) ShowMessage(nDialogResult);

// End of Demo
game_end();
