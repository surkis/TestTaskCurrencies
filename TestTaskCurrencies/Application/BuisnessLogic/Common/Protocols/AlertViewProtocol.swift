import UIKit

protocol AlertViewProtocol {
    func displayAlert(_ model: AlertModelView)
}

extension AlertViewProtocol where Self: UIViewController {
    
    func displayAlert(_ model: AlertModelView) {
        let alertViewController = UIAlertController(title: model.title,
                                                    message: model.message,
                                                    preferredStyle: model.style.uiStyle)
        
        if model.actions.isEmpty {
            alertViewController.addAction(UIAlertAction(
                title: R.string.localizable.alert_button_ok(),
                style: .default,
                handler: nil)
            )
        } else {
            model.actions.forEach { (action) in
                alertViewController.addAction(UIAlertAction(
                    title: action.title,
                    style: action.style.uiStyle,
                    handler: { _ in
                        action.completion?()
                }))
            }
        }
        
        self.present(alertViewController, animated: true, completion: nil)
    }
}
