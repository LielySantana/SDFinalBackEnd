//
//  LoginPageVC.swift
//  StoryDownloader
//
//  Created by krunal on 22/11/22.
//

import UIKit

class LoginPageVC: UIPageViewController {
    
    lazy var vcList:[UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstVC = storyboard.instantiateViewController(identifier: "LoginFirstVC")
        let secondVC = storyboard.instantiateViewController(identifier: "LoginSecondVC")
        let thirdVC = storyboard.instantiateViewController(identifier: "LoginThirdVC")
        return [firstVC, secondVC, thirdVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        if let vc = vcList.first{
            self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
        
        
        
    }
}


extension LoginPageVC : UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcList.lastIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        guard previousIndex >= 0 else {return nil}
        guard previousIndex < vcList.count else {return nil}
        return vcList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcList.lastIndex(of: viewController) else { return nil }
        let previousIndex = index + 1
        guard previousIndex >= 0 else {return nil}
        guard previousIndex < vcList.count else {return nil}
        return vcList[previousIndex]
    }
}
