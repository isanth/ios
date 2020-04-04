import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SendHistoryResultDialogView: UIView {

    var closeButtonTapped: ControlEvent<Void> {
        return closeButton.rx.tap
    }

//    var footerLabelTapped: ControlEvent<Void> {
//        return closeButton.rx.tap
//    }

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.poppinsBold(24).font
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
          let label = UILabel(frame: .zero)
          label.font = Fonts.poppinsBold(24).font
          label.textColor = .white
          label.numberOfLines = 0
          label.textAlignment = .center
          return label
      }()

    private let footerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.poppinsBold(24).font
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.closeIcon, for: .normal)
        return button
    }()

    init(success: Bool) {
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
