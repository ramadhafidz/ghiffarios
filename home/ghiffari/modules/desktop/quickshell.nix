{ pkgs, ... }:

{
  home.packages = [ pkgs.quickshell ];

  # Main Quickshell entrypoint
  home.file.".config/quickshell/shell.qml".text = ''
    import Quickshell
    import QtQuick

    ShellRoot {
        TopBar {}
        Dock {}
    }
  '';

  # Modern macOS-style Top Bar (pill shape with frosted glass blur)
  home.file.".config/quickshell/TopBar.qml".text = ''
    import Quickshell
    import Quickshell.Widgets
    import QtQuick
    import QtQuick.Layouts

    PanelWindow {
        id: topBarWindow
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 38
        color: "transparent"

        Rectangle {
            id: barBackground
            anchors.fill: parent
            anchors.topMargin: 4
            anchors.bottomMargin: 2
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            radius: 12
            color: "#b816181e"
            border.color: "#28ffffff"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                spacing: 12

                // Left: Apple / OS Menu
                RowLayout {
                    spacing: 8
                    Rectangle {
                        width: 24
                        height: 24
                        radius: 6
                        color: appleMa.containsMouse ? "#30ffffff" : "transparent"
                        Text {
                            anchors.centerIn: parent
                            text: ""
                            color: "white"
                            font.pixelSize: 15
                        }
                        MouseArea {
                            id: appleMa
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: menuPopup.visible = !menuPopup.visible
                        }
                    }

                    Text {
                        text: "GhiffariOS"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 12
                        font.family: "JetBrainsMono Nerd Font"
                    }

                    Text {
                        text: "File"
                        color: "#a0ffffff"
                        font.pixelSize: 12
                        font.family: "JetBrainsMono Nerd Font"
                    }

                    Text {
                        text: "Edit"
                        color: "#a0ffffff"
                        font.pixelSize: 12
                        font.family: "JetBrainsMono Nerd Font"
                    }

                    Text {
                        text: "View"
                        color: "#a0ffffff"
                        font.pixelSize: 12
                        font.family: "JetBrainsMono Nerd Font"
                    }
                }

                Item { Layout.fillWidth: true }

                // Center: Date & Clock Pill
                Rectangle {
                    implicitWidth: clockText.implicitWidth + 20
                    implicitHeight: 24
                    radius: 12
                    color: "#18ffffff"
                    border.color: "#15ffffff"
                    border.width: 1

                    Text {
                        id: clockText
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 12
                        font.bold: true
                        font.family: "JetBrainsMono Nerd Font"
                        text: Qt.formatDateTime(new Date(), "ddd d MMM  HH:mm:ss")
                    }

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: {
                            clockText.text = Qt.formatDateTime(new Date(), "ddd d MMM  HH:mm:ss")
                        }
                    }
                }

                Item { Layout.fillWidth: true }

                // Right: Status / Controls Pill
                RowLayout {
                    spacing: 10

                    Rectangle {
                        implicitWidth: 26
                        implicitHeight: 24
                        radius: 6
                        color: volMa.containsMouse ? "#30ffffff" : "transparent"
                        Text {
                            anchors.centerIn: parent
                            text: "󰕾"
                            color: "white"
                            font.pixelSize: 14
                            font.family: "JetBrainsMono Nerd Font"
                        }
                        MouseArea {
                            id: volMa
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Quickshell.execDetached(["pavucontrol"])
                        }
                    }

                    Rectangle {
                        implicitWidth: 26
                        implicitHeight: 24
                        radius: 6
                        color: netMa.containsMouse ? "#30ffffff" : "transparent"
                        Text {
                            anchors.centerIn: parent
                            text: "󰤨"
                            color: "white"
                            font.pixelSize: 14
                            font.family: "JetBrainsMono Nerd Font"
                        }
                        MouseArea {
                            id: netMa
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                        }
                    }

                    Rectangle {
                        implicitWidth: 26
                        implicitHeight: 24
                        radius: 6
                        color: pwrMa.containsMouse ? "#40ff5555" : "transparent"
                        Text {
                            anchors.centerIn: parent
                            text: "⏻"
                            color: "#ff6666"
                            font.pixelSize: 13
                            font.family: "JetBrainsMono Nerd Font"
                        }
                        MouseArea {
                            id: pwrMa
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: menuPopup.visible = !menuPopup.visible
                        }
                    }
                }
            }
        }

        // Dropdown Apple Menu
        Rectangle {
            id: menuPopup
            visible: false
            x: 12
            y: 38
            width: 180
            height: menuCol.implicitHeight + 16
            radius: 12
            color: "#d81a1c24"
            border.color: "#35ffffff"
            border.width: 1

            ColumnLayout {
                id: menuCol
                anchors.fill: parent
                anchors.margins: 8
                spacing: 4

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 24
                    radius: 6
                    color: mi1.containsMouse ? "#35ffffff" : "transparent"
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        text: "About GhiffariOS"
                        color: "white"
                        font.pixelSize: 11
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: mi1
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            menuPopup.visible = false;
                            Quickshell.execDetached(["kinfocenter"]);
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: "#25ffffff"
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 24
                    radius: 6
                    color: mi2.containsMouse ? "#35ffffff" : "transparent"
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        text: "System Settings..."
                        color: "white"
                        font.pixelSize: 11
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: mi2
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            menuPopup.visible = false;
                            Quickshell.execDetached(["systemsettings"]);
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: "#25ffffff"
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 24
                    radius: 6
                    color: mi3.containsMouse ? "#35ffffff" : "transparent"
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        text: "Lock Screen"
                        color: "white"
                        font.pixelSize: 11
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: mi3
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            menuPopup.visible = false;
                            Quickshell.execDetached(["loginctl", "lock-session"]);
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 24
                    radius: 6
                    color: mi4.containsMouse ? "#35ffffff" : "transparent"
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        text: "Restart..."
                        color: "white"
                        font.pixelSize: 11
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: mi4
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            menuPopup.visible = false;
                            Quickshell.execDetached(["systemctl", "reboot"]);
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 24
                    radius: 6
                    color: mi5.containsMouse ? "#35ffffff" : "transparent"
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        text: "Shut Down..."
                        color: "white"
                        font.pixelSize: 11
                        font.family: "JetBrainsMono Nerd Font"
                    }
                    MouseArea {
                        id: mi5
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            menuPopup.visible = false;
                            Quickshell.execDetached(["systemctl", "poweroff"]);
                        }
                    }
                }
            }
        }
    }
  '';

  # Modern macOS Floating Dock (smooth hover scale, indicator dots, glass pill)
  home.file.".config/quickshell/Dock.qml".text = ''
    import Quickshell
    import Quickshell.Widgets
    import QtQuick
    import QtQuick.Layouts

    PanelWindow {
        id: dockWindow
        anchors.bottom: true
        implicitWidth: dockCard.implicitWidth + 24
        implicitHeight: 74
        color: "transparent"

        margins.bottom: 10

        Rectangle {
            id: dockCard
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            implicitWidth: dockRow.implicitWidth + 24
            implicitHeight: 62
            radius: 20
            color: "#c0181a22"
            border.color: "#30ffffff"
            border.width: 1

            RowLayout {
                id: dockRow
                anchors.centerIn: parent
                spacing: 12

                Repeater {
                    model: [
                        { name: "Finder", icon: "org.kde.dolphin", cmd: "dolphin" },
                        { name: "Konsole", icon: "org.kde.konsole", cmd: "konsole" },
                        { name: "Kitty", icon: "kitty", cmd: "kitty" },
                        { name: "Kate", icon: "org.kde.kate", cmd: "kate" },
                        { name: "Settings", icon: "systemsettings", cmd: "systemsettings" },
                        { name: "Steam", icon: "steam", cmd: "steam" }
                    ]

                    delegate: Item {
                        id: iconDelegate
                        implicitWidth: 46
                        implicitHeight: 54

                        property bool isHovered: itemMouse.containsMouse

                        // Tooltip
                        Rectangle {
                            id: tooltipPill
                            visible: iconDelegate.isHovered
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: iconContainer.top
                            anchors.bottomMargin: 8
                            implicitWidth: tooltipLabel.implicitWidth + 14
                            implicitHeight: 22
                            radius: 8
                            color: "#e0181820"
                            border.color: "#30ffffff"
                            border.width: 1

                            Text {
                                id: tooltipLabel
                                anchors.centerIn: parent
                                text: modelData.name
                                color: "white"
                                font.pixelSize: 11
                                font.bold: true
                                font.family: "JetBrainsMono Nerd Font"
                            }
                        }

                        Item {
                            id: iconContainer
                            anchors.centerIn: parent
                            width: 44
                            height: 44
                            scale: iconDelegate.isHovered ? 1.25 : 1.0
                            y: iconDelegate.isHovered ? -8 : 0

                            Behavior on scale {
                                NumberAnimation { duration: 160; easing.type: Easing.OutCubic }
                            }
                            Behavior on y {
                                NumberAnimation { duration: 160; easing.type: Easing.OutCubic }
                            }

                            IconImage {
                                anchors.fill: parent
                                source: Quickshell.iconPath(modelData.icon)
                                backer.sourceSize: Qt.size(48, 48)
                            }
                        }

                        // Bottom indicator dot
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 2
                            width: 4
                            height: 4
                            radius: 2
                            color: "#90ffffff"
                        }

                        MouseArea {
                            id: itemMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Quickshell.execDetached([modelData.cmd]);
                            }
                        }
                    }
                }
            }
        }
    }
  '';
}
