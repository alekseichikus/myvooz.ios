//
//  MainPageViewController.swift
//  USATU6
//
//  Created by aleksei on 30.09.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController: "onePageVC"), self.newVC(viewController: "twoPageVC")]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else{
            return orderedViewControllers.last
        }
        guard orderedViewControllers.count > previousIndex else{
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1

        guard orderedViewControllers.count != nextIndex else{
            return orderedViewControllers.first
        }
        guard orderedViewControllers.count > nextIndex else{
            return nil
        }
        return orderedViewControllers[nextIndex]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
