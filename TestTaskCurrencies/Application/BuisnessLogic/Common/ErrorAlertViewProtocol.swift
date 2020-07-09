import UIKit

protocol ErrorAlertViewProtocol: AlertViewProtocol {
    func displayError(message: String)
}

extension ErrorAlertViewProtocol where Self: UIViewController {
    
    func displayError(message: String) {
        let model = AlertModelView(title: R.string.localizable.alert_error_title(), message: message, style: .alert)
        displayAlert(model)
    }
}
