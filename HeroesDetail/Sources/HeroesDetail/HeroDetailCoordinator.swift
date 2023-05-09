import Foundation
import NavigationKit

public class HeroDetailCoordinator: BaseCoordinator {

    let router: RouterProtocol
    let data: Data
    public init(_ router: RouterProtocol, _ data: Data) {
        self.router = router
        self.data = data
    }

    public override func start() {

        let viewModel = HeroDetailVM()
        do {
            let selectedHero = try JSONDecoder().decode(HeroDetail.self, from: data)
            viewModel.setSelectedHero(selectedHero)
            let viewController = HeroDetailVC(viewModel)
            router.push(viewController, isAnimated: true, onNavigateBack: isCompleted)
        } catch {
            print("Error: ", error)
        }
    }
}
