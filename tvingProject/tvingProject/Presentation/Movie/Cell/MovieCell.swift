//
//  MovieCell.swift
//  tvingProject
//
//  Created by 이명진 on 5/8/24.
//

import UIKit

import SnapKit
import Then

final class MovieCell: UICollectionViewCell {
    
    // MARK: - UIComponents
    
    let rankLabel = LabelFactory.build(text: "랭킹 1위", font: .pretendardFont(weight: 800, size: 20))
    let movieName = LabelFactory.build(text: "범죄 도시", font: .pretendardFont(weight: 700, size: 15)).then {
        $0.numberOfLines = 2
    }
    let movieOpenDate = LabelFactory.build(text: "개봉일 ", font: .pretendardFont(weight: 600, size: 14))
    let acumulativeNumberOfAudience = LabelFactory.build(text: "870만", font: .pretendardFont(weight: 500, size: 15))
    
    private lazy var movieVStackView = UIStackView(
        arrangedSubviews: [
            rankLabel,
            movieName,
            movieOpenDate,
            acumulativeNumberOfAudience
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fillProportionally
        $0.alignment = .leading
    }
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .gray
    }
    
    private func setHierarchy() {
        contentView.addSubview(movieVStackView)
    }
    
    private func setLayout() {
        movieVStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func bind(model: DailyBoxOfficeList) {
        self.rankLabel.text = "랭킹" + model.rank + "위"
        self.movieName.text = model.movieNm
        self.movieOpenDate.text = "개봉일: \(model.openDt)"
        
        let changeFormat = Formatter.formatNumberKoreanStyle(model.audiAcc)
        
        self.acumulativeNumberOfAudience.text = "누적 관객수: \(changeFormat ?? "")"
    }
}
