//========================================================================//
//                                                                        //
//  MuseScore                                                             //
//  Music Composition & Notation                                          //
//                                                                        //
//  Harmonica Tabs Plugin                                                 //
//                                                                        //
//                                                                        //
//  This program is free software; you can redistribute it and/or modify  //
//  it under the terms of the GNU General Public License version 2        //
//  as published by the Free Software Foundation and appearing in         //
//  the file LICENCE.GPL                                                  //
//                                                                        //
//========================================================================//

import QtQuick 2.9
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2 // FileDialogs
import QtQuick.Window 2.3
import Qt.labs.folderlistmodel 2.2
import Qt.labs.settings 1.0
import QtQml 2.8
import MuseScore 3.0
import FileIO 3.0


MuseScore {
    version : "3.0"
    description : "Harmonica Tab plugin"
    menuPath : "Plugins.Harmonica Tablature"
    pluginType : "dialog"

    // ------ OPTIONS -------
    property string sep  : "\n"      // change to "," or " " if you want tabs horizontally
    property string _Bl  : "+"
    property string _D   : "-"
    property string _B   : "'"      // change to "b" if you want bend to be noted with b
    property string _O   : "o"      // overbend char
    property string _S   : "&lt;"  // button slide char <
    property string _L   : "°"      // 16 hole chromatic lowest register char
    property bool bold   : false

    property string _RED  : "#ff0000"

    property bool _DEBUG : false
    // ------ OPTIONS -------

    id : window
    width : 280
    height : 250

    ColumnLayout {
        id : column
        anchors.margins : 10
        anchors.top : parent.top
        anchors.left : parent.left
        anchors.right : parent.right
        height : 90

        RowLayout {
            Label {
                text : "Key"
            }

            ComboBox {
                currentIndex : 17
                model : ListModel {
                    id : keylist
                    property var key
                    ListElement { text: "Low G";  harpkey: 43 }
                    ListElement { text: "Low Ab"; harpkey: 44 }
                    ListElement { text: "Low A";  harpkey: 45 }
                    ListElement { text: "Low Bb"; harpkey: 46 }
                    ListElement { text: "Low B";  harpkey: 47 }
                    ListElement { text: "Low C";  harpkey: 48 }
                    ListElement { text: "Low C#"; harpkey: 49 }
                    ListElement { text: "Low D";  harpkey: 50 }
                    ListElement { text: "Low Eb"; harpkey: 51 }
                    ListElement { text: "Low E";  harpkey: 52 }
                    ListElement { text: "Low F";  harpkey: 53 }
                    ListElement { text: "Low F#"; harpkey: 52 }
                    ListElement { text: "G";      harpkey: 55 }
                    ListElement { text: "Ab";     harpkey: 56 }
                    ListElement { text: "A";      harpkey: 57 }
                    ListElement { text: "Bb";     harpkey: 58 }
                    ListElement { text: "B";      harpkey: 59 }
                    ListElement { text: "C";      harpkey: 60 }
                    ListElement { text: "Db";     harpkey: 61 }
                    ListElement { text: "D";      harpkey: 62 }
                    ListElement { text: "Eb";     harpkey: 63 }
                    ListElement { text: "E";      harpkey: 64 }
                    ListElement { text: "F";      harpkey: 65 }
                    ListElement { text: "F#";     harpkey: 66 }
                    ListElement { text: "High G"; harpkey: 67 }
                }

                width : 100
                onCurrentIndexChanged : {
                    _DEBUG && console.debug(keylist.get(currentIndex).text + ", " + keylist.get(currentIndex).harpkey)
                    keylist.key = keylist.get(currentIndex).harpkey
                }
            }
        }

        RowLayout {
            Label {
                text : "Tuning"
            }

            ComboBox {
                currentIndex : 0
                model : ListModel {
                    id : harp
                    property var tuning
                    ListElement { tuning: 1;  text: "Blues Harp (Richter)" }
                    ListElement { tuning: 2;  text: "Standard Chromatic" }
                    ListElement { tuning: 3;  text: "16 Hole Standard Chromatic" }
                    ListElement { tuning: 4;  text: "Melody Maker" }
                    ListElement { tuning: 5;  text: "Country" }
                    ListElement { tuning: 6;  text: "Richter valved" }
                    ListElement { tuning: 7;  text: "Natural Minor" }
                    ListElement { tuning: 8;  text: "Circular (Seydel), valved" }
                    ListElement { tuning: 9;  text: "Circular (Inversed for blow 1), valved " }
                    ListElement { tuning: 10; text: "Paddy Richter (Brendan Power), valved" }
                    ListElement { tuning: 11; text: "Power Bender (Brendan Power), valved" }
                    ListElement { tuning: 12; text: "Power Draw (Brendan Power), valved" }
                    ListElement { tuning: 13; text: "TrueChromatic Diatonic, valved" }
                }

                width : 100
                onCurrentIndexChanged : {
                    _DEBUG && console.debug(harp.get(currentIndex).text + ", " + harp.get(currentIndex).tuning)
                    harp.tuning = harp.get(currentIndex).tuning
                }
            }
        }

        RowLayout {
            Label {
                text : "Placement"
            }

            ComboBox {
                currentIndex : 1
                model : ListModel {
                    id : placetext
                    property var position
                    ListElement { text: "Above staff"; position: "above" }
                    ListElement { text: "Below staff"; position: "below" }
                }

                width : 100
                onCurrentIndexChanged : {
                    _DEBUG && console.debug(placetext.get(currentIndex).text + ", " + placetext.get(currentIndex).position)
                    placetext.position = placetext.get(currentIndex).position
                }
            }
        }

        ColumnLayout {
            Label {
                text : "Breath Indicator"
                font.underline : true
            }

            RowLayout {
                Label {
                    text : "Position"
                }

                ComboBox {
                    currentIndex : 0
                    model : ListModel {
                        id : breathtext
                        property var position
                        ListElement { text: "Left of Hole #";  position: "left" }
                        ListElement { text: "Right of Hole #"; position: "right" }
                    }

                    width : 100
                    onCurrentIndexChanged : {
                        _DEBUG && console.debug(breathtext.get(currentIndex).text + ", " + breathtext.get(currentIndex).position)
                        breathtext.position = breathtext.get(currentIndex).position
                    }
                }
            }

            RowLayout {
                Label {
                    text : "Shown"
                }

                ComboBox {
                    currentIndex : 0
                    model : ListModel {
                        id : breathIndicator
                        property var mode
                        ListElement { text: "Both";      mode: "both" }
                        ListElement { text: "Blow Only"; mode: "blow_only" }
                        ListElement { text: "Draw Only"; mode: "draw_only" }
                    }

                    width : 100
                    onCurrentIndexChanged : {
                        _DEBUG && console.debug(breathIndicator.get(currentIndex).text + ", " + breathIndicator.get(currentIndex).mode)
                        breathIndicator.mode = breathIndicator.get(currentIndex).mode
                    }
                }
            }
        }

        RowLayout {
            anchors.horizontalCenter : parent.horizontalCenter
            height : 70

            Button {
                id : okButton
                text : "Ok"
                onClicked : {
                    apply()
                    quit()
                }
            }

            Button {
                id : closeButton
                text : "Close"
                onClicked : {
                    quit()
                }
            }
        }
    }

    function tabNotes(notes, text) {
        //Standard Richter tuning with overbends
        var richter = [
            "+1", "-1%1".arg(_B), "-1", "+1%1".arg(_O), "+2", "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "-3%1%2%3".arg(_B).arg(_B).arg(_B), "-3%1%2".arg(_B).arg(_B), "-3%1".arg(_B), "-3",
            "+4", "-4%1".arg(_B), "-4", "+4%1".arg(_O), "+5", "-5", "+5%1".arg(_O), "+6", "-6%1".arg(_B), "-6", "+6%1".arg(_O), "-7",
            "+7", "-7%1".arg(_O), "-8", "+8%1".arg(_B), "+8", "-9", "+9%1".arg(_B), "+9", "-9%1".arg(_O), "-10", "+10%1%2".arg(_B).arg(_B), "+10%1".arg(_B), "+10", "-10%1".arg(_O)
        ];


        var richterValved = [
            "+1", "-1%1".arg(_B), "-1", "+2%1".arg(_B), "+2", "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "-3%1%2%3".arg(_B).arg(_B).arg(_B), "-3%1%2".arg(_B).arg(_B), "-3%1".arg(_B), "-3",
            "+4", "-4%1".arg(_B), "-4", "+5%1".arg(_B), "+5", "-5", "+6%1".arg(_B), "+6", "-6%1".arg(_B), "-6", "-7%1".arg(_B), "-7",
            "+7", "-8%1".arg(_B), "-8", "+8%1".arg(_B), "+8", "-9", "+9%1".arg(_B), "+9", "-10%1".arg(_B), "-10", "+10%1%2".arg(_B).arg(_B), "+10%1".arg(_B), "+10"
        ];
        richterValved[-2] = "+1%1%2".arg(_B).arg(_B); richterValved[-1] = "+1%1".arg(_B); //Two notes below the key at blow 1


        // _Brendan Power's tuning, half valved
        var paddyRichter = [
            "+1", "-1%1".arg(_B), "-1", "+2%1".arg(_B), "+2", "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "+3%1".arg(_B), "+3", "-3%1".arg(_B), "-3",
            "+4", "-4%1".arg(_B), "-4", "+5%1".arg(_B), "+5", "-5", "+6%1".arg(_B), "+6", "-6%1".arg(_B), "-6", "-7%1".arg(_B), "-7",
            "+7", "-8%1".arg(_B), "-8", "+8%1".arg(_B), "+8", "-9", "+9%1".arg(_B), "+9", "-10%1".arg(_B), "-10", "+10%1%2".arg(_B).arg(_B), "+10%1".arg(_B), "+10"
        ];
        paddyRichter[-2] = "+1%1%2".arg(_B).arg(_B); paddyRichter[-1] = "+1%1".arg(_B); //Two notes below the key at blow 1


        var country = [
            "+1", "-1%1".arg(_B), "-1", "+1%1".arg(_O), "+2", "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "-3%1%2%3".arg(_B).arg(_B).arg(_B), "-3%1%2".arg(_B).arg(_B), "-3%1".arg(_B), "-3",
            "+4", "-4%1".arg(_B), "-4", "+4%1".arg(_O), "+5", "-5%1".arg(_B), "-5", "+6", "-6%1".arg(_B), "-6", "+6%1".arg(_O), "-7",
            "+7", "-7%1".arg(_O), "-8", "+8%1".arg(_B), "+8", "-9", "+9%1".arg(_B), "+9", "-9%1".arg(_O), "-10", "+10%1%2".arg(_B).arg(_B), "+10%1".arg(_B), "+10", "-10%1".arg(_O)
        ];


        var standardChromatic = [
            "+1", "+1%1".arg(_S), "-1", "-1%1".arg(_S), "+2", "-2", "-2%1".arg(_S), "+3", "+3%1".arg(_S), "-3", "-3%1".arg(_S), "-4",
            "+4", "+4%1".arg(_S), "-5", "-5%1".arg(_S), "+6", "-6", "-6%1".arg(_S), "+7", "+7%1".arg(_S), "-7", "-7%1".arg(_S), "-8",
            "+8", "+8%1".arg(_S), "-9", "-9%1".arg(_S), "+10", "-10", "-10%1".arg(_S), "+11", "+11%1".arg(_S), "-11", "-11%1".arg(_S), "-12", "+12", "+12%1".arg(_S), "-12%1".arg(_S)
        ];


        var standard16Chromatic = [
            "+1%1".arg(_L), "+1%1%2".arg(_L).arg(_S), "-1%1".arg(_L), "-1%1%2".arg(_L).arg(_S), "+2%1".arg(_L), "-2%1".arg(_L), "-2%1%2".arg(_L).arg(_S), "+3%1".arg(_L), "+3%1%2".arg(_L).arg(_S), "-3%1".arg(_L), "-3%1%2".arg(_L).arg(_S), "-4%1".arg(_L),
            "+1", "+1%1".arg(_S), "-1", "-1%1".arg(_S), "+2", "-2", "-2%1".arg(_S), "+3", "+3%1".arg(_S), "-3", "-3%1".arg(_S), "-4",
            "+4", "+4%1".arg(_S), "-5", "-5%1".arg(_S), "+6", "-6", "-6%1".arg(_S), "+7", "+7%1".arg(_S), "-7", "-7%1".arg(_S), "-8",
            "+8", "+8%1".arg(_S), "-9", "-9%1".arg(_S), "+10", "-10", "-10%1".arg(_S), "+11", "+11%1".arg(_S), "-11", "-11%1".arg(_S), "-12", "+12", "+12%1".arg(_S), "-12%1".arg(_S)
        ];


        // Circular/Spiral tuned diatonic
        // Key per Seydel "G"on blow 1, C major at draw 2, A minor at draw 1
        var zirkValved = [
            "+1", "-1%1".arg(_B), "-1", "+2%1".arg(_B), "+2", "-2", "+3%1".arg(_B), "+3", "-3%1".arg(_B), "-3", "+4", "-4%1".arg(_B),
            "-4", "+5%1".arg(_B), "+5", "-5%1".arg(_B), "-5", "+6", "-6%1".arg(_B), "-6", "+7%1".arg(_B), "+7", "-7", "+8%1".arg(_B),
            "+8", "-8%1".arg(_B), "-8", "+9%1".arg(_B), "+9", "-9", "10%1".arg(_B), "+10", "-10%1".arg(_B), "-10"
        ];


        //True Chromatic diatonic, valves
        //Another side of the spiral logic is expanded in the “True Chromatic” tuning, designed by Eugene Ivanov.
        //All chords can be arranged in a continuous, looped progression on major and minor triads:
        //C Eb G _Bb D F A C E G _B D Gb A Db E Ab _B Eb Gb _Bb Db F Ab C (and looped on C minor after that).
        var trueChrom = [
            "+1", "-1%1".arg(_B), "-1", "+2", "-2%1".arg(_B), "-2", "+3%1".arg(_B), "+3", "-3%1".arg(_B), "-3", "+4", "-4%1".arg(_B),
            "-4", "+5%1".arg(_B), "+5", "-5%1".arg(_B), "-5", "+6", "-6%1".arg(_B), "-6", "+7%1".arg(_B), "+7", "-7%1".arg(_B), "-7",
            "+8", "-8%1".arg(_B), "-8", "+9%1".arg(_B), "+9", "-9%1".arg(_B), "-9", "+10", "-10%1".arg(_B), "-10"
        ];


        //Labeled by blow 1 like Hohner. Seydel and Lee _Okar labels by draw 2
        var naturalMinor = [
            "+1", "-1%1".arg(_B), "-1", "+2", "-2%1%2%3".arg(_B).arg(_B).arg(_B), "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "-3%1%2".arg(_B).arg(_B), "-3%1".arg(_B), "-3",          "+3%1".arg(_O),
            "+4", "-4%1".arg(_B), "-4", "+5", "-5%1".arg(_B), "-5", "+5%1".arg(_O), "+6", "-6%1".arg(_B), "-6", "-7",          "+7%1".arg(_B),
            "+7", "-7%1".arg(_O), "-8", "+8", "-8%1".arg(_O), "-9", "+9%1".arg(_B), "+9", "-9%1".arg(_O), "-10", "+10%1%2".arg(_B).arg(_B), "+10%1".arg(_B), "+10", "-10%1".arg(_O)
         ];


        var melodyMaker = [ , , , , , // label by draw 2
            "+1", "-1%1".arg(_B), "-1", "+1%1".arg(_O), "+2", "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "+2%1".arg(_O), "+3", "-3%1".arg(_B), "-3",
            "+4", "-4%1".arg(_B), "-4", "+4%1".arg(_O), "+5", "-5%1".arg(_B), "-5", "+6", "-6%1".arg(_B), "-6", "+6%1".arg(_O), "-7",
            "+7", "-7%1".arg(_O), "-8", "+8%1".arg(_B), "+8", "-8%1".arg(_O), "-9", "+9", "-9%1".arg(_O), "-10", "+10%1%2".arg(_B).arg(_B), "+10%1".arg(_B), "+10", "-10%1".arg(_O)
         ];


        // Circular/Spiral tuned diatonic
        // Inversed for _Blow 1. Key of C major scale starts at blow 1
        var spiral_b1 = [
            "+1", "-1%1".arg(_B), "-1", "+2%1".arg(_B), "+2", "-2", "+3%1".arg(_B), "+3", "-3%1".arg(_B), "-3", "+4%1".arg(_B), "+4",
            "-4", "+5%1".arg(_B), "+5", "-5%1".arg(_B), "-5", "+6", "-6%1".arg(_B), "-6", "+7%1".arg(_B), "+7%1".arg(_B), "-7", "-7",
            "+8", "-8%1".arg(_B), "-8", "+9%1".arg(_B), "+9", "-9", "+10%1".arg(_B), "+10", "-10%1".arg(_B), "-10"
        ];


        // _Brendan Power's tuning, half valved
        var power_Bender = [
            "+1", "-1%1".arg(_B), "-1", "+2%1".arg(_B), "+2", "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "-3%1%2%3".arg(_B).arg(_B).arg(_B), "-3%1%2".arg(_B).arg(_B), "-3%1".arg(_B), "-3",
            "+4", "-4%1".arg(_B), "-4", "-5%1".arg(_B), "-5", "+6", "-6%1".arg(_B), "-6", "+7%1".arg(_B), "+7", "-7%1".arg(_B), "-7",
            "+8", "-8%1".arg(_B), "-8", "+9%1".arg(_B), "+9", "-9%1%2".arg(_B).arg(_B), "-9%1".arg(_B), "-9", "+10%1".arg(_B), "+10", "-10%1%2".arg(_B).arg(_B), "-10%1".arg(_B), "-10"
        ];
        power_Bender[-2] = "+1%1%2".arg(_B).arg(_B); power_Bender[-1] = "+1%1".arg(_B); //Two notes below the key at blow 1


        // Brendan Power's tuning, half valved
        var powerDraw = [
            "+1", "-1%1".arg(_B), "-1", "+2%1".arg(_B), "+2", "-2%1%2".arg(_B).arg(_B), "-2%1".arg(_B), "-2", "-3%1%2%3".arg(_B).arg(_B).arg(_B), "-3%1%2".arg(_B).arg(_B), "-3%1".arg(_B), "-3",
            "+4", "-4%1".arg(_B), "-4", "+5%1".arg(_B), "+5", "-5", "+6%1".arg(_B), "+6", "-6%1".arg(_B), "-6", "-7%1".arg(_B), "-7",
            "+8", "-8%1".arg(_B), "-8", "+9%1".arg(_B), "+9", "-9%1%2".arg(_B).arg(_B), "-9%1".arg(_B), "-9", "+10%1".arg(_B), "+10", "-10%1%2".arg(_B).arg(_B), "-10%1".arg(_B), "-10"
        ];
        powerDraw[-2] = "+1%1%2".arg(_B).arg(_B); powerDraw[-1] = "+1%1".arg(_B); //Two notes below the key at blow 1


        var tuning = richter
        switch (harp.tuning) {
            case 1:  tuning = richter;             break;
            case 2:  tuning = standardChromatic;   break;
            case 3:  tuning = standard16Chromatic; break;
            case 4:  tuning = melodyMaker;         break;
            case 5:  tuning = country;             break;
            case 6:  tuning = richterValved;       break;
            case 7:  tuning = naturalMinor;        break;
            case 8:  tuning = zirkValved;          break;
            case 9:  tuning = spiral_b1;           break;
            case 10: tuning = paddyRichter;        break;
            case 11: tuning = powerBender;         break;
            case 12: tuning = powerDraw;           break;
            case 13: tuning = trueChrom;           break;
            default: tuning = richter;             break;
        }

        var harpkey = keylist.key
        _DEBUG && console.debug("harpkey set to  " + keylist.key)

        // For 16 Holes Standard C Chromatic
        var C3 = 48
        var C4 = 60
        var chromatic16Tuning = 3

        if (harpkey == C4 && harp.tuning == chromatic16Tuning) {
            harpkey = C3
        }

        for (var i = 0; i < notes.length; i++) {
            if (i > 0) {
                text.text = sep + text.text
            }

            if (typeof notes[i].pitch === "undefined")  // just in case

            return
            var tab = tuning[notes[i].pitch - harpkey]
            if (typeof tab === "undefined") {
                text.text = "<b>X<\b>"
                text.color = _RED

            } else {
                if (notes[i].tieBack != null) { // No tab if the note is tied
                    tab = ""
                }

                if (_B !== "b")
                    tab = tab.replace(/b/g, _B)

                tab = applyStyleToTabNotes(tab)
                text.text = tab + text.text
            }
        }
    }

    function positionBreathIndicator(tab) {
        if (breathtext.position !== "right") {
            return tab
        }
         // MuseScore doesn't appear to have a Regex library
         // So, we do this a naive way.
         // Assumes harmonicas have 1-99 holes.
        var symbol = tab[0]
        var isDoubleDigit = false

        if (tab.length >= 3) { // Is the third character a digit?
            for (var number = 0; number <= 9; number++) {
                isDoubleDigit = isDoubleDigit || tab[2] == number
            }
        }

        var newBreathIndex = isDoubleDigit ? 2 : 1
        var newString = ""

        for (var index = 1; index < tab.length; index++) {
            newString += tab[index]

            if (index == newBreathIndex) {
                newString += symbol
            }
        }
        return newString
    }

    function applyStyleToTabNotes(rawTab) {
        var finalTab = rawTab
        finalTab = positionBreathIndicator(finalTab)

        switch (breathIndicator.mode) {
            case "draw_only": finalTab = finalTab.replace("+", "")
                break
            case "blow_only": finalTab = finalTab.replace("-", "")
                break
            default: finalTab = finalTab
                break
        }

        return finalTab
    }

    function applyToSelection(func) {
        if (typeof curScore === 'undefined') {
            quit()
        }

        var cursor = curScore.newCursor()
        var startStaff
        var endStaff
        var endTick
        var fullScore = false
        var textposition = (placetext.position === "above" ? Placement.ABOVE : Placement.BELOW)
        cursor.rewind(1)

        if (! cursor.segment) { // no selection
            fullScore = true
            startStaff = 0 // start with 1st staff
            endStaff = curScore.nstaves - 1 // and end with last

        } else {
            startStaff = cursor.staffIdx
            cursor.rewind(2)

            if (cursor.tick == 0) { // this happens when the selection includes // the last measure of the score. // rewind(2) goes behind the last segment (where // there's none) and sets tick=0
                endTick = curScore.lastSegment.tick + 1

            } else {
                endTick = cursor.tick
            }

            endStaff = cursor.staffIdx
        }

        _DEBUG && console.debug(startStaff + " - " + endStaff + " - " + endTick)

        for (var staff = startStaff; staff <= endStaff; staff++) {
            for (var voice = 0; voice < 4; voice++) {
                cursor.rewind(1) // beginning of selection
                cursor.voice = voice
                cursor.staffIdx = staff
                if (fullScore) {  // no selection

                    cursor.rewind(0) // beginning of score
                    while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                        if (cursor.element && cursor.element.type == Element.CHORD) {
                            var text = newElement(Element.STAFF_TEXT)
                            var graceChords = cursor.element.graceNotes

                            for (var i = 0; i < graceChords.length; i++) { // iterate through all grace chords
                                var notes = graceChords[i].notes
                                tabNotes(notes, text) // TODO: deal with placement of grace note on the x axis
                                text.placement = textposition
                                text.offset = Qt.point(-40 * (graceChords.length - i), 0)
                                cursor.add(text) // new text for next element
                                text = newElement(Element.STAFF_TEXT)
                            }

                            var notes = cursor.element.notes
                            tabNotes(notes, text)
                            text.placement = textposition
                            cursor.add(text)
                        } // end if CHORD
                        cursor.next()

                    } // end while segment
                } // ond if fullScore
            } // end for voice
        } // end for staff
        quit()
    } // end applyToSelection()

    function apply() {
        curScore.startCmd()
        applyToSelection(tabNotes)
        curScore.endCmd()
    }

    onRun : {
        if (typeof curScore === 'undefined')
            quit()
    }
}
