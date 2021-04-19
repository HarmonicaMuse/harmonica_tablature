//=============================================================================
//  MuseScore
//  Music Composition & Notation
//  Interactive Harmonica Tablature Plugin.
//  Copyright (C) 2012 Werner Schweer
//  Copyright (C) 2013 - 2019 Joachim Schmitz
//  Copyright (C) 2014 Jörn Eichler
//  Copyright (C) 2020 MuseScore BVBA
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2
//  as published by the Free Software Foundation and appearing in
//  the file LICENCE.GPL
// Modified
//  by Tadashi Terada, Ismael Venegas Castelló
//  This use the original font file to be included in Plugin.
//  Please see at the font_detail.pdf for details.
//=============================================================================

import MuseScore 3.0
import Qt.labs.settings 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

MuseScore {
    // change to "b" if you want bend to be noted with b
    //--------
    // ------ OPTIONS -------
    // List chords in the following order:
    // 1) Leading grace notes;
    // 2) Chord itself;
    // 3) Trailing grace notes.
    //---
    //old table
    //        var richter = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb//",  "-3b",   "-3",
    //        "+4",   "-4b",  "-4", "+4o", "+5",  "-5",     "+5o",  "+6",   "-6b",   "-6",    "+6o",   "//-7",
    //        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "//+10b",
    //        "+10", "-10o" ];    //Standard Richter tuning with overbends
    //        var richterValved = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb",// "-3bb",  "-3b",   "-3",
    //        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "//-7",
    //        "+7",   "-8b",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-10b",  "-10",   "+10bb",  //"+10b",
    //        "+10" ];
    //        richterValved[-2] = "+1bb"; richterValved[-1] = "+1b"; //Two notes below the key at blow 1
    //        var paddyRichter = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "+3b", "+3",  "-3b",   "-3",
    //        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
    //        "+7",   "-8b",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-10b",  "-10",   "+10bb",  "+10b",
    //        "+10" ];
    //        paddyRichter[-2] = "+1bb"; paddyRichter[-1] = "+1b"; //Two notes below the key at blow 1
    // Brendan Power's tuning, half valved
    //        var country = ["+1",  "-1b",  "-1", "+1o", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
    //        "+4",   "-4b",  "-4", "+4o", "+5",  "-5b",     "-5",  "+6",   "-6b",   "-6",    "+6o",   "-7",
    //        "+7",   "-7o",  "-8", "+8b", "+8",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
    //        "+10", "-10o" ];
    //        var standardChromatic = ["+1", '+1s', "-1", "-1s", "+2", "-2", "-2s", "+3", "+3s", "-3", "//-3s","-4",
    //        "+4", "+4s", "-5", "-5s", "+6", "-6", "-6s", "+7",  "+7s", "-7", "-7s", "-8",
    //        "+8", "+8s", "-9", "-9s", "+10", "-10", "-10s", "+11", "+11s", "-11", "-11s", "-12",
    //        "+12", "+12s", "-12", "-12s" ];
    //        var zirkValved = ["+1", "-1b", "-1", "+2b", "+2", "-2", "+3b", "+3", "-3b", "-3", "+4", "-4b",
    //        "-4", "+5b", "+5", "-5b", "-5", "+6", "-6b", "-6", "+7b", "+7", "-7", "+8b",
    //        "+8", "-8b", "-8", "+9b", "+9", "-9", "10b", "+10", "-10b", "-10" ];
    //        var trueChrom = ["+1", "-1b", "-1", "+2", "-2b", "-2", "+3b", "+3", "-3b", "-3", "+4", "-4b",
    //        "-4", "+5b", "+5", "-5b", "-5", "+6", "-6b", "-6", "+7b", "+7", "-7b", "-7",
    //        "+8", "-8b", "-8", "+9b", "+9", "-9b", "-9", "+10", "-10b", "-10" ];
    //        var naturalMinor = ["+1",  "-1b",  "-1", "+2", "-2bbb",  "-2bb",   "-2b",  "-2",   "-3bb", "-3b",  "-3",   "+3o",
    //        "+4",   "-4b",  "-4", "+5", "-5b",  "-5",     "+5o",  "+6",   "-6b",   "-6",    "-7",   "+7b",
    //        "+7",   "-7o",  "-8", "+8", "-8o",  "-9",     "+9b",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
    //        "+10", "-10o" ];
    //        var melodyMaker = [ , , , , ,
    //        "+1", "-1b", "-1", "+1o","+2", "-2bb","-2b", "-2", "+2o", "+3",  "-3b",   "-3",
    //        "+4",   "-4b",  "-4", "+4o", "+5",  "-5b",     "-5",  "+6",   "-6b",   "-6",    "+6o",   "-7",
    //        "+7",   "-7o",  "-8", "+8b", "+8",  "-8o",     "-9",  "+9",   "-9o",  "-10",   "+10bb",  "+10b",
    //        "+10", "-10o" ];
    //        var spiral_b1 = ["+1", "-1b", "-1", "+2b", "+2", "-2", "+3b", "+3", "-3b", "-3", "+4b", "+4",
    //        "-4", "+5b", "+5", "-5b", "-5", "+6", "-6b", "-6", "+7b", "+7b", "-7", "-7",
    //        "+8", "-8b", "-8", "+9b", "+9", "-9", "+10b", "+10", "-10b", "-10" ];
    //        var powerBender = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
    //        "+4",   "-4b",  "-4", "-5b", "-5",  "+6",     "-6b",  "-6",   "+7b",   "+7",    "-7b",   "-7",
    //        "+8",   "-8b",  "-8", "+9b", "+9",  "-9bb",     "-9b",  "-9",   "+10b",  "+10",   "-10bb",  "-10b",
    //        "-10" ];
    //        powerBender[-2] = "+1bb"; powerBender[-1] = "+1b";
    //        var powerDraw = ["+1",  "-1b",  "-1", "+2b", "+2",  "-2bb",   "-2b",  "-2",   "-3bbb", "-3bb",  "-3b",   "-3",
    //        "+4",   "-4b",  "-4", "+5b", "+5",  "-5",     "+6b",  "+6",   "-6b",   "-6",    "-7b",   "-7",
    //        "+8",   "-8b",  "-8", "+9b", "+9",  "-9bb",     "-9b",  "-9",   "+10b",  "+10",   "-10bb",  "-10b",
    //        "-10" ];
    //      powerDraw[-2] = "+1bb"; powerDraw[-1] = "+1b";
    //-------

    id: window

    // ------ OPTIONS -------
    property string sep: "\n"
    // change to "," if you want tabs horizontally
    property string bendChar: "'"
    property var defaultFontSize
    property var fontSizeMini: 0.7
    property int nstaves: 0 // for validators in staff number inputs
    property bool inCmd: false
    //jpn
    property var fontName: ["chromatic_std12v3"]
    property var fontSizeInit: 15
    //Item positions in menu
    property var itemTextX1: 10
    property var itemTextY1: 20
    property var itemTextY2: 20
    property var xPositionInit: 0
    property var yPositionInit: 0
    property var onNum2Visible1: false
    property var onNum2Visible2: false
    property var onNum2Visible3: false
    //2020.11.21 new
    property var onNum2Visible4: false
    //2020.11.28 new
    property var onNum2Visible5: false
    //---
    //2020.11.21
    property var pre_slidekey: 0
    //2020.11.28
    property var pre_key: 0
    //---box
    property int currentIndex: 0
    property int currentIndex2: 0

    function ensureCmdStarted() {
        if (!inCmd) {
            curScore.startCmd();
            inCmd = true;
        }
    }

    function ensureCmdEnded() {
        if (inCmd) {
            curScore.endCmd();
            inCmd = false;
        }
    }

    function findSegment(el) {
        while (el && el.type != Element.SEGMENT)el = el.parent
        return el;
    }

    function getChordName(chord) {
        // end if courtesy- and microtonal accidentals

        var text = "";
        var notes = chord.notes;
        for (var i = 0; i < notes.length; i++) {
            // like for grace notes ?!?
            // octave, middle C being C4
            //text += (Math.floor(notes[i].pitch / 12) - 1)
            // or
            //text += (Math.floor(notes[i].ppitch / 12) - 1)

            var sep = "\n"; // change to "," if you want them horizontally (anybody?)
            if (i > 0)
                text = sep + text;
 // any but top note
            if (typeof notes[i].tpc === "undefined")
                return ;

            switch (notes[i].tpc) {
            case -1:
                text = qsTranslate("InspectorAmbitus", "F♭♭") + text;
                break;
            case 0:
                text = qsTranslate("InspectorAmbitus", "C♭♭") + text;
                break;
            case 1:
                text = qsTranslate("InspectorAmbitus", "G♭♭") + text;
                break;
            case 2:
                text = qsTranslate("InspectorAmbitus", "D♭♭") + text;
                break;
            case 3:
                text = qsTranslate("InspectorAmbitus", "A♭♭") + text;
                break;
            case 4:
                text = qsTranslate("InspectorAmbitus", "E♭♭") + text;
                break;
            case 5:
                text = qsTranslate("InspectorAmbitus", "B♭♭") + text;
                break;
            case 6:
                text = qsTranslate("InspectorAmbitus", "F♭") + text;
                break;
            case 7:
                text = qsTranslate("InspectorAmbitus", "C♭") + text;
                break;
            case 8:
                text = qsTranslate("InspectorAmbitus", "G♭") + text;
                break;
            case 9:
                text = qsTranslate("InspectorAmbitus", "D♭") + text;
                break;
            case 10:
                text = qsTranslate("InspectorAmbitus", "A♭") + text;
                break;
            case 11:
                text = qsTranslate("InspectorAmbitus", "E♭") + text;
                break;
            case 12:
                text = qsTranslate("InspectorAmbitus", "B♭") + text;
                break;
            case 13:
                text = qsTranslate("InspectorAmbitus", "F") + text;
                break;
            case 14:
                text = qsTranslate("InspectorAmbitus", "C") + text;
                break;
            case 15:
                text = qsTranslate("InspectorAmbitus", "G") + text;
                break;
            case 16:
                text = qsTranslate("InspectorAmbitus", "D") + text;
                break;
            case 17:
                text = qsTranslate("InspectorAmbitus", "A") + text;
                break;
            case 18:
                text = qsTranslate("InspectorAmbitus", "E") + text;
                break;
            case 19:
                text = qsTranslate("InspectorAmbitus", "B") + text;
                break;
            case 20:
                text = qsTranslate("InspectorAmbitus", "F♯") + text;
                break;
            case 21:
                text = qsTranslate("InspectorAmbitus", "C♯") + text;
                break;
            case 22:
                text = qsTranslate("InspectorAmbitus", "G♯") + text;
                break;
            case 23:
                text = qsTranslate("InspectorAmbitus", "D♯") + text;
                break;
            case 24:
                text = qsTranslate("InspectorAmbitus", "A♯") + text;
                break;
            case 25:
                text = qsTranslate("InspectorAmbitus", "E♯") + text;
                break;
            case 26:
                text = qsTranslate("InspectorAmbitus", "B♯") + text;
                break;
            case 27:
                text = qsTranslate("InspectorAmbitus", "F♯♯") + text;
                break;
            case 28:
                text = qsTranslate("InspectorAmbitus", "C♯♯") + text;
                break;
            case 29:
                text = qsTranslate("InspectorAmbitus", "G♯♯") + text;
                break;
            case 30:
                text = qsTranslate("InspectorAmbitus", "D♯♯") + text;
                break;
            case 31:
                text = qsTranslate("InspectorAmbitus", "A♯♯") + text;
                break;
            case 32:
                text = qsTranslate("InspectorAmbitus", "E♯♯") + text;
                break;
            case 33:
                text = qsTranslate("InspectorAmbitus", "B♯♯") + text;
                break;
            default:
                text = qsTr("?") + text;
                break;
            } // end switch tpc
            // change below false to true for courtesy- and microtonal accidentals
            // you might need to come up with suitable translations
            // only #, b, natural and possibly also ## seem to be available in UNICODE
            if (false) {
                switch (notes[i].userAccidental) {
                case 0:
                    break;
                case 1:
                    text = qsTranslate("accidental", "Sharp") + text;
                    break;
                case 2:
                    text = qsTranslate("accidental", "Flat") + text;
                    break;
                case 3:
                    text = qsTranslate("accidental", "Double sharp") + text;
                    break;
                case 4:
                    text = qsTranslate("accidental", "Double flat") + text;
                    break;
                case 5:
                    text = qsTranslate("accidental", "Natural") + text;
                    break;
                case 6:
                    text = qsTranslate("accidental", "Flat-slash") + text;
                    break;
                case 7:
                    text = qsTranslate("accidental", "Flat-slash2") + text;
                    break;
                case 8:
                    text = qsTranslate("accidental", "Mirrored-flat2") + text;
                    break;
                case 9:
                    text = qsTranslate("accidental", "Mirrored-flat") + text;
                    break;
                case 10:
                    text = qsTranslate("accidental", "Mirrored-flat-slash") + text;
                    break;
                case 11:
                    text = qsTranslate("accidental", "Flat-flat-slash") + text;
                    break;
                case 12:
                    text = qsTranslate("accidental", "Sharp-slash") + text;
                    break;
                case 13:
                    text = qsTranslate("accidental", "Sharp-slash2") + text;
                    break;
                case 14:
                    text = qsTranslate("accidental", "Sharp-slash3") + text;
                    break;
                case 15:
                    text = qsTranslate("accidental", "Sharp-slash4") + text;
                    break;
                case 16:
                    text = qsTranslate("accidental", "Sharp arrow up") + text;
                    break;
                case 17:
                    text = qsTranslate("accidental", "Sharp arrow down") + text;
                    break;
                case 18:
                    text = qsTranslate("accidental", "Sharp arrow both") + text;
                    break;
                case 19:
                    text = qsTranslate("accidental", "Flat arrow up") + text;
                    break;
                case 20:
                    text = qsTranslate("accidental", "Flat arrow down") + text;
                    break;
                case 21:
                    text = qsTranslate("accidental", "Flat arrow both") + text;
                    break;
                case 22:
                    text = qsTranslate("accidental", "Natural arrow down") + text;
                    break;
                case 23:
                    text = qsTranslate("accidental", "Natural arrow up") + text;
                    break;
                case 24:
                    text = qsTranslate("accidental", "Natural arrow both") + text;
                    break;
                case 25:
                    text = qsTranslate("accidental", "Sori") + text;
                    break;
                case 26:
                    text = qsTranslate("accidental", "Koron") + text;
                    break;
                default:
                    text = qsTr("?") + text;
                    break;
                } // end switch userAccidental
            }
        } // end for note
        return text;
    }

    function getGraceNoteNames(graceChordsList) {
        var names = [];
        // iterate through all grace chords
        for (var chordNum = 0; chordNum < graceChordsList.length; chordNum++) {
            var chord = graceChordsList[chordNum];
            var chordName = getChordName(chord);
            // append the name to the list of names
            names.push(chordName);
        }
        return names;
    }

    function getAllChords(el) {
        if (!el || el.type != Element.CHORD)
            return [];

        var chord = el;
        var allChords = [chord];
        // Search for grace notes
        var graceChords = chord.graceNotes;
        for (var chordNum = 0; chordNum < graceChords.length; chordNum++) {
            var graceChord = graceChords[chordNum];
            var noteType = graceChord.noteType;
            switch (noteType) {
            case NoteType.GRACE8_AFTER:
            case NoteType.GRACE16_AFTER:
            case NoteType.GRACE32_AFTER:
                leadingLifo.push(graceChord); // append trailing grace chord to list
                break;
            default:
                allChords.unshift(graceChord); // prepend leading grace chord to list
                break;
            }
        }
        return allChords;
    }

    function isNoteName(el) {
        return el.type == Element.STAFF_TEXT; // TODO: how to distinguish note names from all staff texts?
    }

    function getExistingNoteNames(segment, track) {
        var annotations = segment.annotations;
        var noteNames = [];
        for (var i = 0; i < annotations.length; ++i) {
            var a = annotations[i];
            if (a.track != track)
                continue;

            if (isNoteName(a))
                noteNames.push(a);

        }
        return noteNames;
    }

    function handleChordAtCursor(cursor) {
        var allNoteNames = getExistingNoteNames(cursor.segment, cursor.track);
        var allChords = getAllChords(cursor.element);
        var chordIdx = 0;
        for (; chordIdx < allChords.length; ++chordIdx) {
            // place below for voice 1 and voice 3 (numbered as 2 and 4 in user interface)

            var chord = allChords[chordIdx];
            var noteName = allNoteNames[chordIdx];
            var chordProperties = {
                "offsetX": chord.posX,
                "fontSize": chord.noteType == NoteType.NORMAL ? defaultFontSize : (defaultFontSize * fontSizeMini),
                "placement": (chord.voice & 1) ? Placement.BELOW : Placement.ABOVE,
                "text": getChordName(chord)
            };
            if (!noteName) {
                // Note name does not exist, add a new one
                ensureCmdStarted();
                var nameText = newElement(Element.STAFF_TEXT);
                for (var prop in chordProperties) {
                    if (nameText[prop] != chordProperties[prop])
                        nameText[prop] = chordProperties[prop];

                }
                cursor.add(nameText);
            } else {
                // Note name exists, ensure it is up to date
                for (var prop in chordProperties) {
                    if (noteName[prop] != chordProperties[prop]) {
                        ensureCmdStarted();
                        noteName[prop] = chordProperties[prop];
                    }
                }
            } // end if/else noteName
        } // end for allChords
        // Remove the remaining redundant note names, if any
        for (; chordIdx < allNoteNames.length; ++chordIdx) {
            ensureCmdStarted();
            var noteName = allNoteNames[chordIdx];
            removeElement(noteName);
        }
    }

    function processRange(startTick, endTick, firstStaff, lastStaff) {
        if (startTick < 0)
            startTick = 0;

        if (endTick < 0)
            endTick = Infinity;
 // process the entire score
        var cursor = curScore.newCursor();
        for (var staff = firstStaff; staff <= lastStaff; staff++) {
            for (var voice = 0; voice < 4; voice++) {
                cursor.voice = voice;
                cursor.staffIdx = staff;
                cursor.rewindToTick(startTick);
                while (cursor.segment && cursor.tick <= endTick) {
                    handleChordAtCursor(cursor);
                    cursor.next();
                } // end while segment
            } // end for voice
        } // end for staff
        ensureCmdEnded();
    }

    function getStavesRange() {
        if (allStavesCheckBox.checked)
            return [0, curScore.nstaves];

        var firstStaff = firstStaffInput.acceptableInput ? +firstStaffInput.text : curScore.nstaves;
        var lastStaff = lastStaffInput.acceptableInput ? +lastStaffInput.text : -1;
        return [firstStaff, lastStaff];
    }

    function setFNumChg1() {
        onNum2Visible1 = fNumChgCheckBox1.checked;
        console.log("onNum2Visible1 to " + onNum2Visible1);
    }

    function setFNumChg2() {
        onNum2Visible2 = fNumChgCheckBox2.checked;
        console.log("onNum2Visible2 to " + onNum2Visible2);
    }

    function setFNumChg3() {
        onNum2Visible3 = fNumChgCheckBox3.checked;
        console.log("onNum2Visible3 to " + onNum2Visible3);
    }

    //2020.11.21 new
    function setFNumChg4() {
        onNum2Visible4 = fNumChgCheckBox4.checked;
        console.log("onNum2Visible4 to " + onNum2Visible4);
    }

    //2020.11.28 new
    function setFNumChg5() {
        onNum2Visible5 = fNumChgCheckBox5.checked;
        console.log("onNum2Visible5 to " + onNum2Visible5);
    }

    //---
    //--------
    function tabNotes(notes, text) {
        // Circular/Spiral tuned diatonic
        // Key per Seydel "G"on blow 1, C major at draw 2, A minor at draw 1
        //True Chromatic diatonic, valves
        //Another side of the spiral logic is expanded in the "True Chromatic" tuning, designed by Eugene Ivanov.
        //All chords can be arranged in a continuous, looped progression on major and minor triads:
        //C Eb G Bb D F A C E G B D Gb A Db E Ab B Eb Gb Bb Db F Ab C (and looped on C minor after that).
        //Labeled by blow 1 like Hohner. Seydel and Lee Okar labels by draw 2
        // label by draw 2
        // Circular/Spiral tuned diatonic
        // Inversed for Blow 1. Key of C major scale starts at blow 1
        //Two notes below the key at blow 1
        // Brendan Power's tuning, half valved
        //---

        //japanese new table
        //Blues Harp
        var richter = ["A", "M", "M", "A", "B", "N", "N", "N", "O", "O", "O", "O", "D", "P", "P", "D", "E", "Q", "E", "F", "R", "R", "F", "S", "G", "S", "T", "H", "H", "U", "I", "I", "U", "V", "J", "J", "J", "V"];
        //Standard Richter tuning with overbends
        //2020.11.23
        //      var richterbend = ["0","a","0","d","0","b","a","0","c","b","a","0",
        //                         "0","a","0","d","0","0","d","0","a","0","d","0",
        //                         "0","d","0","a","0","0","a","0","d","0","b","a",
        //                         "0","d"];
        var richterbend = ["0", "Y", "0", "@", "0", "Z", "Y", "0", "?", "Z", "Y", "0", "0", "Y", "0", "@", "0", "0", "@", "0", "Y", "0", "@", "0", "0", "@", "0", "Y", "0", "0", "Y", "0", "@", "0", "Z", "Y", "0", "@"];
        //richter Valve
        var richterValved = ["A", "M", "M", "B", "B", "N", "N", "N", "O", "O", "O", "O", "D", "P", "P", "E", "E", "Q", "E", "F", "R", "R", "S", "S", "G", "T", "T", "H", "H", "U", "I", "I", "V", "V", "J", "J", "J"];
        var richterValvedbend = ["0", "a", "0", "a", "0", "b", "a", "0", "c", "b", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "b", "a", "0"];
        richterValved[-2] = "A"; //Two notes below the key at blow 1
        richterValved[-1] = "A";
        richterValvedbend[-2] = "b"; //Two notes below the key at blow 1
        richterValvedbend[-1] = "a";
        var paddyRichter = ["A", "M", "M", "B", "B", "N", "N", "N", "C", "C", "O", "O", "D", "P", "P", "E", "E", "Q", "E", "F", "R", "R", "S", "S", "G", "T", "T", "H", "H", "U", "I", "I", "V", "V", "J", "J", "J"];
        var paddyRichterbend = ["0", "a", "0", "a", "0", "b", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "b", "a", "0"];
        paddyRichter[-2] = "A"; //Two notes below the key at blow 1
        paddyRichter[-1] = "A";
        // Brendan Power's tuning, half valved
        paddyRichterbend[-2] = "b";
        richterValvedbend[-1] = "a"; //Two notes below the key at blow 1
        var country = ["A", "M", "M", "A", "B", "N", "N", "N", "O", "O", "O", "O", "D", "P", "P", "D", "E", "Q", "Q", "F", "R", "R", "F", "S", "G", "S", "T", "H", "H", "U", "I", "I", "U", "V", "J", "J", "J", "V"];
        var countrybend = ["0", "a", "0", "d", "0", "b", "a", "0", "c", "b", "a", "0", "0", "a", "0", "d", "0", "a", "0", "0", "a", "0", "d", "0", "0", "d", "0", "a", "0", "0", "a", "0", "d", "0", "b", "a", "0", "d"];
        var standardChromatic = ["A", "A", "M", "M", "B", "N", "N", "C", "C", "O", "O", "P", "D", "D", "Q", "Q", "F", "R", "R", "G", "G", "S", "S", "T", "H", "H", "U", "U", "J", "V", "V", "K", "K", "W", "W", "X", "L", "L", "X", "X"];
        //slide on/off
        var standardChromatic2 = [0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1];
        var zirkValved = ["A", "M", "M", "B", "B", "N", "C", "C", "O", "O", "D", "P", "P", "E", "E", "Q", "Q", "F", "R", "R", "G", "G", "S", "H", "H", "T", "T", "I", "I", "U", "J", "J", "V", "V"];
        var zirkValvedbend = ["0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0"];
        var trueChrom = ["A", "M", "M", "B", "N", "N", "C", "C", "O", "O", "D", "P", "P", "E", "E", "Q", "Q", "F", "R", "R", "G", "G", "S", "S", "H", "T", "T", "I", "I", "U", "U", "J", "V", "V"];
        var trueChrombend = ["0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0"];
        var naturalMinor = ["A", "M", "M", "B", "N", "N", "N", "N", "O", "O", "O", "C", "D", "P", "P", "E", "Q", "Q", "E", "F", "R", "R", "S", "G", "G", "S", "T", "H", "T", "U", "I", "I", "U", "V", "J", "J", "J", "V"];
        var naturalMinorbend = ["0", "a", "0", "0", "c", "b", "a", "0", "b", "a", "0", "d", "0", "a", "0", "0", "a", "0", "d", "0", "a", "0", "0", "a", "0", "d", "0", "0", "d", "0", "a", "0", "d", "0", "b", "a", "0", "d"];
        var melodyMaker = ["x", "x", "x", "x", "x", "A", "M", "M", "A", "B", "N", "N", "N", "B", "C", "O", "O", "D", "P", "P", "D", "E", "Q", "Q", "F", "R", "R", "F", "S", "G", "S", "T", "H", "H", "T", "U", "I", "U", "V", "J", "J", "J", "V"];
        var melodyMakerbend = ["0", "0", "0", "0", "0", "0", "a", "0", "d", "0", "b", "a", "0", "d", "0", "a", "0", "0", "a", "0", "d", "0", "a", "0", "0", "a", "0", "d", "0", "0", "d", "0", "a", "0", "d", "0", "0", "d", "0", "b", "a", "0", "d"];
        var spiral_b1 = ["A", "M", "M", "B", "B", "N", "C", "C", "O", "O", "D", "D", "P", "E", "E", "Q", "Q", "F", "R", "R", "G", "G", "S", "S", "H", "T", "T", "I", "I", "U", "J", "J", "V", "V"];
        var spiral_b1bend = ["0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "a", "0", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0"];
        var powerBender = ["A", "M", "M", "B", "B", "N", "N", "N", "O", "O", "O", "O", "D", "P", "P", "Q", "Q", "F", "R", "R", "G", "G", "S", "S", "H", "T", "T", "I", "I", "U", "U", "U", "J", "J", "V", "V", "V"];
        var powerBenderbend = ["0", "a", "0", "a", "0", "b", "a", "0", "c", "b", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "b", "a", "0", "a", "0", "b", "a", "0"];
        powerBender[-2] = "A";
        powerBender[-1] = "A";
        powerBenderbend[-2] = "b";
        powerBenderbend[-1] = "a";
        var powerDraw = ["A", "M", "M", "B", "B", "N", "N", "N", "O", "O", "O", "O", "D", "P", "P", "E", "E", "Q", "F", "F", "R", "R", "S", "S", "H", "T", "T", "I", "I", "U", "U", "U", "J", "J", "V", "V", "V"];
        var powerDrawbend = ["0", "a", "0", "a", "0", "b", "a", "0", "c", "b", "a", "0", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "a", "0", "0", "a", "0", "a", "0", "b", "a", "0", "a", "0", "b", "a", "0"];
        powerDraw[-2] = "A";
        powerDraw[-1] = "A";
        powerDrawbend[-2] = "b";
        powerDrawbend[-1] = "a";
        //Two notes below the key at blow 1
        // Brendan Power's tuning, half valved
        //-----------------
        var tuning = richter;
        switch (harp.tuning) {
        case 1:
            tuning = richter;
            break;
        case 2:
            tuning = richterValved;
            break;
        case 3:
            tuning = country;
            break;
        case 4:
            tuning = standardChromatic;
            break;
        case 5:
            tuning = zirkValved;
            break;
        case 6:
            tuning = trueChrom;
            break;
        case 7:
            tuning = naturalMinor;
            break;
        case 8:
            tuning = melodyMaker;
            break;
        case 9:
            tuning = spiral_b1;
            break;
        case 10:
            tuning = paddyRichter;
            break;
        case 11:
            tuning = powerBender;
            break;
        case 12:
            tuning = powerDraw;
            break;
        default:
            tuning = richter;
            break;
        }
        var harpkey = keylist.key;
        console.log("harpkey set to  " + keylist.key);
        //jpn
        var slidekey = 0;
        var richterbendkey = 0;
        //---
        for (var i = 0; i < notes.length; i++) {
            // just in case

            var sep = "\n"; // change to "," if you want them horizontally
            if (i > 0)
                text.text = sep + text.text;

            if (typeof notes[i].pitch === "undefined")
                return ;

            if (typeof tuning[notes[i].pitch - harpkey] === "undefined") {
                text.text = "x";
            } else {
                //bluesharp
                //richterValved
                //country
                //standardChromatic
                //zirkValved
                //trueChrom
                //naturalMinor
                //melodyMaker
                //spiral_b1bend
                //paddyRichter
                //powerBender
                //powerDraw

                console.log("pre text1 to " + text.text);
                console.log("harp.tuning to " + harp.tuning);
                //jpn
                switch (harp.tuning) {
                case 1:

                        richterbendkey = richterbend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 2:

                        richterbendkey = richterValvedbend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 3:

                        richterbendkey = countrybend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 4:

                        slidekey = standardChromatic2[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 5:

                        richterbendkey = zirkValvedbend[notes[i].pitch - harpkey] + text.text;
;
                case 6:

                        richterbendkey = trueChrombend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 7:

                        richterbendkey = naturalMinorbend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 8:

                        richterbendkey = melodyMakerbend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 9:

                        richterbendkey = spiral_b1bend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 10:

                        richterbendkey = paddyRichterbend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 11:

                        richterbendkey = powerBenderbend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                case 12:

                        richterbendkey = powerDrawbend[notes[i].pitch - harpkey] + text.text;
;
                    break;
                default:
                    break;
                }
                //--
                text.text = tuning[notes[i].pitch - harpkey] + text.text;
                //jpn
                fontSizeInit = valFontSize.value;
                console.log("pre_slide text to " + pre_slidekey);
                console.log("slide text to " + slidekey);
                console.log("richterbendkey to " + richterbendkey);
            }
            //-------------------
            //Blues Harp,richterValved
            //-------------------
            if ((harp.tuning != 4) && (text.text != "x")) {
                var fontSizeTag = "<font size=\"" + fontSizeInit + "\"/>";
                var fontFaceTag = "<font face=\"" + fontName[0] + "\"/>";
                if (richterbendkey != "0") {
                    console.log("fontSizeTag to " + fontSizeTag + " fontFaceTag to " + fontFaceTag + " text.text to " + text.text + " richterbendkey to " + richterbendkey);
                    text.text = fontSizeTag + fontFaceTag + text.text + richterbendkey;
                } else {
                    text.text = fontSizeTag + fontFaceTag + text.text;
                }
            }
            //2020.11.15
            text.placement = Placement.BELOW;
            text.autoplace = false;
            //-----------------------
            //standardChromatic
            //-----------------------
            if ((harp.tuning == 4) && (text.text != "x")) {
                //Here, check the previous slide and operate F and C
                //-----

                console.log("pitch to " + notes[i].pitch + " harpkey to " + harpkey + " tuning to " + tuning[notes[i].pitch - harpkey]);
                console.log("note key to " + notes[i].pitch + " text to  " + text.text);
                console.log("onNum2Visible1 2 to " + onNum2Visible1);
                //---  F judge
                if ((onNum2Visible1 == true) && (slidekey == 0) && (text.text == "N")) {
                    text.text = "B";
                    slidekey = 1;
                }
                if ((onNum2Visible2 == true) && (slidekey == 0) && (text.text == "R")) {
                    text.text = "F";
                    slidekey = 1;
                }
                if ((onNum2Visible3 == true) && (slidekey == 0) && (text.text == "V")) {
                    text.text = "J";
                    slidekey = 1;
                }
                //2020.11.21 new
                if ((onNum2Visible4 == true) && (pre_slidekey == 1) && (slidekey == 0) && (text.text == "N")) {
                    text.text = "B";
                    slidekey = 1;
                }
                if ((onNum2Visible4 == true) && (pre_slidekey == 1) && (slidekey == 0) && (text.text == "R")) {
                    text.text = "F";
                    slidekey = 1;
                }
                if ((onNum2Visible4 == true) && (pre_slidekey == 1) && (slidekey == 0) && (text.text == "V")) {
                    text.text = "J";
                    slidekey = 1;
                }
                //2020.11.28
                //Examine the blow.
                var pre_key_flg = 0;
                if ((pre_key == "A") || (pre_key == "B") || (pre_key == "C") || (pre_key == "D") || (pre_key == "E") || (pre_key == "F") || (pre_key == "G") || (pre_key == "H") || (pre_key == "I") || (pre_key == "J") || (pre_key == "K") || (pre_key == "L"))
                    pre_key_flg = 1;

                console.log(" pre_key_flg to " + pre_key_flg);
                //If the front is blown, make it a slide F
                if ((onNum2Visible5 == true) && (text.text == "N") && (pre_key_flg == 1)) {
                    text.text = "B";
                    slidekey = 1;
                }
                if ((onNum2Visible5 == true) && (text.text == "R") && (pre_key_flg == 1)) {
                    text.text = "F";
                    slidekey = 1;
                }
                if ((onNum2Visible5 == true) && (text.text == "V") && (pre_key_flg == 1)) {
                    text.text = "J";
                    slidekey = 1;
                }
                //----
                console.log(" text2 to " + text.text);
                console.log("currentIndex to " + currentIndex);
                //-- C judge
                //4
                if ((text.text == "D") && (slidekey == 0) && (currentIndex == 0)) {
                    //2020.11.23
                    //2020.11.28 Add if the front was drawing
                    if (((onNum2Visible4 == true) && (pre_slidekey == 1)) || ((onNum2Visible5 == true) && (pre_key_flg == 0))) {
                        console.log(" text4-1 to " + text.text);
                        text.text = "P";
                        slidekey = 1;
                    } else {
                        //---
                        text.text = "D";
                        slidekey = 0;
                    }
                }
                //2020.11.23
                //4 -> -4#
                if ((onNum2Visible4 == true) && (pre_slidekey == 1) && (text.text == "D") && (slidekey == 0) && (currentIndex == 0)) {
                    console.log(" text4-2 to " + text.text);
                    text.text = "P";
                    slidekey = 1;
                }
                //---
                //4#
                if ((text.text == "D") && (slidekey == 1) && (currentIndex == 0)) {
                    text.text = "D";
                    slidekey = 1;
                }
                //-4#
                if ((text.text == "D") && (slidekey == 0) && (currentIndex == 1)) {
                    text.text = "P";
                    slidekey = 1;
                }
                //5
                if ((text.text == "D") && (slidekey == 0) && (currentIndex == 2)) {
                    //2020.11.23
                    //2020.11.28 Add if the front was drawing
                    if (((onNum2Visible4 == true) && (pre_slidekey == 1)) || ((onNum2Visible5 == true) && (pre_key_flg == 0))) {
                        console.log(" text4-3 to " + text.text);
                        text.text = "P";
                        slidekey = 1;
                    } else {
                        //---
                        text.text = "E";
                        slidekey = 0;
                    }
                }
                //5#
                if ((text.text == "D") && (slidekey == 1) && (currentIndex == 2)) {
                    text.text = "E";
                    slidekey = 1;
                }
                //--High C judge
                //8
                if ((text.text == "H") && (slidekey == 0) && (currentIndex2 == 0)) {
                    //2020.11.23
                    //2020.11.28 Add if the front was drawing
                    if (((onNum2Visible4 == true) && (pre_slidekey == 1)) || ((onNum2Visible5 == true) && (pre_key_flg == 0))) {
                        text.text = "T";
                        slidekey = 1;
                    } else {
                        //---
                        text.text = "H";
                        slidekey = 0;
                    }
                }
                //2020.11.23
                //8 -> -8#
                if ((onNum2Visible4 == true) && (pre_slidekey == 1) && (text.text == "H") && (slidekey == 0) && (currentIndex == 0)) {
                    text.text = "T";
                    slidekey = 1;
                }
                //8#
                if ((text.text == "H") && (slidekey == 1) && (currentIndex2 == 0)) {
                    text.text = "H";
                    slidekey = 1;
                }
                //⑧s
                if ((text.text == "H") && (slidekey == 0) && (currentIndex2 == 1)) {
                    text.text = "T";
                    slidekey = 1;
                }
                //9
                if ((text.text == "H") && (slidekey == 0) && (currentIndex2 == 2)) {
                    //2020.11.23
                    //2020.11.28 Add if the front was drawing
                    if (((onNum2Visible4 == true) && (pre_slidekey == 1)) || ((onNum2Visible5 == true) && (pre_key_flg == 0))) {
                        console.log(" text4-4 to " + text.text);
                        text.text = "T";
                        slidekey = 1;
                    } else {
                        text.text = "I";
                        slidekey = 0;
                    }
                }
                //9#
                if ((text.text == "H") && (slidekey == 0) && (currentIndex2 == 2)) {
                    text.text = "I";
                    slidekey = 1;
                }
                //2020.11.28 Save previous key
                pre_key = text.text;
                console.log("pre key to " + pre_key);
                //---
                //font set
                var fontSizeTag = "<font size=\"" + fontSizeInit + "\"/>";
                var fontFaceTag = "<font face=\"" + fontName[0] + "\"/>";
                text.text = fontSizeTag + fontFaceTag + text.text;
                console.log(" text.text2 to " + text.text);
                //under line
                console.log(" slidekey to " + slidekey);
                //2020.11.21
                console.log("pre pre_slide text1 to " + pre_slidekey);
                //------------------------------------------------
                pre_slidekey = slidekey;
                console.log("pre pre_slide text2 to " + pre_slidekey);
                if (slidekey == 1) {
                    text.text = "<u>" + fontSizeTag + fontFaceTag + text.text + "</u>";
                    console.log(" slidekey ON ");
                }
                //2020.11.15
                text.placement = Placement.BELOW;
                text.autoplace = false;
            }
        }
    }

    function applyToSelection(func) {
        if (typeof curScore === 'undefined')
            Qt.quit();

        var cursor = curScore.newCursor();
        var startStaff;
        var endStaff;
        var endTick;
        var fullScore = false;
        var textposition = placetext.position;
        //jpn
        console.log("textposition set to " + textposition);
        xPositionInit = moveXPosition.value;
        //2020.11.21 new Y direction adjustment
        //  yPositionInit = moveYPosition.value;
        yPositionInit = moveYPosition.value + 2;
        textposition = textposition + yPositionInit;
        console.log("textposX set to " + xPositionInit);
        console.log("textposY set to " + yPositionInit);
        console.log("textposition 2 set to " + textposition);
        //---
        console.log("textposition set to " + placetext.position);
        cursor.rewind(1);
        if (!cursor.segment) {
            // no selection
            fullScore = true;
            startStaff = 0; // start with 1st staff
            endStaff = curScore.nstaves - 1; // and end with last
        } else {
            startStaff = cursor.staffIdx;
            cursor.rewind(2);
            if (cursor.tick == 0)
                // this happens when the selection includes
                // the last measure of the score.
                // rewind(2) goes behind the last segment (where
                // there's none) and sets tick=0
                endTick = curScore.lastSegment.tick + 1;
            else
                endTick = cursor.tick;
            endStaff = cursor.staffIdx;
        }
        console.log("Staff to " + startStaff + " - " + endStaff + " - " + endTick);
        for (var staff = startStaff; staff <= endStaff; staff++) {
            for (var voice = 0; voice < 4; voice++) {
                // no selection

                cursor.rewind(1); // beginning of selection
                cursor.voice = voice;
                cursor.staffIdx = staff;
                if (fullScore)
                    cursor.rewind(0);
 // beginning of score
                while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                    if (cursor.element && cursor.element.type == Element.CHORD) {
                        var text = newElement(Element.STAFF_TEXT);
                        //2020.11.15
                        text.placement = Placement.BELOW;
                        text.autoplace = false;
                        console.log("Placement text to " + text.placement);
                        //jpn
                        console.log("newElement to " + text);
                        var graceChords = cursor.element.graceNotes;
                        for (var i = 0; i < graceChords.length; i++) {
                            // iterate through all grace chords
                            var notes = graceChords[i].notes;
                            //jpn
                            console.log("graceChords to " + notes);
                            tabNotes(notes, text);
                            // there seems to be no way of knowing the exact horizontal pos.
                            // of a grace note, so we have to guess:
                            //                                text.offsetX = -2.5 * (graceChords.length - i);
                            //jpn
                            console.log("text.offsetX to " + text.offsetX);
                            //---
                            text.offsetY = textposition;
                            cursor.add(text);
                            // new text for next element
                            text = newElement(Element.STAFF_TEXT);
                            //2020.11.15
                            text.placement = Placement.BELOW;
                            text.autoplace = false;
                        }
                        var notes = cursor.element.notes;
                        tabNotes(notes, text);
                        text.offsetY = textposition;
                        console.log("text.pos.x2 to " + text.offsetX);
                        //jpn
                        console.log("harp.tuning to " + harp.tuning);
                        //            if((harp.tuning != 1)&&(harp.tuning != 2)&&(harp.tuning != 4)){
                        //                            if ((voice == 0) && (notes[0].pitch > 83))
                        //                                text.offsetX = 1;
                        //            }else{
                        //jpn
                        text.offsetX = xPositionInit;
                        console.log("text.pos.x3 to " + text.offsetX);
                        //            }
                        //---
                        cursor.add(text);
                    } // end if CHORD
                    cursor.next();
                } // end while segment
            } // end for voice
        } // end for staff
        Qt.quit();
    }

    function apply() {
        curScore.startCmd();
        applyToSelection(tabNotes);
        curScore.endCmd();
    }

    version: "3.6"
    description: qsTr("Interactive Harmonica Tablature Plugin.")
    menuPath: qsTr("Plugins.Interactive Harmonica Tablature")
    pluginType: "dock"
    width: 330
    //old 420
    height: 470
    // Interactive options
    implicitHeight: controls.implicitHeight * 1.5
    implicitWidth: controls.implicitWidth
    onScoreStateChanged: {
        // prevent recursion from own changes
        // try not to interfere with undo/redo commands
        // nothing to process?

        if (inCmd)
            return ;

        if (state.undoRedo)
            return ;

        nstaves = curScore.nstaves; // needed for validators in staff number inputs
        if (!noteNamesEnabledCheckBox.checked)
            return ;

        if (!curScore || state.startLayoutTick < 0)
            return ;

        var stavesRange = getStavesRange();
        processRange(state.startLayoutTick, state.endLayoutTick, stavesRange[0], stavesRange[1]);
    }
    onRun: {
        defaultFontSize = newElement(Element.STAFF_TEXT).fontSize;
    }
    onCurrentIndexChanged: {
        button4.checked = currentIndex == 0;
        buttonBlow4.checked = currentIndex == 1;
        button5.checked = currentIndex == 2;
        button8.checked = currentIndex2 == 0;
        buttonBlow8.checked = currentIndex2 == 1;
        button9.checked = currentIndex2 == 2;
    }
    onRun: {
        if (typeof curScore === 'undefined')
            Qt.quit();

    }

    Column {
        id: controls

        CheckBox {
            id: noteNamesEnabledCheckBox

            text: "Enable notes naming"
        }

        CheckBox {
            id: allStavesCheckBox

            checked: true
            text: "All staves"
        }

        Grid {
            id: staffRangeControls

            columns: 2
            spacing: 4
            enabled: !allStavesCheckBox.checked

            Text {
                height: firstStaffInput.height
                verticalAlignment: Text.AlignVCenter
                text: "first staff:"
            }

            TextField {
                id: firstStaffInput

                text: "0"
                onTextChanged: {
                    if (+lastStaffInput.text < +text)
                        lastStaffInput.text = text;

                }

                validator: IntValidator {
                    bottom: 0
                    top: nstaves - 1
                }

            }

            Text {
                height: lastStaffInput.height
                verticalAlignment: Text.AlignVCenter
                text: "last staff:"
            }

            TextField {
                id: lastStaffInput

                text: "0"
                onTextChanged: {
                    if (text !== "" && (+firstStaffInput.text > +text))
                        firstStaffInput.text = text;

                }

                validator: IntValidator {
                    bottom: 0
                    top: nstaves - 1
                }

            }

        }

    }

    //select key
    RowLayout {
        id: row0

        x: itemTextX1
        y: itemTextY1

        Label {
            font.pointSize: 12
            text: "key sel:"
        }

    }

    //select harmonica
    RowLayout {
        id: row1

        x: itemTextX1
        y: itemTextY1 + 30

        Label {
            font.pointSize: 12
            text: "type sel:"
        }

    }

    //select number position
    RowLayout {
        id: row2

        x: itemTextX1
        y: itemTextY1 + 60

        Label {
            font.pointSize: 12
            text: "position:"
        }

    }

    //id: window
    //    width:280
    //    height: 180
    ColumnLayout {
        id: column

        anchors.margins: 10
        anchors.top: parent.top
        //anchors.left: parent.left
        anchors.left: row2.right
        anchors.right: parent.right
        height: 90

        ComboBox {
            currentIndex: 17
            width: 100
            onCurrentIndexChanged: {
                console.debug("keylist to " + keylist.get(currentIndex).text + ", " + keylist.get(currentIndex).harpkey);
                keylist.key = keylist.get(currentIndex).harpkey;
            }

            model: ListModel {
                id: keylist

                property var key

                ListElement {
                    text: "Low G"
                    harpkey: 43
                }

                ListElement {
                    text: "Low Ab"
                    harpkey: 44
                }

                ListElement {
                    text: "Low A"
                    harpkey: 45
                }

                ListElement {
                    text: "Low Bb"
                    harpkey: 46
                }

                ListElement {
                    text: "Low B"
                    harpkey: 47
                }

                ListElement {
                    text: "Low C"
                    harpkey: 48
                }

                ListElement {
                    text: "Low C#"
                    harpkey: 49
                }

                ListElement {
                    text: "Low D"
                    harpkey: 50
                }

                ListElement {
                    text: "Low Eb"
                    harpkey: 51
                }

                ListElement {
                    text: "Low E"
                    harpkey: 52
                }

                ListElement {
                    text: "Low F"
                    harpkey: 53
                }

                ListElement {
                    text: "Low F#"
                    harpkey: 52
                }

                ListElement {
                    text: "G"
                    harpkey: 55
                }

                ListElement {
                    text: "Ab"
                    harpkey: 56
                }

                ListElement {
                    text: "A"
                    harpkey: 57
                }

                ListElement {
                    text: "Bb"
                    harpkey: 58
                }

                ListElement {
                    text: "B"
                    harpkey: 59
                }

                ListElement {
                    text: "C"
                    harpkey: 60
                }

                ListElement {
                    text: "Db"
                    harpkey: 61
                }

                ListElement {
                    text: "D"
                    harpkey: 62
                }

                ListElement {
                    text: "Eb"
                    harpkey: 63
                }

                ListElement {
                    text: "E"
                    harpkey: 64
                }

                ListElement {
                    text: "F"
                    harpkey: 65
                }

                ListElement {
                    text: "F#"
                    harpkey: 66
                }

                ListElement {
                    text: "High G"
                    harpkey: 67
                }

            }

        }

        ComboBox {
            currentIndex: 0
            width: 100
            onCurrentIndexChanged: {
                console.debug("harp to " + harp.get(currentIndex).text + ", " + harp.get(currentIndex).tuning);
                harp.tuning = harp.get(currentIndex).tuning;
            }

            model: ListModel {
                id: harp

                property var tuning

                ListElement {
                    text: "Blues Harp (Richter)"
                    tuning: 1
                }

                ListElement {
                    text: "Richter valved"
                    tuning: 2
                }

                ListElement {
                    text: "Paddy Richter (Brendan Power), valved"
                    tuning: 10
                }

                ListElement {
                    text: "Natural Minor"
                    tuning: 7
                }

                ListElement {
                    text: "Melody Maker"
                    tuning: 8
                }

                ListElement {
                    text: "Country"
                    tuning: 3
                }

                ListElement {
                    text: "Circular (Seydel), valved"
                    tuning: 5
                }

                ListElement {
                    text: "Circular (Inversed for blow 1), valved "
                    tuning: 9
                }

                ListElement {
                    text: "TrueChromatic Diatonic, valved"
                    tuning: 6
                }

                ListElement {
                    text: "Power Bender (Brendan Power), valved"
                    tuning: 11
                }

                ListElement {
                    text: "Power Draw (Brendan Power), valved"
                    tuning: 12
                }

                ListElement {
                    text: "Standard Chromatic"
                    tuning: 4
                }

            }

        }

        ComboBox {
            currentIndex: 2 // 1
            width: 100
            onCurrentIndexChanged: {
                console.debug("placetext to " + placetext.get(currentIndex).text + ", " + placetext.get(currentIndex).position);
                placetext.position = placetext.get(currentIndex).position;
            }

            model: ListModel {
                id: placetext

                property var position

                // ListElement { text: "Above staff"; position: "above" }
                // ListElement { text: "Below staff"; position: "below" }
                ListElement {
                    text: "higher"
                    position: -11
                }

                ListElement {
                    text: "abobe staff"
                    position: -8
                }

                ListElement {
                    text: "normal"
                    position: 2
                }

                ListElement {
                    text: "below staff"
                    position: 3
                }

                ListElement {
                    text: "lower"
                    position: 4
                }

            }

        }

    }

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        // anchors.top: column.bottom
        //height: 70
        anchors.top: rowTextY2.bottom
        height: 390 + itemTextY2

        Button {
            id: okButton

            text: "Ok"
            onClicked: {
                apply();
                Qt.quit();
            }
        }

        Button {
            id: closeButton

            text: "Close"
            onClicked: {
                Qt.quit();
            }
        }

    }
    //jpn ----------------------------

    // FONT SIZE
    RowLayout {
        id: rowFont

        x: itemTextX1
        y: itemTextY1 + 90

        Label {
            font.pointSize: 12
            text: "font size"
        }

    }

    RowLayout {
        id: rowFontR

        x: itemTextX1 + 110
        y: itemTextY1 + 90

        SpinBox {
            id: valFontSize

            implicitWidth: 55
            decimals: 0
            minimumValue: 8
            maximumValue: 20
            value: fontSizeInit
            font.pointSize: 13
        }

    }

    //X position
    RowLayout {
        id: rowMoveX1

        x: itemTextX1
        y: itemTextY1 + 110

        Label {
            font.pointSize: 12
            text: "H position"
        }

    }

    RowLayout {
        id: rowMoveX1a

        x: itemTextX1 + 170
        y: itemTextY1 + 110

        Label {
            font.pointSize: 12
            text: "(-)left (+)right"
        }

    }

    RowLayout {
        id: rowMoveX2

        x: itemTextX1 + 110
        y: itemTextY1 + 110

        SpinBox {
            id: moveXPosition

            implicitWidth: 55
            decimals: 1
            minimumValue: -5
            maximumValue: 5
            value: xPositionInit
            stepSize: 0.5
            font.pointSize: 12
            onEditingFinished: {
                xPositionInit = value;
                console.log("wXOffset to " + xPositionInit);
            }
        }

    }
    //Y position

    RowLayout {
        id: rowMoveY1

        x: itemTextX1
        y: itemTextY1 + 110 + itemTextY2

        Label {
            font.pointSize: 12
            text: "V position"
        }

    }

    RowLayout {
        id: rowMoveY1a

        x: itemTextX1 + 170
        y: itemTextY1 + 110 + itemTextY2

        Label {
            font.pointSize: 12
            text: "(-)up (+)down"
        }

    }
    //Vertical select

    RowLayout {
        id: rowMoveY2

        x: itemTextX1 + 110
        y: itemTextY1 + 110 + itemTextY2

        SpinBox {
            id: moveYPosition

            implicitWidth: 55
            decimals: 1
            minimumValue: -15
            maximumValue: 15
            value: yPositionInit
            stepSize: 1
            font.pointSize: 12
            onEditingFinished: {
                yPositionInit = value;
                console.log("wYOffset to " + yPositionInit);
            }
        }

    }

    //option box Border box
    GroupBox {
        id: boxGrp1

        x: itemTextX1
        y: itemTextY1 + 140 + itemTextY2
        width: 310
        //old 170
        height: 230
    }

    RowLayout {
        id: rowTextY1

        x: itemTextX1 + 22
        y: itemTextY1 + 140 + itemTextY2

        Label {
            font.pointSize: 12
            font.bold: true
            text: "-- chromatic harmonica option --"
        }

    }

    RowLayout {
        id: rowTextY2

        x: itemTextX1 + 5
        y: itemTextY1 + 170 + itemTextY2

        Label {
            font.pointSize: 12
            text: "[-choice F at the slide-]  [-C, F before slide-]"
        }

    }

    RowLayout {
        id: rowTextChkY1

        x: itemTextX1 + 5
        y: itemTextY1 + 190 + itemTextY2

        CheckBox {
            id: fNumChgCheckBox1

            checked: false
            text: qsTr("2")
            onClicked: {
                setFNumChg1();
            }
        }

    }

    RowLayout {
        id: rowTextChkY2

        x: itemTextX1 + 55
        y: itemTextY1 + 190 + itemTextY2

        CheckBox {
            id: fNumChgCheckBox2

            checked: false
            text: qsTr("6")
            onClicked: {
                setFNumChg2();
            }
        }

    }

    RowLayout {
        id: rowTextChkY3

        x: itemTextX1 + 105
        y: itemTextY1 + 190 + itemTextY2

        CheckBox {
            id: fNumChgCheckBox3

            checked: false
            text: qsTr("10")
            onClicked: {
                setFNumChg3();
            }
        }

    }
    //2020.11.21 new

    RowLayout {
        id: rowTextChkY4

        x: itemTextX1 + 165
        y: itemTextY1 + 190 + itemTextY2

        CheckBox {
            id: fNumChgCheckBox4

            checked: false
            text: qsTr("Match previous slide")
            onClicked: {
                setFNumChg4();
            }
        }

    }
    //---

    RowLayout {
        id: rowTextY3

        x: itemTextX1 + 5
        //old 220
        y: itemTextY1 + 280 + itemTextY2

        Label {
            font.pointSize: 12
            text: "-- Choice to use C --"
        }

    }
    //2020.11.28 new

    RowLayout {
        id: rowTextY4

        x: itemTextX1 + 5
        y: itemTextY1 + 220 + itemTextY2

        Label {
            font.pointSize: 12
            text: "-- Choice of C, F style --"
        }

    }
    //---

    //2020.11.28 new
    RowLayout {
        id: rowTextChkY5

        x: itemTextX1 + 5
        y: itemTextY1 + 250 + itemTextY2

        CheckBox {
            id: fNumChgCheckBox5

            checked: false
            text: qsTr("Match previous blow and draw")
            onClicked: {
                setFNumChg5();
            }
        }

    }

    GroupBox {
        title: "4 or 5"
        x: itemTextX1 + 5
        //old 240
        y: itemTextY1 + 300 + itemTextY2

        RowLayout {
            ExclusiveGroup {
                id: tabPositionGroup1
            }

            RadioButton {
                id: button4

                text: "4"
                checked: true
                exclusiveGroup: tabPositionGroup1
                onClicked: {
                    currentIndex = 0;
                }
            }

            RadioButton {
                id: buttonBlow4

                text: "-4#"
                exclusiveGroup: tabPositionGroup1
                onClicked: {
                    currentIndex = 1;
                }
            }

            RadioButton {
                id: button5

                text: "5"
                exclusiveGroup: tabPositionGroup1
                onClicked: {
                    currentIndex = 2;
                }
            }

        }

    }

    GroupBox {
        title: "8 or 9"
        x: itemTextX1 + 155
        //old 240
        y: itemTextY1 + 300 + itemTextY2

        RowLayout {
            ExclusiveGroup {
                id: tabPositionGroup2
            }

            RadioButton {
                id: button8

                text: "8"
                checked: true
                exclusiveGroup: tabPositionGroup2
                onClicked: {
                    currentIndex2 = 0;
                }
            }

            RadioButton {
                id: buttonBlow8

                text: "-4#"
                exclusiveGroup: tabPositionGroup2
                onClicked: {
                    currentIndex2 = 1;
                }
            }

            RadioButton {
                id: button9

                text: "9"
                exclusiveGroup: tabPositionGroup2
                onClicked: {
                    currentIndex2 = 2;
                }
            }

        }

    }

}
