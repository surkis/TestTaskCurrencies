import UIKit

protocol ErrorAlertViewProtocol {
    func displayError(messsage: String)
}

extension ErrorAlertViewProtocol where Self: UIViewController {
    
    func displayError(messsage: String) {
        let alertViewController = UIAlertController(title: R.string.localizable.alert_error_title(),
                                                    message: messsage,
                                                    preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(
            title: R.string.localizable.alert_button_ok(),
            style: .default,
            handler: nil)
        )
        
        self.present(alertViewController, animated: true, completion: nil)
    }
}
