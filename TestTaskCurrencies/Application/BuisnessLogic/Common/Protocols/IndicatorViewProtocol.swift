import UIKit
import NVActivityIndicatorView

protocol IndicatorViewProtocol {
    func displayLoading(isShow: Bool)
}

protocol NVIndicatorViewProtocol: IndicatorViewProtocol, NVActivityIndicatorViewable {}


extension NVIndicatorViewProtocol where Self: UIViewController {
    
    func displayLoading(isShow: Bool) {
        if isShow {
            startAnimating(type: .ballSpinFadeLoader, color: .white,
                           minimumDisplayTime: 3, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7285423801), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        } else {
            stopAnimating()
        }
    }
}
