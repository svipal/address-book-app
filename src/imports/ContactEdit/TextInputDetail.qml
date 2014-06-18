/*
 * Copyright (C) 2012-2013 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.2
import Ubuntu.Components 0.1
import Ubuntu.Keyboard 0.1
import Ubuntu.Telephony.PhoneNumber 0.1

//style
import Ubuntu.Components.Themes.Ambiance 0.1

FocusScope {
    id: root

    property QtObject detail
    property int field: -1
    property variant originalValue: root.detail && (root.field >= 0) ? root.detail.value(root.field) : null

    // proxy textField
    property alias font: field.font
    property alias placeholderText: field.placeholderText
    property alias inputMethodHints: field.inputMethodHints
    property alias text: field.text
    property alias hasClearButton: field.hasClearButton
    // proxy PhoneNumberField
    property alias autoFormat: field.autoFormat

    signal removeClicked()

    //FIXME: Move this property to TextField as soon as the SDK get ported to QtQuick 2.2
    activeFocusOnTab: true

    // WORKAROUND: For some reason TextField.focus property get reset to false
    // we need do a deep investigation on that
    Binding {
        target: field
        property: "focus"
        value: visible
    }

    onActiveFocusChanged:  {
        if (activeFocus && field.visible) {
            field.forceActiveFocus()
        }
    }

    onOriginalValueChanged: {
        if (originalValue && (originalValue !== "")) {
            field.text = originalValue
        }
    }

    PhoneNumberField {
        id: field

        anchors.fill: parent

        // TRANSLATORS: This value is used as default value for phone number format, when no coutry code is provided
        // the supported values can be found in: https://www.iso.org/obp/ui/#search
        defaultRegion: i18n.tr("US")
        autoFormat: false

        // Ubuntu.Keyboard
        InputMethod.extensions: { "enterKeyText": i18n.tr("Next") }
        readOnly: root.detail ? root.detail.readOnly : true
        style: TextFieldStyle {
            overlaySpacing: 0
            frameSpacing: 0
            background: Item {}
            color: UbuntuColors.lightAubergine
        }
        onActiveFocusChanged: {
            if (activeFocus) {
                makeMeVisible(root)
            }
        }

        // default style
        font {
            family: "Ubuntu"
            pixelSize: activeFocus ? FontUtils.sizeToPixels("large") : FontUtils.sizeToPixels("medium")
        }
        Keys.onReturnPressed: application.sendTabEvent();
    }
}
