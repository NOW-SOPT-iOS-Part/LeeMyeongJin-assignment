//
//  CenterViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/24/24.
//

import UIKit

import SnapKit
import Then

protocol HomeViewScrollDelegate: AnyObject {
    func homeViewDidScroll(yOffset: CGFloat)
}

final class CenterViewController: UIViewController {
    
    private let segmentsItem = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UnderlineSegmentedControl(items: segmentsItem)
        return segmentedControl
    }()
    
    private lazy var vc1: UIViewController = {
        let vc = HomeViewController()
        vc.scrollDelegate = self
        return vc
    }()
    
    private let vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        return vc
    }()
    
    private let vc3: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        return vc
    }()
    
    private let vc4: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .gray3
        return vc
    }()
    
    private let vc5: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemPink
        return vc
    }()
    
    // 큰 pageViewController 설정
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        return vc
    }()
    
    // 페이지 뷰컨에 담아 있는 ViewController 설정
    var dataViewControllers: [UIViewController] {
        [self.vc1, self.vc2, self.vc3, self.vc4, self.vc5]
    }
    
    var currentPage: Int = 0 {
        didSet {
            // 인덱스 1 -> 2 이동 또는 반대 4 -> 3 이동
            print(oldValue, self.currentPage)
            
            // 1(oldValue) -> 2 이동 할때는 forword, 4(oldValue) -> 3 이동 할때는 reverse
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            
            // 현재 페이지 뷰컨을 currentPage에 따라 그 ViewController로 이동
            self.pageViewController.setViewControllers(
                [dataViewControllers[self.currentPage]],
                direction: direction,
                animated: true,
                completion: nil
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setDelegate()
        
        
    }
    
    private func setHierarchy() {
        
        self.view.addSubview(pageViewController.view)
        pageViewController.view.addSubview(segmentedControl)
    }
    
    private func setLayout() {
        segmentedControl.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(44)
            $0.height.equalTo(50)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(4)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-4)
            $0.bottom.equalTo(self.view.snp.bottom).offset(-4)
            $0.top.equalToSuperview()
        }
        
        self.segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                .font: UIFont.pretendardFont(weight: 400, size: 15)
            ],
            for: .normal
        )
        
        self.segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                .font: UIFont.pretendardFont(weight: 600, size: 15)
            ],
            for: .selected
        )
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.changeValue(control: self.segmentedControl)
    }
    
    private func setDelegate() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    @objc private func changeValue(control: UISegmentedControl) {
        // currentPage 의 값을 selectedSegmentIndex에 의해 변경되는걸 observing
        self.currentPage = control.selectedSegmentIndex
    }
}

extension CenterViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        return dataViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController), index + 1 < dataViewControllers.count else { return nil }
        return dataViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let viewController = pageViewController.viewControllers?.first, let index = dataViewControllers.firstIndex(of: viewController) {
            currentPage = index
            segmentedControl.selectedSegmentIndex = index
        }
    }
}

extension CenterViewController: HomeViewScrollDelegate {
    
    func homeViewDidScroll(yOffset: CGFloat) {
        let segmentedControlHeight = 50
        // segmentedControl의 기준 위치 설정
        let safeAreaTop = view.safeAreaInsets.top
        let initialSegmentedControlTop = safeAreaTop + 20
        
        // 스크롤 위치에 따른 처리
        if yOffset >= initialSegmentedControlTop - safeAreaTop {
            // 스크롤이 segmentedControl을 상단에 도달하거나 그 이상으로 올라갔을 때
            if segmentedControl.superview != view {
                // segmentedControl이 상단에 고정되도록 조정
                segmentedControl.removeFromSuperview()
                view.addSubview(segmentedControl)
                
                self.segmentedControl.snp.remakeConstraints {
                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
                    $0.height.equalTo(segmentedControlHeight)
                }
            }
        } else {
            // 스크롤이 아래로 내려가 segmentedControl이 원래 위치로 돌아갈 때
            if segmentedControl.superview != pageViewController.view {
                segmentedControl.removeFromSuperview()
                pageViewController.view.addSubview(segmentedControl)
                
                self.segmentedControl.snp.remakeConstraints {
                    $0.horizontalEdges.equalToSuperview()
                    $0.top.equalTo(self.pageViewController.view.safeAreaLayoutGuide.snp.top).offset(44)
                    $0.height.equalTo(segmentedControlHeight)
                }
            }
        }
    }
}



final class UnderlineSegmentedControl: UISegmentedControl {
    
    // segment 와 같이 움직일 underLine 생성
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.removeBackgroundAndDivider()
        self.apportionsSegmentWidthsByContent = true
    }
    
    private func removeBackgroundAndDivider() {
        let clearImage = UIImage()
        setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
        setBackgroundImage(clearImage, for: .highlighted, barMetrics: .default)
        setDividerImage(clearImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderlineViewPosition()
    }
    
    private func updateUnderlineViewPosition() {
        let segmentIndex = selectedSegmentIndex
        if let titleLabel = self.titleForSegment(at: segmentIndex) {
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15)]
            let textWidth = titleLabel.size(withAttributes: attributes).width
            let segmentWidth = self.bounds.width / CGFloat(numberOfSegments)
            let adjustment = getAdjustment(for: segmentIndex)
            let textStartX = (segmentWidth * CGFloat(segmentIndex)) + (segmentWidth - textWidth) / 2 - adjustment
            
            UIView.animate(withDuration: 0.25) {
                self.underlineView.frame = CGRect(x: textStartX, y: self.bounds.height - 3.0, width: textWidth, height: 3.0)
            }
        }
    }
    
    private func getAdjustment(for index: Int) -> CGFloat {
        // 각 세그먼트에 대한 조정값 설정
        switch index {
        case 0: return 20 // 홈
        case 1: return 44 // 실시간
        case 2: return 30 // TV프로그램
        case 3: return 25 // 영화
        case 4: return 20 // 파라마운트+
        default: return 0
        }
    }
}
