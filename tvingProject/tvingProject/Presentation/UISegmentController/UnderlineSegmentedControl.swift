//
//  UnderlineSegmentedControl.swift
//  tvingProject
//
//  Created by 이명진 on 4/25/24.
//

import UIKit

final class UnderlineSegmentedControl: UISegmentedControl {
    
    // MARK: - UIComponent
    
    // segment 와 같이 움직일 underLine 생성
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        addSubview(view)
        return view
    }()
    
    
    // MARK: - Life Cycles
    
    // 주로 이 init은 인스턴스의 위치와 크기를 설정할때 생성
    // 특히 segment의 배경을 제거하기 위해 사용
    override init(frame: CGRect) {
        super.init(frame: frame)
        segmentInit()
    }
    
    // 주로 이 init은 segment의 items을 받을 때 생성
    override init(items: [Any]?) {
        super.init(items: items)
        segmentInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 레이아웃이 변경되면 항상 호출되는 메서드 라고 생각하면 됌
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUnderLine()
    }
    
    
    // MARK: - Methods
    
    private func segmentInit() {
        self.removeBackgroundAndDivider()
        self.apportionsSegmentWidthsByContent = true
    }
    
    private func removeBackgroundAndDivider() {
        let clearImage = UIImage()
        // 기본 segment 배경 제거
        setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        // 선택 segment 배경 제거
        setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
        // 하이라이트 segment 배경 제거
        setBackgroundImage(clearImage, for: .highlighted, barMetrics: .default)
        // segment 로 나눠져 있는 divider 제거
        setDividerImage(clearImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func setUnderLine() {
        // 현재 seg의 위치를 index로 반환
        let segmentIndex = selectedSegmentIndex
        // 인덱스의 title이 있는지 확인
        if let titleLabel = self.titleForSegment(at: segmentIndex) {
            // 현재 타이블을 size 15로 NSAttributedString 으로 리턴
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15)]
            // 그래야 titleLabel 의 size를 알 수 있음
            let textWidth = titleLabel.size(withAttributes: attributes).width
            // segment의 전체 width 를 segment의 갯수로 나눔
            let segmentWidth = self.bounds.width / CGFloat(numberOfSegments)
            // 해당 seg 위치를 알맞게 조정하기 위해 하드 코딩
            let adjustment = self.getAdjustment(for: segmentIndex)
            
            // underLine이 시작하는 X 좌표를 계산 ->
            // 현재 segWidth 에서 현재 seg index를 곱하고 + (segWidth 에서 텍스트 width를 뺀 후 2로 나눔)
            // 그리고 하드 코딩한 값을 빼면 알맞은 값이 나옴
            // 이 부분은 그림 그려보면 적절하게 공식이 나오는 걸 알 수 있다.
            let textStartX = (segmentWidth * CGFloat(segmentIndex)) + (segmentWidth - textWidth) / 2 - adjustment
            
            
            //            print("titleLabel= \(titleLabel),\n attributes = \(attributes), \n textWidth = \(textWidth), \n segmentWidth = \(segmentWidth), \n adjustment = \(adjustment),\n  textStartX = \(textStartX)")
            //  픽셀 값이 내가 원하는 값이 나오는 지 확인하는 메서드 입니다.
            
            // underLine 위치를 frame으로 계산하여 애니메이션 효과까지 주면 우리가 원하는 애니메이션 처럼 움직이게 됌
            UIView.animate(withDuration: 0.2) {
                
                // x 좌표는 위에 힘들게 계산 하였음
                // y 좌표는 조금만 생각하면 쉽게 계산 가능
                // width 는 textWidth에 맞게 하면됌
                // UnderLine의 height는 항상 고정 사실 상수로 프로퍼티에 선언해도 ㄱㅊ
                self.underlineView.frame = CGRect(x: textStartX, y: self.bounds.height - 3.0, width: textWidth, height: 3.0)
            }
        }
    }
    
    private func getAdjustment(for index: Int) -> CGFloat {
        /*
         각 세그먼트에 대한 조정값 설정
         하드 코딩이라 좋은건 아님
         이 함수만 고치면 해당 클래스 재사용 가능
         확장성 개똥인 코드 ... (추후 리팩 할게요)
         */
        switch index {
        case 0: return 20 // 홈
        case 1: return 43 // 실시간
        case 2: return 30 // TV프로그램
        case 3: return 25 // 영화
        case 4: return 20 // 파라마운트+
        default: return 0
        }
    }
}
