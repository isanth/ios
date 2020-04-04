import UIKit
import RxSwift

final class SendHistoryResultDialogViewController: UIViewController, CustomView {

    typealias ViewClass = SendHistoryResultDialogView

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ViewClass()
    }
}
