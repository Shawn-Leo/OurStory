//
//  MenuViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/3.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  This file defines the view controller for side menu
//

import UIKit

enum MenuType: Int {
    case profile
    case home
    case setting
    case logout
}

class MenuViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("\(menuType)")
            self?.didTapMenuType(menuType)
        }
    }
    
    private func didTapMenuType(_ menuType: MenuType) {
        print(menuType)
        self.transitionToNewMenuContent(menuType)
    }
    
    
    // This function make transition to new page accoding to the selection content of side menu
    private func transitionToNewMenuContent(_ menuType: MenuType){
        // Get ahold current viewcontroller in the nearest navigation controller's view controllers
        guard let nav = UIViewController.currentViewController() else { return }
        switch menuType {
        case .logout:
            guard let lvc = self.storyboard?.instantiateViewController(withIdentifier: "LoginPageViewController") as? LoginPageViewController else { return }
            lvc.modalPresentationStyle = .fullScreen
            LoginPageViewController.isAuthenticated = false
            nav.present(lvc, animated: true)
        default:
            break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
