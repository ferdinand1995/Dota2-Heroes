import Foundation
import NavigationKit

public class HeroDetailCoordinator: BaseCoordinator {

    let router: RouterProtocol
    public init(_ router: RouterProtocol) {
        self.router = router
    }

    public override func start() {

        // prepare the associated view and injecting its viewModel
        let viewModel = HeroDetailVM()
        let viewController = HeroDetailVC()

        router.push(viewController, isAnimated: true, onNavigateBack: isCompleted)
    }
}
