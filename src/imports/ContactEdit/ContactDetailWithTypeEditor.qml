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

import QtQuick 2.0
import Ubuntu.Components 0.1
import QtContacts 5.0
import Ubuntu.Components.ListItems 0.1 as ListItem

import "../Common"

ContactDetailBase {
    id: root

    property double itemHeight: units.gu(3)
    property alias types: detailTypeSelector.values
    property int fieldType: -1
    property alias selectedTypeIndex: detailTypeSelector.currentIndex
    property variant placeholderTexts: []

    function selectType(type) {
        detailTypeSelector.selectItem(type)
    }

    function save() {
        var detailchanged  = false

        // save field values
        var isEmpty = true
        for (var i=0; i < fieldValues.children.length; i++) {
            var input = fieldValues.children[i]
            if (input.detail && (input.field >= 0)) {
                var originalValue = input.detail.value(input.field)
                if (input.text != "") {
                    isEmpty = false
                }
                if (originalValue != input.text) {
                    input.detail.setValue(input.field, input.text)
                    detailchanged  = true
                }
            }
        }

        if (isEmpty) {
            contact.removeDetail(detail)
        }

        return detailchanged
    }

    // disable listview mouse area
    focus: true
    __mouseArea.visible: false
    implicitHeight: detailTypeSelector.height + fieldValues.height + units.gu(2)

    ValueSelector {
        id: detailTypeSelector

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            right: parent.right
            rightMargin: units.gu(2)
            top: parent.top
            topMargin: units.gu(1)
        }
        height: units.gu(3)
    }

    Column {
        id: fieldValues

        anchors {
            left: detailTypeSelector.left
            right: detailTypeSelector.right
            top: detailTypeSelector.bottom
        }
        focus: true
        height: childrenRect.height

        Repeater {
            model: root.fields

            focus: true
            TextInputDetail {
                id: detail
                Component.onCompleted: {
                    if (index == 0) {
                        focus = true
                        detail.forceActiveFocus()
                    }
                }
                focus: false
                detail: root.detail
                field: modelData
                placeholderText: root.placeholderTexts[index]

                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: root.itemHeight
                onRemoveClicked: root.contact.removeDetail(root.detail)
            }
        }
    }

}
