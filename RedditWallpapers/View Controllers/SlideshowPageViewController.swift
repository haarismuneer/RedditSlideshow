//
//  SlideshowPageViewController.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import Pageboy

class SlideshowPageViewController: PageboyViewController {

    var orderedViewControllers: [SlideViewController]!
    var timer: Timer?
    var intervalLength: Double = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dataSource = self
        self.delegate = self
        self.transition = Transition(style: .fade, duration: 1.0)
        self.isInfiniteScrollEnabled = true
        
        
        
        runTimer(numberOfSeconds: intervalLength)
        
        

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
        scrollToPage(Page.next, animated: true)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        let currentPage = self.orderedViewControllers[self.currentIndex!]
        
        for press in presses {
            if (press.type == .select) {
                if currentPage.titleLabel.alpha == 0 {
                    currentPage.showTitleLabel()
                }
                else {
                    currentPage.hideTitleLabel()
                }
            }
            else {
                super.pressesEnded(presses, with: event)
            }
        }
    }

}

extension SlideshowPageViewController: PageboyViewControllerDelegate, PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return self.orderedViewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return self.orderedViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        stopTimer()
        runTimer(numberOfSeconds: intervalLength)
    }
    
    
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! SlideViewController) else {
//            return nil
//        }
//
//        let previousIndex = viewControllerIndex - 1
//
//        guard previousIndex >= 0 else {
//            return orderedViewControllers.last
//        }
//
//        guard orderedViewControllers.count > previousIndex else {
//            return nil
//        }
//
//        return orderedViewControllers[previousIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController,
//                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = orderedViewControllers.index(of: viewController as! SlideViewController) else {
//            return nil
//        }
//
//        let nextIndex = viewControllerIndex + 1
//        let orderedViewControllersCount = orderedViewControllers.count
//
//        guard orderedViewControllersCount != nextIndex else {
//            return orderedViewControllers.first
//        }
//
//        guard orderedViewControllersCount > nextIndex else {
//            return nil
//        }
//
//        return orderedViewControllers[nextIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if completed {
//            stopTimer()
//            runTimer(numberOfSeconds: intervalLength)
//        }
//    }
    
    
}
