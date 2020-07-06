import UIKit

protocol ItemCurrencyView: BaseViewModelCellType {
}

class ItemCurrencyTableViewCell: BaseViewTableViewCell, ItemCurrencyView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setup(viewModel: ModelViewProtocol) {
        guard let viewModel = viewModel as? ItemCurrencyView else {
            return
        }
        
    }
}
