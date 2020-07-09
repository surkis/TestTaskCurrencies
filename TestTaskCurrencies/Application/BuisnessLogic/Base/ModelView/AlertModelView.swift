import Foundation
import UIKit.UIAlert

struct AlertModelView: ModelViewProtocol {
    
    enum Style: Int {
        case actionSheet = 0
        case alert = 1
        
        var uiStyle: UIAlertController.Style {
            switch self {
            case .alert: return .alert
            case .actionSheet: return .actionSheet
            }
        }
    }
    
    var title: String?
    var message: String
    var style: Style
    var actions: [AlertActionModelView]
    
    init(title: String? = nil,
         message: String,
         style: Style = .alert,
         actions: [AlertActionModelView] = []) {
        self.title = title
        self.message = message
        self.style = style
        self.actions = actions
    }
    
    init(title: String? = nil,
         message: String,
         style: Style = .alert,
         okButton: String = R.string.localizable.alert_button_ok(),
         completion: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.style = style
        self.actions = [AlertActionModelView(title: okButton, style: .default, completion: completion)]
    }
    
}


struct AlertActionModelView: ModelViewProtocol {
    
    enum Style: Int {
        case `default` = 0
        case cancel = 1
        case destructive = 2
        
        var uiStyle: UIAlertAction.Style {
            switch self {
            case .`default`: return .default
            case .cancel: return .cancel
            case .destructive: return.destructive
            }
        }
    }
    
    var title: String
    var style: Style
    var completion: (() -> Void)?
}
