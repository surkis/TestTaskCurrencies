import UIKit

protocol MainView: BasicView, ErrorAlertViewProtocol {
    func displayUpdateContent()
    func displayPage(title: String)
}

class MainViewController: UIViewController, MainView {

    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: properties
    var presenter: MainPresenter!
    
    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIContent()
        presenter.needLoadContent()
    }
    
    // MARK: setup ui
    private func setupUIContent() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.itemCurrencyTableViewCell)
    }
    
    // MARK: make method
    static func make(configure: MainConfigurator) -> MainViewController {
        let viewContoller = MainViewController()
        viewContoller.presenter = configure.configure(view: viewContoller)
        return viewContoller
    }
    
    // MARK: display methods
    func displayUpdateContent() {
        tableView.reloadData()
    }
    
    func displayPage(title: String) {
        self.title = title
    }
}

// MARK: - extension: UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.itemCurrencyTableViewCell, for: indexPath)!
        presenter.configure(cellView: cell, for: indexPath)
        return cell
    }
}
