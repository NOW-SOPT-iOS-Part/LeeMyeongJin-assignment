//
//  CenterViewController.swift
//  tvingProject
//
//  Created by 이명진 on 4/24/24.
//

import UIKit

import SnapKit
import Then

final class CenterViewController: UIViewController {
    
    private let segmentsItem = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UnderlineSegmentedControl(items: segmentsItem)
        return segmentedControl
    }()
    
    private let vc1: UIViewController = {
        let vc = HomeViewController()
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
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        return vc
    }()
    
    var dataViewControllers: [UIViewController] {
        [self.vc1, self.vc2, self.vc3, self.vc4, self.vc5]
    }
    
    var currentPage: Int = 0 {
        didSet {
            // from segmentedControl -> pageViewController 업데이트
            print(oldValue, self.currentPage)
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
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
    
    @objc private func changeValue(control: UISegmentedControl) {
        // 코드로 값을 변경하면 해당 메소드 호출 x
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


final class UnderlineSegmentedControl: UISegmentedControl {

    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white // Underline color
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
        case 1: return 42 // 실시간
        case 2: return 28 // TV프로그램
        case 3: return 24 // 영화
        case 4: return 20 // 파라마운트+
        default: return 0
        }
    }
}
