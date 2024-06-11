#!/bin/bash

# Muster für Verzeichnisse definieren
verzeichnis_pattern="Verzeichnis*"
zielVerzeichnis="Bildersammlung/"

# Zielverzeichnis erstellen, falls es nicht existiert
mkdir -p "$zielVerzeichnis"

# Verzeichnisse finden, die dem Muster entsprechen
verzeichnisse=$(find . -type d -name "$verzeichnis_pattern")

# Anweisung, was man machen soll
echo "Hallo, durch die Ausführung dieses Programms werden die JPG-Bilder aus den Ordnern, die dem Muster $verzeichnis_pattern entsprechen, in das Verzeichnis $zielVerzeichnis verschoben. Der Rest wird gelöscht."
read -p "Wollen Sie fortfahren? (Y|N): " auswahl

# Auswahl treffen
case "$auswahl" in
    [yY])
        echo "Programm wird ausgeführt..."
    ;;
    [nN])
        echo "Programm wird abgebrochen."
        exit
    ;;
    *)
        echo "Ungültige Eingabe, bitte geben Sie Y oder N ein."
        exit
    ;;
esac

# Schleife über alle gefundenen Verzeichnisse
for verzeichnis in $verzeichnisse; do
    if [ -d "$verzeichnis" ]; then
        echo "Verarbeite Verzeichnis: $verzeichnis"

        # JPG-Dateien verschieben
        find "$verzeichnis" -type f -name "*.jpg" -exec mv -t "$zielVerzeichnis" {} +

        # Alle anderen Dateien löschen
        find "$verzeichnis" -type f ! -name "*.jpg" -exec rm -f {} +

        echo "Fertig mit Verzeichnis: $verzeichnis"
    else
        echo "Info: Das Verzeichnis $verzeichnis existiert nicht und das Programm wird abgebrochen."
        exit
    fi
done

# Alle Verzeichnisse rekursiv löschen
find . -type d -name "$verzeichnis_pattern" -exec rm -rf {} +

echo "Alle Verzeichnisse wurden rekursiv gelöscht."
