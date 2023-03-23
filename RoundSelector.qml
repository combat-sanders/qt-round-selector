import QtQuick 2.15
import QtCharts 2.15
import "main.js" as Helper
Rectangle {
    property int sectorCount: 20
    property real holeValue: 0.4

    property string baseColor: "grey"
    property string selectionColor: "green"

    ChartView {
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        animationDuration: 500
        animationOptions: ChartView.AllAnimations

        PieSeries {
            id: pieSeriesId
            holeSize: holeValue
        }
    }

    onSectorCountChanged: {
        pieSeriesId.clear()
        for (let i = 0; i < sectorCount; i++) {
            pieSeriesId.append("", 100 / sectorCount)
            pieSeriesId.at(i).color = baseColor
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: {
            let sectorNumber = Helper.getSectorNumber(parent.width / 2, parent.height / 2, mouse.x, mouse.y, pieSeriesId.count)
            for (var i = 0; i < pieSeriesId.count; i++) {
                pieSeriesId.at(i).exploded = sectorNumber === i
                pieSeriesId.at(i).color = pieSeriesId.at(i).exploded ? selectionColor : baseColor
            }
        }

        onExited: {
            for (var i = 0; i < pieSeriesId.count; i++) {
                pieSeriesId.at(i).exploded = false
                pieSeriesId.at(i).color = baseColor
            }
        }
    }

}
