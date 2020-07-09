import Foundation

struct ChartCurrencyModelView {
    var datas: [ItemChartModelView]
    var label: String
//    var serieData: [Double]
//    var labels: [LabelChartModelView]
//
//
//
//    var labelsValues: [Double] {
//        return labels.map({$0.value})
//    }
//
//    var labelsTextFormatter: [String] {
//        return labels.map({$0.textFormatter})
//    }
//
//    var minY: Double {
//        return serieData.min()! - 5
//    }
}

struct ItemChartModelView {
    var yValue: Double
    var xValue: Double
}
