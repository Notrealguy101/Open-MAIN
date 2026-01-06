' password_prompt.vbs
Option Explicit

Dim pwd, answer, WshShell, targetBat, fso, scriptDir
Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Zjisti slozku, kde se nachazi tento VBS
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Cilovy VBS ve stejne slozce
targetBat = scriptDir & "\confrim300.vbs"

Do
    pwd = InputBox("Zadejte heslo:(Hint: 1 ~ 3 ~ 5)", "Heslo", "")

    ' Pokud uzivatel stiskne Storno nebo necha prazdne pole
    If pwd = "" Then
        WScript.Quit
    End If

    If pwd = "12345" Then
        On Error Resume Next
        WshShell.Run """" & targetBat & """", 1, False
        If Err.Number <> 0 Then
            MsgBox "Nepodarilo se spustit:" & vbCrLf & targetBat & vbCrLf & _
                   "Chyba: " & Err.Description, vbCritical, "Chyba"
        End If
        On Error GoTo 0
        WScript.Quit
    Else
        answer = MsgBox("Wrong Password", vbRetryCancel + vbExclamation, "Warning")
        If answer = vbCancel Then
            WScript.Quit
        End If
    End If
Loop
