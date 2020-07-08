import UIKit
import Charts

protocol DetailView: BasicView, ErrorAlertViewProtocol {
    func displayPage(title: String)
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
}
