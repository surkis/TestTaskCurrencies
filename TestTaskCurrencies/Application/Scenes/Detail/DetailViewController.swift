import UIKit
import Charts

protocol DetailView: BasicView, ErrorAlertViewProtocol, NVIndicatorViewProtocol {
    func displayPage(title: String)
    func displayUpdateContent(model: ChartCurrencyModelView)
    func closeView()
}

class DetailViewController: UIViewController, DetailView {
    
    @IBOutlet weak var viewChart: LineChartView!
    
    // MARK: properties
    private var presenter: DetailPresenter!

    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIContent()
        presenter.needLoadContent()
    }

    // MARK: setup UI
    private func setupUIContent() {
        viewChart.delegate = self
        
        let legend = viewChart.legend
        legend.form = .line
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.font = UIFont.systemFont(ofSize: 14)

        let xAxis = viewChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = self
        xAxis.labelHeight = 20
        
        let rightAxis = viewChart.rightAxis
        rightAxis.removeAllLimitLines()
        rightAxis.gridLineDashLengths = [5, 5]
        rightAxis.valueFormatter = self
        rightAxis.minWidth = 30
        
        let leftAxis = viewChart.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.valueFormatter = self
        leftAxis.minWidth = 30
        
        viewChart.data = nil
    }
    
    // MARK: make method
    static func make(configure: DetailConfigurator) -> DetailViewController {
        let viewContoller = DetailViewController()
        viewContoller.presenter = configure.configure(view: viewContoller)
        return viewContoller
    }

    // MARK: display methods
    func displayPage(title: String) {
        self.title = title
    }
    
    func displayUpdateContent(model: ChartCurrencyModelView) {
        let values: [ChartDataEntry] = model.datas.map({
            ChartDataEntry(x: $0.xValue, y: $0.yValue)
        })
        let set1 = LineChartDataSet(entries: values, label: model.label)
        set1.drawIconsEnabled = false
        set1.setColor(UIColor.black)
        set1.setCircleColor(.gray)
        set1.lineWidth = 1
        set1.circleRadius = 5
        set1.valueFormatter = self
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 13, weight: .bold)
        set1.valueTextColor = .blue
        set1.formLineWidth = 1
        
        let gradientColors = [ChartColorTemplates.colorFromString("#0035b640").cgColor,
                              ChartColorTemplates.colorFromString("#ff35b640").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        viewChart.data = LineChartData(dataSet: set1)
        viewChart.animate(yAxisDuration: 1.0, easingOption: .easeOutQuint)
    }
    
    func closeView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: ChartViewDelegate {
    

}

// MARK: - extension: IAxisValueFormatter
extension DetailViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let axis = axis else { return "" }
        if axis is YAxis {
            return presenter.getYLineLabel(by: value)
        } else if axis is XAxis {
            return presenter.getXLineLabel(by: value)
        }
        return ""
    }
}

// MARK: - extension: IAxisValueFormatter
extension DetailViewController: IValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        return presenter.getPointLabel(by: value, index: dataSetIndex)
    }
}
