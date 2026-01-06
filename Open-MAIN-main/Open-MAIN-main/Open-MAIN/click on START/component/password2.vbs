' password_prompt.vbs
Option Explicit

Dim pwd, answer, WshShell, targetBat, fso, scriptDir

Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Zjisti slozku, kde je tento VBS
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Cilovy soubor ve stejne slozce
targetBat = scriptDir & "\confrim3002.vbs"

Do
    pwd = InputBox("Zadejte heslo:(HINT:1 ~ 3 ~ 5 ~ 7 ~ 9)", "Heslo", "")

    ' Pokud uživatel stiskne Storno nebo nechá pole prázdné
    If pwd = "" Then
        WScript.Quit
    End If

    If pwd = "123456789" Then
        On Error Resume Next
        WshShell.Run """" & targetBat & """", 1, False
        If Err.Number <> 0 Then
            MsgBox "Nepodařilo se spustit:" & vbCrLf & targetBat & vbCrLf & _
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
