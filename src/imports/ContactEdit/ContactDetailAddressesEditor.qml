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
import QtContacts 5.0

import Ubuntu.Contacts 0.1

ContactDetailGroupWithTypeEditor {
    title: i18n.tr("Address")
    detailQmlTypeName: "Address"
    detailType: ContactDetail.Address
    fields: [ Address.Street,
        Address.Locality,
        Address.Region,
        Address.Postcode,
        Address.Country ]
    placeholderTexts: [ i18n.tr("Street"),
                        i18n.tr("Locality"),
                        i18n.tr("Region"),
                        i18n.tr("Post code"),
                        i18n.tr("Country") ]
    inputMethodHints: Qt.ImhNoPredictiveText
}
