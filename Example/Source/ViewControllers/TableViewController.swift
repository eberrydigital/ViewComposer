//
//  TableViewController.swift
//  Example
//
//  Created by Alexander Cyon on 2017-06-02.
//  Copyright © 2017 Alexander Cyon. All rights reserved.
//

import UIKit

private let cellIdentifier = "cell"
final class TableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = titleForRow(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(at: indexPath)
    }
    
}


private extension TableViewController {
    func setupViews() {
        edgesForExtendedLayout = []
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let router = self.routerForRow(at: indexPath)
        router.push(onto: navigationController)
    }

    func routerForRow(at indexPath: IndexPath) -> NavigationRouter {
        let row = indexPath.row
        switch row {
        case 0:
            return NavigationRouter(NestedStackViewsViewController.self, vanilla: VanillaNestedStackViewsViewController.self)
        case 1:
            return NavigationRouter(LabelsViewController.self, vanilla: VanillaLabelsViewController.self)
        case 2:
            return NavigationRouter(SimpleCustomAttributeViewController.self)
        case 3:
            return NavigationRouter(TriangleViewController.self)
        default:
            fatalError("oh no")
        }
        
    }
    
    func titleForRow(at indexPath: IndexPath) -> String {
        let row = indexPath.row
        switch row {
        case 0:
            return "Nested Stackviews"
        case 1:
            return "Labels"
        case 2:
            return "Custom attribute: FooLabel (simple)"
        case 3:
            return "Custom attribute: TriangleView (advanced)"
        default:
            fatalError("oh no")
        }
    }
}

struct NavigationRouter {
    
    let vanillaViewControllerType: UIViewController.Type?
    let viewComposerViewControllerType: UIViewController.Type
    
    init(_ viewComposer: UIViewController.Type, vanilla: UIViewController.Type? = nil) {
        self.viewComposerViewControllerType = viewComposer
        self.vanillaViewControllerType = vanilla
    }
    
    func push(onto navigationController: UINavigationController?) {
        guard let navigationController = navigationController else { return }
        let viewComposerViewController = viewComposerViewControllerType.init()
        if let vanilla = vanillaViewControllerType {
            let alert = UIAlertController()
            alert.addAction(actionForVanilla(true, viewController: vanilla.init(), navigationController: navigationController))
            alert.addAction(actionForVanilla(false, viewController: viewComposerViewController, navigationController: navigationController))
            navigationController.present(alert, animated: true, completion: nil)
        } else {
            navigationController.pushViewController(viewComposerViewController, animated: true)
        }
    }
    
    
    func actionForVanilla(_ vanilla: Bool, viewController: UIViewController, navigationController: UINavigationController) -> UIAlertAction {
        let title = vanilla ? "Vanilla" : "ViewComposer"
        let action = UIAlertAction(title: title, style: .default) { _ in
            navigationController.pushViewController(viewController, animated: true)
        }
        return action
    }
    
}
