//
//  SlideshowPageViewController.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit

class SlideshowPageViewController: UIPageViewController {

    var orderedViewControllers: [SlideViewController]!
    var timer: Timer?
    var intervalLength: Double = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        runTimer(numberOfSeconds: intervalLength)
        
//        for vc in self.orderedViewControllers {
//            let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(registerSwipe))
//            rightSwipeRecognizer.direction = .right
//            vc.view.addGestureRecognizer(rightSwipeRecognizer)
//
//            let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(registerSwipe))
//            leftSwipeRecognizer.direction = .left
//            vc.view.addGestureRecognizer(leftSwipeRecognizer)
//        }

    }

    
    func runTimer(numberOfSeconds: Double) {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: numberOfSeconds, target: self, selector: #selector(changeSlideVC), userInfo: nil, repeats: true)
        }
        
    }
    
    func stopTimer() {
        
        if timer != nil {
            timer?.invalidate()
            
            timer = nil
            
        }
    }
    
    @objc func changeSlideVC() {
        if let nextVC = pageViewController(self, viewControllerAfter: (self.viewControllers?.first)!) {
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func makeGestureRecognizers() {
        
    }
    
    
    


}

extension SlideshowPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! SlideViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! SlideViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            stopTimer()
            runTimer(numberOfSeconds: intervalLength)
        }
    }
    
    
}
