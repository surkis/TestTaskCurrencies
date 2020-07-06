import UIKit

protocol MainView: BasicView, ErrorAlertViewProtocol {
    
}

class MainViewController: UIViewController, MainView {

    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func make(configure: MainConfigurator) -> MainViewController {
        let viewContoller = MainViewController()
        viewContoller.presenter = configure.configure(view: viewContoller)
        return viewContoller
    }
}
