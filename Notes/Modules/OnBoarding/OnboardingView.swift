//
//  OnBoardingView.swift
//  Notes
//
//  Created by Руслан Канжарбеков on 05.03.2024.
//

import UIKit
import SnapKit

protocol OnboardingViewProtocol {
    func successTitles(titles: [String])
    func successSubtitles(subtitles: [String])
    func successImages(images: [UIImage])
}

class OnboardingView: UIViewController {
    
    var currentPage = 0
    
    private var controller: OnboardingControllerProtocol?
    
    private var titles: [String] = []
    private var subtitles: [String] = []
    private var images: [UIImage] = []
    
    private lazy var onBoardingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardCell.self, forCellWithReuseIdentifier: OnBoardCell.reuseID)
        view.dataSource = self
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .gray
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.tintColor = .systemRed
        view.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        return view
    }()
    
    
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 15
        view.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        controller = OnboardingController(view: self)
        controller?.onGetImages()
        controller?.onGetSubtitles()
        controller?.onGetTitles()
    }
    
    @objc func skipTapped() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        navigationController?.pushViewController(HomeView(), animated: true)
    }
    
    @objc func nextTapped() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        if currentPage == 2 {
            navigationController?.pushViewController(HomeView(), animated: true)
        } else {
            onBoardingCollectionView.isPagingEnabled = false
            onBoardingCollectionView.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
            onBoardingCollectionView.isPagingEnabled = true
        }
    }
    
    private func setupLayout() {
        view.addSubview(onBoardingCollectionView)
        onBoardingCollectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-120)
            make.centerX.equalToSuperview()
        }
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(50)
            make.left.equalTo(16)
            make.width.equalTo(160)
            make.height.equalTo(45)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.right.equalTo(-16)
            make.width.equalTo(160)
            make.height.equalTo(45)
        }
    }
}

extension OnboardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardCell.reuseID, for: indexPath) as! OnBoardCell
        
        cell.setup(title: titles[indexPath.row])
        cell.setup(subtitle: subtitles[indexPath.row])
        cell.setup(image: images[indexPath.row])
        
        return cell
    }
}

extension OnboardingView: UICollectionViewDelegate {
    
}

extension OnboardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contenOffset = scrollView.contentOffset.x
        let page = (contenOffset / view.frame.width)
        
        switch page {
        case 0.0:
            pageControl.currentPage = 0
            currentPage = 0
        case 1.0:
            pageControl.currentPage = 1
            currentPage = 1
        case 2.0:
            pageControl.currentPage = 2
            currentPage = 2
        default:
            ()
        }
    }
}

extension OnboardingView: OnboardingViewProtocol {
    func successTitles(titles: [String]) {
        self.titles = titles
        onBoardingCollectionView.reloadData()
    }
    
    func successSubtitles(subtitles: [String]) {
        self.subtitles = subtitles
        onBoardingCollectionView.reloadData()
    }
    
    func successImages(images: [UIImage]) {
        self.images = images
        onBoardingCollectionView.reloadData()
    }
}

