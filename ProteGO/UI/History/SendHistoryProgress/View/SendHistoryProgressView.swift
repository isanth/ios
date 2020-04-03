import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SendHistoryProgressView: UIView {

    private let bannerView = BannerView(leftButtonImage: nil, rightButtonImage: nil)

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        self.addSubviews()
        self.createConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        self.addSubviews([self.bannerView])
    }

    private func createConstraints() {
        bannerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.110 * UIScreen.height)
        }
    }
}
