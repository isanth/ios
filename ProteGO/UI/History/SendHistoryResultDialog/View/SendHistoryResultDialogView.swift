import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SendHistoryResultDialogView: UIView {

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.addSubviews()
        self.createConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
    }

    private func createConstraints() {
    }
}
