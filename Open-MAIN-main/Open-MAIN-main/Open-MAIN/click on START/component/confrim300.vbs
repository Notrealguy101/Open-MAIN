Option Explicit

Dim i, response, exePath, shell, message, fso, scriptDir

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Zjisti slozku, kde se nachazi tento VBS
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Nový exe soubor ve stejne slozce (pokud je ve slozce "dist", dej "\dist\del.exe")
exePath = scriptDir & "\dist\del.exe"

' Kontrola existence exe souboru
If Not fso.FileExists(exePath) Then
    MsgBox "Soubor nenalezen: " & exePath, vbCritical, "Chyba"
    WScript.Quit
End If

For i = 1 To 300
    If i < 300 Then
        message = "Jste si jisti, ze chcete tento soubor spustit? (" & i & " / 300)"
    Else
        message = "TOTO JE VASE POSLEDNI ROZHODNUTI O TOMTO. Pokud klikne ted a naposled ano nemuzete to vratit zpet. Ihned se zacnou odstranovat slozky a soubory podstatne pro restartovani a celkove znovu zapnuti pocitace,jste si jisti ze chcete soubor spustit ? (300 / 300)"
    End If
    
    response = MsgBox(message, vbYesNo + vbQuestion, "Potvrzeni")
    
    If response = vbNo Then
        WScript.Quit
    End If
Next

' pokud uzivatel 300× klikl ANO, spusti se .exe
shell.Run """" & exePath & """", 1, False
