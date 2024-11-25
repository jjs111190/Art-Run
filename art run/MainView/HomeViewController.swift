import UIKit
import Firebase
import FirebaseCore

class HomeViewController: UIViewController {
    var onLogout: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupUI()
        checkUserSessionAndLogout()
    }
    
    private func checkUserSessionAndLogout() {
        let isSessionExpired = true // 세션 만료 조건 확인 (예시)
        if isSessionExpired {
            onLogout?()
        }
    }
    
    private func setupUI() {
        // **헤더 섹션**
        let headerLabel = UILabel()
        let headerText = "Home"
        let attributedText = NSMutableAttributedString(string: headerText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: 0, length: 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 1, length: headerText.count - 1))
        headerLabel.attributedText = attributedText
        headerLabel.font = UIFont.boldSystemFont(ofSize: 40)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "가벼운 러닝으로 상쾌한 하루를 시작해보세요"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = UIColor.gray
        
        // **사용자 정보 카드**
        let cardView = createCardView()
        
        // **캘린더 섹션**
        let calendarView = createCalendarView()
        
        // **하단 탭바**
        let tabBarView = createTabBar()
        
        // **뷰 계층 추가**
        view.addSubview(headerLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(cardView)
        view.addSubview(calendarView)
        view.addSubview(tabBarView)
        
        // **Auto Layout 설정**
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 헤더 섹션 레이아웃
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            
            // 카드 뷰 레이아웃
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            cardView.heightAnchor.constraint(equalToConstant: 220), // 높이 조정
            
            // 캘린더 섹션 레이아웃
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            
            // 하단 탭바 레이아웃
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func createCardView() -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 10
        
        // 사용자 이름 및 환영 메시지 레이블
        let userNameLabel = UILabel()
        userNameLabel.text = "User Name"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        userNameLabel.textColor = .black
        
        let userInfoLabel = UILabel()
        userInfoLabel.text = "Welcome back!"
        userInfoLabel.font = UIFont.systemFont(ofSize: 14)
        userInfoLabel.textColor = .gray
        
        // 사용자 정보 스택뷰
        let userStackView = UIStackView(arrangedSubviews: [userNameLabel, userInfoLabel])
        userStackView.axis = .vertical
        userStackView.alignment = .leading
        userStackView.spacing = 4
        
        // 러닝, 칼로리, 심박수 정보 스택뷰
        let runningStack = createInfoStack(iconName: "figure.run", title: "Running", value: "5000km", color: UIColor.systemGreen)
        let caloriesStack = createInfoStack(iconName: "flame.fill", title: "Calories burned", value: "2034kcal", color: UIColor.systemRed)
        let heartRateStack = createInfoStack(iconName: "heart.fill", title: "Heart rate", value: "130BPM", color: UIColor.systemOrange)
        
        let infoStackView = UIStackView(arrangedSubviews: [runningStack, caloriesStack, heartRateStack])
        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 16
        
        // 전체 카드 스택뷰 (사용자 정보 + 러닝 정보)
        let cardStackView = UIStackView(arrangedSubviews: [userStackView, infoStackView])
        cardStackView.axis = .vertical
        cardStackView.spacing = 16
        
        cardView.addSubview(cardStackView)
        
        // Auto Layout 설정
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        // Auto Layout 설정 (수정)
        NSLayoutConstraint.activate([
            cardStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            cardStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            cardStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20), // 여백 증가
            cardStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20) // 여백 증가
        ])
        
        return cardView
    }
    
    private func createInfoStack(iconName: String, title: String, value: String, color: UIColor) -> UIStackView {
        // 링 뷰 생성
        let ringView = UIView()
        ringView.backgroundColor = .clear
        ringView.layer.cornerRadius = 40 // 링 반지름
        ringView.layer.borderWidth = 10 // 링 두께
        ringView.layer.borderColor = color.cgColor
        ringView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ringView.widthAnchor.constraint(equalToConstant: 80), // 링 크기
            ringView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // 아이콘 이미지 뷰 생성
        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = color
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // `iconImageView`를 `ringView`에 추가
        ringView.addSubview(iconImageView)
        
        // `iconImageView`와 `ringView` 간 제약 조건 설정
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: ringView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: ringView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // 텍스트 레이블 생성
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.textColor = color
        valueLabel.textAlignment = .center
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.8
        
        // 스택뷰 구성
        let stackView = UIStackView(arrangedSubviews: [ringView, titleLabel, valueLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }
    
    private func createCalendarView() -> UIView {
        let calendarContainer = UIView()
        calendarContainer.backgroundColor = .white
        calendarContainer.layer.cornerRadius = 20
        calendarContainer.layer.shadowColor = UIColor.black.cgColor
        calendarContainer.layer.shadowOpacity = 0.1
        calendarContainer.layer.shadowOffset = CGSize(width: 0, height: 5)
        calendarContainer.layer.shadowRadius = 10
        
        // 요일 헤더 생성
        let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let weekStackView = UIStackView()
        weekStackView.axis = .horizontal
        weekStackView.distribution = .fillEqually
        
        for day in daysOfWeek {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = (day == "Sun" ? UIColor.red : (day == "Sat" ? UIColor.systemGreen : UIColor.gray))
            weekStackView.addArrangedSubview(label)
        }
        
        // 날짜 그리드 생성
        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.spacing = 8
        
        let datesWithColors: [Int: UIColor] = [
            9: UIColor.systemYellow,
            14: UIColor.systemGreen,
            15: UIColor.systemOrange
        ]
        
        var dayCounter = 1
        for _ in 0..<5 { // 주 단위로 행 생성
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            
            for _ in 0..<7 { // 한 주는 7일
                let dayLabel = UILabel()
                if dayCounter <= 31 { // 달력의 최대 날짜 제한 (1~31일)
                    dayLabel.text = "\(dayCounter)"
                    dayLabel.textAlignment = .center
                    dayLabel.font = UIFont.systemFont(ofSize: 18) // 날짜 글꼴 크기 증가
                    dayLabel.textColor = datesWithColors[dayCounter] ?? UIColor.black // 특정 날짜 색상 적용
                    if let bgColor = datesWithColors[dayCounter] {
                        dayLabel.backgroundColor = bgColor.withAlphaComponent(0.2)
                        dayLabel.layer.cornerRadius = 10
                        dayLabel.clipsToBounds = true
                    }
                    dayCounter += 1
                } else {
                    dayLabel.text = ""
                }
                rowStackView.addArrangedSubview(dayLabel)
            }
            gridStackView.addArrangedSubview(rowStackView)
        }
        
        // 전체 달력 스택뷰 생성 (요일 + 날짜)
        let calendarStackView = UIStackView(arrangedSubviews: [weekStackView, gridStackView])
        calendarStackView.axis = .vertical
        calendarStackView.spacing = 16 // 스택 뷰 간의 간격 증가
        
        calendarContainer.addSubview(calendarStackView)
        calendarStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarStackView.leadingAnchor.constraint(equalTo: calendarContainer.leadingAnchor, constant: 16), // 내부 여백 증가
            calendarStackView.trailingAnchor.constraint(equalTo: calendarContainer.trailingAnchor, constant: -16),
            calendarStackView.topAnchor.constraint(equalTo: calendarContainer.topAnchor, constant: 16),
            calendarStackView.bottomAnchor.constraint(equalTo: calendarContainer.bottomAnchor, constant: -16)
        ])
        
        return calendarContainer
    }
    
    private func createTabBar() -> UIView {
        let tabBarContainer = createTabBarContainer()
        let tabItems = [
            ("", "Home"),
            ("", "Group"),
            ("artrun", "artrun"), // 중앙 버튼 (이미지 이름을 여기에 설정)
            ("", "Activity"),
            ("", "Profile")
        ]
        
        let tabStackView = createTabStackView()
        
        for (index, (iconName, title)) in tabItems.enumerated() {
            if index == 2 { // 중앙 버튼 처리
                let middleButton = createMiddleButton(iconName: iconName)
                tabBarContainer.addSubview(middleButton)
                NSLayoutConstraint.activate([
                    middleButton.centerXAnchor.constraint(equalTo: tabBarContainer.centerXAnchor),
                    middleButton.centerYAnchor.constraint(equalTo: tabBarContainer.topAnchor, constant: -15),
                    middleButton.widthAnchor.constraint(equalToConstant: 60),
                    middleButton.heightAnchor.constraint(equalToConstant: 60)
                ])
            } else {
                let itemStack = createTabItem(iconName: iconName, title: title)
                tabStackView.addArrangedSubview(itemStack)
            }
        }
        
        tabBarContainer.addSubview(tabStackView)
        NSLayoutConstraint.activate([
            tabStackView.leadingAnchor.constraint(equalTo: tabBarContainer.leadingAnchor, constant: 16),
            tabStackView.trailingAnchor.constraint(equalTo: tabBarContainer.trailingAnchor, constant: -16),
            tabStackView.bottomAnchor.constraint(equalTo: tabBarContainer.bottomAnchor, constant: -8),
            tabStackView.topAnchor.constraint(equalTo: tabBarContainer.topAnchor, constant: 8)
        ])
        
        return tabBarContainer
    }
    
    // MARK: - Helper Methods
    
    private func createTabBarContainer() -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0, height: -2)
        container.layer.shadowRadius = 10
        return container
    }
    
    private func createTabStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func createMiddleButton(iconName: String) -> UIButton {
        let button = UIButton(type: .custom)
        if let runImage = UIImage(named: iconName) {
            button.setImage(runImage, for: .normal)
        } else {
            print("이미지를 찾을 수 없습니다.")
        }
        
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    private func createTabItem(iconName: String, title: String) -> UIStackView {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGreen
        button.frame.size = CGSize(width: 50, height: 50)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor.gray.withAlphaComponent(0.8)
        
        let itemStack = UIStackView(arrangedSubviews: [button, label])
        itemStack.axis = .vertical
        itemStack.spacing = 4
        itemStack.alignment = .center
        
        return itemStack
    }
    
}
