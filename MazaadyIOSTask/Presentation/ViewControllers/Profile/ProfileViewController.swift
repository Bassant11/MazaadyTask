//
//  ProfileViewController.swift
//  MazaadyIOSTask
//
//  Created by Mac on 11/04/2025.
//

import UIKit
import Swinject
import RxSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userFolloersNumber: UILabel!
    @IBOutlet weak var userFollowingNumber: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var adsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var adsTableView: UITableView!
    @IBOutlet weak var tagsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var profileTabsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var scrollVIew: UIScrollView!
    
    private var indicatorLine = UIView()
    private var viewModel: ProfileViewModel?
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()

    var tags = ["All","Car","Bags","Jackets","Scarfes","Shoes","Mobiles"]
    var prosuctsHeight = [true,false,false,true,false,true,true,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getData()
        CollectionViewSetup()
        setupSegmentedControlIndicator()
        segmentedControlSetup()

    }
    override func viewWillAppear(_ animated: Bool) {
        userName.textAlignment = .center
        userEmail.textAlignment = .center
        userLocation.textAlignment = .center
    }
    func setup()
    {
        viewModel = AppDelegate.container.resolve(ProfileViewModel.self)
        searchBarTextField.placeholder = NSLocalizedString("Search", comment: "")
        scrollVIew.refreshControl = refreshControl
         refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
   
       
    }
    @objc private func refreshData() {
        viewModel?.loadAllData(forceRefresh: true)
    }
    func CollectionViewSetup()
    {
        searchBarView.AddBorderToSearchView()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        adsTableView.delegate = self
        adsTableView.dataSource = self
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        
        productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productsCollectionView.register  (UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        
        adsTableView.translatesAutoresizingMaskIntoConstraints = false
        adsTableView.register(UINib(nibName: "AdsTableViewCell", bundle: nil), forCellReuseIdentifier: "AdsCell")

        tagsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionView.register  (UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagsCell")
        
//
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        layout.itemSize = UICollectionViewFlowLayout.automaticSize

        
        let layout = PinterestLayout()
        layout.numberOfColumns = 3
        layout.delegate = self
       
        
        productsCollectionView.collectionViewLayout = layout
        productsCollectionView.layoutIfNeeded()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ProfileTabsAction(profileTabsSegmentedControl)
        productsCollectionViewHeight.constant = productsCollectionView.contentSize.height
        adsTableViewHeight.constant = adsTableView.contentSize.height
        tagsCollectionViewHeight.constant = tagsCollectionView.contentSize.height
        userImage.layer.cornerRadius = 10
    
    }
    
    
    @IBAction func ProfileTabsAction(_ sender: Any) {

        let segmentCount = CGFloat(profileTabsSegmentedControl.numberOfSegments)
        let selectedIndex = profileTabsSegmentedControl.selectedSegmentIndex
        let segmentWidth = profileTabsSegmentedControl.frame.width / segmentCount
        
        let isRTL = L102Language.currentAppleLanguage() == "ar"
        let adjustedIndex = isRTL ? Int(segmentCount - 1) - selectedIndex : selectedIndex

        UIView.animate(withDuration: 0.25) {
            self.indicatorLine.transform = CGAffineTransform(translationX: segmentWidth * CGFloat(adjustedIndex), y: 0)
        }
        
    }
    
    
    @IBAction func languageSettings(_ sender: Any) {
        self.presentLanguageBottomSheet()
    }
    
    @IBAction func searchBarButtonAction(_ sender: Any) {
        filterProducts()
    }
    
    func getData()
    {
        viewModel?.error
            .subscribe(onNext: { [weak self] error in
                if let error = error {
                    self?.showError(error.localizedDescription)
                }
            })
        
            .disposed(by: disposeBag)
        viewModel?.isLoading
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isLoading in
                if isLoading {
                    self?.showLoading()  // Show loading indicator when data is loading
                } else {
                    self?.hideLoading()  // Hide loading indicator when data loading is finished
                    self?.refreshControl.endRefreshing()  // End the refresh control animation
                }
            }
            .disposed(by: disposeBag)
        viewModel?.products
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isLoading in
                DispatchQueue.main.async {
                    self?.productsCollectionView.reloadData()
                    self?.productsCollectionView.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
        viewModel?.Ads
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isLoading in
                DispatchQueue.main.async {
                    self?.adsTableView.reloadData()
                    self?.adsTableView.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
        viewModel?.tags
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isLoading in
                DispatchQueue.main.async {
                    self?.tagsCollectionView.reloadData()
                    self?.tagsCollectionView.layoutIfNeeded()
                    //   self?.tagsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: COREVIDEO_FALSE, scrollPosition: .left)
                }
            }
            .disposed(by: disposeBag)
        viewModel?.userInfo
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isLoading in
                DispatchQueue.main.async {
                    self?.loadUserInfo()
                }
            }
            .disposed(by: disposeBag)
        viewModel?.loadAllData()
        
        
    }
    func loadUserInfo()
    {
        userName.text = viewModel?.userInfo.value.name ?? ""
        userFolloersNumber.text = String(self.viewModel?.userInfo.value.followersCount ?? 0)
        userFollowingNumber.text = String(self.viewModel?.userInfo.value.followingCount ?? 0)
        loadImage(from:self.viewModel?.userInfo.value.image ?? "" , into: self.userImage)
        
    }
    private func filterProducts() {
        guard let products = viewModel?.products.value else { return }
        let query = self.searchBarTextField.text ?? ""

        let filtered = query.isEmpty
            ? products
            : products.filter { $0.name.lowercased().contains(query.lowercased()) }

        viewModel?.products.accept(filtered)
    }
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
extension ProfileViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        var cellHeight: CGFloat = 180

          guard let products = viewModel?.products.value, products.indices.contains(indexPath.row) else {
              return cellHeight
          }

          if products[indexPath.row].offer != nil {
              cellHeight += 50
          }

          if products[indexPath.row].endDate != nil {
              cellHeight += 70
          }

          return cellHeight
    }
}

extension ProfileViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.Ads.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdsCell", for: indexPath) as!  AdsTableViewCell
        if let ads = viewModel?.Ads.value, ads.indices.contains(indexPath.row) {
            cell.configureCell(with: ads[indexPath.row])
        }
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productsCollectionView
        {
            return viewModel?.products.value.count ?? 0
        }
    
        else
        {
            return viewModel?.tags.value.count ?? 0

        }

        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as!  ProductCollectionViewCell
            if let products = viewModel?.products.value, products.indices.contains(indexPath.row) {
                cell.cellConfigure(product: products[indexPath.row])
            }
            return cell
        }
        else
        {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as!  TagsCollectionViewCell
            if let tags = viewModel?.tags.value, tags.indices.contains(indexPath.row) {
                cell.configureCell(with: tags[indexPath.row])
            }
            return cell
            
        }

    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productsCollectionView
        {
            if indexPath.item == 1 ||  indexPath.item == 4 {
                return CGSize(width: (self.productsCollectionView.frame.width / 3) - 10 , height: 140)
                
            }
            else
                    {
                return CGSize(width: (self.productsCollectionView.frame.width / 3) - 10, height: 200)
            }
            
            
        }
        else
        {
            return CGSize(width: 90, height: 30)


        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

            return 8.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:4, bottom: 0, right: 4)
    }
            
    
}

extension ProfileViewController
{
    
     func presentLanguageBottomSheet() {
         let sheetVC = ProfileSettingsViewController()
        
        if let sheet = sheetVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in return 300 } // 300 points height
                ]
            }
            else
            {
                sheet.detents = [.medium()] // Choose height
            }
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
        }
        
        present(sheetVC, animated: true, completion: nil)
    }
    
    func segmentedControlSetup() {
        let normalColor = UIColor.systemGray
        let selectedColor = UIColor.labelPink

        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: normalColor,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]

        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedColor,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        for index in 0..<profileTabsSegmentedControl.numberOfSegments {
              if let originalTitle = profileTabsSegmentedControl.titleForSegment(at: index) {
                  let localizedTitle = NSLocalizedString(originalTitle, comment: "")
                  profileTabsSegmentedControl.setTitle(localizedTitle, forSegmentAt: index)
              }
          }
        profileTabsSegmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        profileTabsSegmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        profileTabsSegmentedControl.backgroundColor = .clear
        let clearImage = UIImage()
        profileTabsSegmentedControl.setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        profileTabsSegmentedControl.setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
        profileTabsSegmentedControl.setBackgroundImage(clearImage, for: .highlighted, barMetrics: .default)
        profileTabsSegmentedControl.setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        if L102Language.currentAppleLanguage() == "ar"  {
              profileTabsSegmentedControl.semanticContentAttribute = .forceRightToLeft
          } else {
              profileTabsSegmentedControl.semanticContentAttribute = .forceLeftToRight
          }

    }
    func setupSegmentedControlIndicator() {
        indicatorLine = UIView()
        indicatorLine.backgroundColor = UIColor.labelPink
        indicatorLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicatorLine)

        // Set initial position (set initial position based on the selected segment)
        NSLayoutConstraint.activate([
            indicatorLine.topAnchor.constraint(equalTo: profileTabsSegmentedControl.bottomAnchor),
            indicatorLine.heightAnchor.constraint(equalToConstant: 2),
            indicatorLine.widthAnchor.constraint(equalTo: profileTabsSegmentedControl.widthAnchor, multiplier: 1.0 / CGFloat(profileTabsSegmentedControl.numberOfSegments)),
            L102Language.currentAppleLanguage() == "ar" ? indicatorLine.trailingAnchor.constraint(equalTo: profileTabsSegmentedControl.trailingAnchor) : indicatorLine.leadingAnchor.constraint(equalTo: profileTabsSegmentedControl.leadingAnchor)
        ])
    }
    func updateIndicatorPosition(animated: Bool) {
        let selectedIndex = CGFloat(profileTabsSegmentedControl.selectedSegmentIndex)
        let segmentWidth = profileTabsSegmentedControl.frame.width / CGFloat(profileTabsSegmentedControl.numberOfSegments)

        // Adjust the selected index for RTL (Arabic)
        let adjustedSelectedIndex: CGFloat
        if L102Language.currentAppleLanguage() == "ar" {
            // Reverse the index for RTL
            adjustedSelectedIndex = CGFloat(profileTabsSegmentedControl.numberOfSegments - 1 - profileTabsSegmentedControl.selectedSegmentIndex)
        } else {
            // For LTR, keep the index as is
            adjustedSelectedIndex = selectedIndex
        }

        // Calculate the X position of the indicator line based on the adjusted index
        let segmentX = profileTabsSegmentedControl.frame.minX + (segmentWidth * adjustedSelectedIndex)
        let segmentY = profileTabsSegmentedControl.frame.maxY

        let lineFrame = CGRect(x: segmentX, y: segmentY, width: segmentWidth, height: 2)

        // Animate indicator position change if needed
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.indicatorLine.frame = lineFrame
            }
        } else {
            indicatorLine.frame = lineFrame
        }
    }
    
    
}
