//
//  SharedAssembly.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard
import FirebaseDynamicLinks

class SharedAssembly: Assembly {
    let sharedContainer = Container()

    func assemble(container: Container) {
        // UIApplicationProtocol
        container.register(UIApplicationProtocol.self) { _ in UIApplication.shared }

        // TopViewControllerProvider
        container.autoregister(TopViewControllerProviderProtocol.self, initializer: TopViewControllerProvider.init)

        // RootNavigator
        container.register(RootNavigatorProtocol.self) { resolver in
            return RootNavigator(
                application: resolver ~> UIApplicationProtocol.self,
                onBoardingStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.onBoarding.name),
                splashScreenStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.splashScreen.name)
            )
        }

        // MARK: Managers
        // Permission Manager
        container.autoregister(PermissionManagerProtocol.self, initializer: PermissionManager.init)

        // Alert presenter
        container.autoregister(AlertPresenterProtocol.self, initializer: AlertPresenter.init)

        // Recorder Manager
        container.autoregister(RecorderManagerProtocol.self, initializer: RecorderManager.init)
        
        // Transcriptor Manager
        container.autoregister(TranscriptorManagerProtocol.self, initializer: TranscriptorManager.init)

        // UserDefault Manager
        container.autoregister(UserDefaultsManagerProtocol.self, initializer: UserDefaultsManager.init)

        // DataValidator
        container.autoregister(DataValidatorProtocol.self, initializer: DataValidator.init)

        // AuthManager
        container.autoregister(AuthManagerProtocol.self, initializer: AuthManager.init)

        // ToastManager
        container.autoregister(ToastManagerProtocol.self, initializer: ToastManager.init)

        // Firebase
        container.register(DynamicLinksProtocol.self) { _ in return DynamicLinks.dynamicLinks() }

        // Date Formatter
        container.autoregister(DateFormatterProtocol.self, initializer: DateFormatterManager.init)

        // Notification Manager
        container.autoregister(NotificationManagerProtocol.self, initializer: NotificationManager.init)

        // DeepLink Manager
        container.autoregister(DeepLinkManagerProtocol.self, initializer: DeepLinkManager.init)

        // DeepLink Router
        container.register(DeepLinkRouterProtocol.self) { resolver in
            return DeepLinkRouter(
                topViewController: resolver ~> (TopViewControllerProviderProtocol.self),
                onboardingStoryboard: resolver ~> (Storyboard.self, name: R.storyboard.onBoarding.name))
        }

        // Error Handler
        container.autoregister(ErrorHandlerProtocol.self, initializer: ErrorHandler.init)

        // DataBase Services
        container.register(CoreDataControllerProtocol.self) { _ in
            return CoreDataController(modelName: "Noty")
        }

        container.autoregister(NoteServiceProtocol.self, initializer: NoteDataService.init)

        // MARK: Storyboards
        // SplashScreen
        container.register(Storyboard.self, name: R.storyboard.splashScreen.name) { _ in
            return SplashScreenStoryboard(sharedContainer: self.sharedContainer, assembly: SplashScreenAsembly())
        }

        // OnBoarding
        container.register(Storyboard.self, name: R.storyboard.onBoarding.name) { _ in
            return OnBoardingStoryboard(sharedContainer: self.sharedContainer, assembly: OnBoardingAssembly())
        }

        // Home
        container.register(Storyboard.self, name: R.storyboard.home.name) { _ in
            return HomeStoryboard(sharedContainer: self.sharedContainer, assembly: HomeAssembly())
        }

        // Alerts
        container.register(Storyboard.self, name: R.storyboard.alerts.name) { _ in
            return AlertsStoryboard(sharedContainer: self.sharedContainer, assembly: AlertsAssemly())
        }
    }
}
