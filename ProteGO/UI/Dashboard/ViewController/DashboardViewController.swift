import UIKit
import RxSwift

typealias HistoryRootViewControllerBuilder = () -> HistoryRootViewController

final class DashboardViewController: UIViewController, CustomView {

    typealias ViewClass = DashboardView

    private let viewModel: DashboardViewModelType

    private let disposeBag: DisposeBag = DisposeBag()

    private let historyRootBuilder: HistoryRootViewControllerBuilder

    init(viewModel: DashboardViewModelType, historyRootBuilder: @escaping HistoryRootViewControllerBuilder) {
        self.viewModel = viewModel
        self.historyRootBuilder = historyRootBuilder

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ViewClass()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.bind(view: customView)
        self.bindUIEvents()
    }

    private func bindUIEvents() {
        customView.greenStatusTapMoreEvent.subscribe(onNext: {
            logger.debug("Green more tapped")
        }).disposed(by: disposeBag)

        customView.yellowStatusTapMoreEvent.subscribe(onNext: {
            logger.debug("Yellow more tapped")
        }).disposed(by: disposeBag)

        customView.redStatusContactButtonTappedEvent.subscribe(onNext: {
            logger.debug("Red contact button tapped")
        }).disposed(by: disposeBag)

        customView.greenGeneralRecommendationsTapMoreEvent.subscribe(onNext: {
            logger.debug("Green more recommended tapped")
        }).disposed(by: disposeBag)

        customView.yellowGeneralRecommendationsTapMoreEvent.subscribe(onNext: {
            logger.debug("Yellow more recommended tapped")
        }).disposed(by: disposeBag)

        customView.redGeneralRecommendationsTapMoreEvent.subscribe(onNext: {
            logger.debug("Red more recommended tapped")
        }).disposed(by: disposeBag)

        customView.hamburgerButtonTapEvent.subscribe(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            let historyRootViewController = self.historyRootBuilder()
            historyRootViewController.historyRootViewControllerDelegate = self
            historyRootViewController.modalPresentationStyle = .fullScreen
            self.present(historyRootViewController, animated: true)
        }).disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // TODO: This shouldn't be here, I guess that it's working because of the small delay between calling dispatch
        // and calling contents of this clojure. Without dispatch frame of the internal stack view isn't set
        DispatchQueue.main.async { [weak self] in
            self?.customView.updateScrollViewContentSize()
        }
    }
}

extension DashboardViewController: HistoryRootViewControllerDelegate {
    func sendHistoryFinished(result: Result<Void, Error>) {
        switch result {
        case .success:
            let resultDialog = SendHistoryResultDialogViewController()
            resultDialog.modalPresentationStyle = .overCurrentContext
            self.present(resultDialog, animated: false)
        default:
            break
        }
    }
}
