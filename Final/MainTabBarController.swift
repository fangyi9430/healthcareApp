import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        // Create instances of each view controller
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let historyVC = HistoryViewController()
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 1)

        let profileVC = ViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)

        // Embed each view controller in a UINavigationController
        let homeNav = UINavigationController(rootViewController: homeVC)
        let historyNav = UINavigationController(rootViewController: historyVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        // Add all navigation controllers to the tab bar
        self.viewControllers = [homeNav, historyNav, profileNav]
        
        // Customize tab bar appearance
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .white
        
        // Set initial tab state based on auth status
        updateTabBarAccess(isLoggedIn: Auth.auth().currentUser != nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add authentication listener
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.updateTabBarAccess(isLoggedIn: user != nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove authentication listener
        if let handle = handleAuth {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    private func updateTabBarAccess(isLoggedIn: Bool) {
        // Disable/enable tab bar items
        if let items = tabBar.items {
            // Home tab (index 0)
            items[0].isEnabled = isLoggedIn
            // History tab (index 1)
            items[1].isEnabled = isLoggedIn
        }
        
        // If user logs out and is on a restricted tab, switch to profile tab
        if !isLoggedIn && (selectedIndex == 0 || selectedIndex == 1) {
            selectedIndex = 2 // Switch to profile tab
        }
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let isLoggedIn = Auth.auth().currentUser != nil
        let index = tabBarController.viewControllers?.firstIndex(of: viewController) ?? 0
        
        // Allow access to profile tab (index 2) regardless of login status
        if index == 2 {
            return true
        }
        
        // Only allow access to home and history tabs if logged in
        return isLoggedIn
    }
}
