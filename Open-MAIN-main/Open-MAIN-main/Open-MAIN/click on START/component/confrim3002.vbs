Option Explicit

Dim i, response, filePath, pythonPath, shell, message, fso, scriptDir

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Zjisti slozku, kde je tento VBS
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Python skript ve stejne slozce
filePath = scriptDir & "\dist\dddelete.exe"

' Pokud je Python v PATH
pythonPath = "python"
' Pokud NENÍ v PATH, pouzij např.:
' pythonPath = "C:\Python312\python.exe"

For i = 1 To 300
    If i < 300 Then
        message = "Jste si jisti, ze chcete tento soubor spustit? (" & i & " / 300)"
    Else
        message = "TOTO JE VASE POSLEDNI ROZHODNUTI." & vbCrLf & vbCrLf & _
                  "Pokud kliknete naposledy na ANO, nelze to vratit zpet." & vbCrLf & _
                  "Ihned se zacnou provadet nevratne operace." & vbCrLf & vbCrLf & _
                  "Jste si jisti, ze chcete soubor spustit? (300 / 300)"
    End If
    
    response = MsgBox(message, vbYesNo + vbQuestion, "Potvrzeni")
    
    If response = vbNo Then
        WScript.Quit
    End If
Next

' Pokud uživatel 300× klikl ANO → spusti Python skript
shell.Run """" & pythonPath & """ """ & filePath & """", 1, False
