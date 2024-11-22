import UIKit
import Firebase
import FirebaseCore

class HomeViewController: UIViewController {
    var onLogout: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupUI()
        checkUserSessionAndLogout() // 세션 확인 및 자동 로그아웃 처리
    }
    
    private func checkUserSessionAndLogout() {
        let isSessionExpired = true // 세션 만료 조건 확인 (예시)
        if isSessionExpired {
            onLogout?() // 세션 만료 시 로그아웃 처리
        }
    }
    
    private func setupUI() {
        // **헤더 섹션**
        let headerLabel = UILabel()
        headerLabel.text = "Home"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 40)
        headerLabel.textColor = UIColor.systemGreen
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "가벼운 러닝으로 상쾌한 하루를 시작해보세요"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = UIColor.gray
        
        // **사용자 정보 카드**
        let cardView = createCardView()
        
        // **러닝, 칼로리, 심박수 정보**
        let runningStack = createInfoStack(iconName: "figure.run", title: "Running", value: "5000km", color: UIColor.systemGreen)
        let caloriesStack = createInfoStack(iconName: "flame.fill", title: "Calories burned", value: "2034kcal", color: UIColor.systemRed)
        let heartRateStack = createInfoStack(iconName: "heart.fill", title: "Heart rate", value: "130BPM", color: UIColor.systemOrange)
        
        let infoStackView = UIStackView(arrangedSubviews: [runningStack, caloriesStack, heartRateStack])
        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
        infoStackView.distribution = .equalSpacing
        
        // **캘린더 섹션**
        let calendarView = createCalendarView()
        
        // **하단 탭바**
        let tabBarView = createTabBar()
        
        // **뷰 계층 추가**
        view.addSubview(headerLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(cardView)
        view.addSubview(infoStackView)
        view.addSubview(calendarView)
        view.addSubview(tabBarView)
        
        // **Auto Layout 설정**
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
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
            cardView.heightAnchor.constraint(equalToConstant: 180),
            
            // 정보 스택뷰 레이아웃
            infoStackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            infoStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
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
        
        let userNameLabel = UILabel()
        userNameLabel.text = "User Name"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        userNameLabel.textColor = .black
        
        let userInfoLabel = UILabel()
        userInfoLabel.text = "Welcome back!"
        userInfoLabel.font = UIFont.systemFont(ofSize: 14)
        userInfoLabel.textColor = .gray
        
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, userInfoLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        
        cardView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
        
        return cardView
    }
    private func createInfoStack(iconName: String, title: String, value: String, color: UIColor) -> UIStackView {
        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = color
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.textColor = color
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, valueLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
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
                    dayLabel.font = UIFont.systemFont(ofSize: 16)
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
        calendarStackView.spacing = 8

        calendarContainer.addSubview(calendarStackView)
        calendarStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarStackView.leadingAnchor.constraint(equalTo: calendarContainer.leadingAnchor, constant: 16),
            calendarStackView.trailingAnchor.constraint(equalTo: calendarContainer.trailingAnchor, constant: -16),
            calendarStackView.topAnchor.constraint(equalTo: calendarContainer.topAnchor, constant: 16),
            calendarStackView.bottomAnchor.constraint(equalTo: calendarContainer.bottomAnchor, constant: -16)
        ])

        return calendarContainer
    }

    }
    
private func createTabBar() -> UIView {
    let tabBarContainer = UIView()
    tabBarContainer.backgroundColor = .white
    tabBarContainer.layer.cornerRadius = 20
    tabBarContainer.layer.shadowColor = UIColor.black.cgColor
    tabBarContainer.layer.shadowOpacity = 0.1
    tabBarContainer.layer.shadowOffset = CGSize(width: 0, height: -2)
    tabBarContainer.layer.shadowRadius = 10
    
    // 탭 아이템 설정
    let tabItems = [
        ("house.fill", "Home"),
        ("person.2.fill", "Group"),
        ("artrun", "artrun"), // 중앙 버튼 (이미지 이름을 여기에 설정)
        ("chart.bar.fill", "Activity"),
        ("person.crop.circle.fill", "Profile")
    ]
    
    // 탭 스택뷰 생성
    let tabStackView = UIStackView()
    tabStackView.axis = .horizontal
    tabStackView.distribution = .fillEqually
    tabStackView.spacing = 8
    
    for (index, (iconName, title)) in tabItems.enumerated() {
        if index == 2 { // 중앙 버튼 처리
            let middleButton = UIButton(type: .custom)
            if let runImage = UIImage(named: iconName) {
                middleButton.setImage(runImage, for: .normal)
            } else {
                print("이미지를 찾을 수 없습니다.")
            }
            middleButton.tintColor = .white
            middleButton.backgroundColor = UIColor.systemGreen
            middleButton.layer.cornerRadius = 25
            middleButton.layer.shadowColor = UIColor.black.cgColor
            middleButton.layer.shadowOpacity = 0.3
            middleButton.layer.shadowOffset = CGSize(width: 0, height: 5)
            middleButton.layer.shadowRadius = 5
            
            // 중앙 버튼 크기와 위치 조정
            middleButton.translatesAutoresizingMaskIntoConstraints = false
            tabBarContainer.addSubview(middleButton)
            
            NSLayoutConstraint.activate([
                middleButton.centerXAnchor.constraint(equalTo: tabBarContainer.centerXAnchor),
                middleButton.centerYAnchor.constraint(equalTo: tabBarContainer.topAnchor, constant: 10), // 위로 약간 올려서 중앙 버튼이 잘 보이게
                middleButton.widthAnchor.constraint(equalToConstant: 60),
                middleButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        } else {
            // 일반 탭 버튼을 원형으로 만들기
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: iconName), for: .normal)
            button.tintColor = .gray
            button.frame.size = CGSize(width: 50, height: 50)
            button.layer.cornerRadius = 25
            button.clipsToBounds = true // 원형 버튼을 만들기 위한 클리핑
            
            // CALayer 추가 (각 탭 아이템에 레이어를 추가)
            let layer1 = CALayer()
            layer1.backgroundColor = UIColor.white.cgColor
            layer1.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            
            // CALayer의 위치 설정은 layoutSubviews 후에 처리
            button.layoutIfNeeded()  // 레이아웃을 업데이트 한 후
            layer1.position = CGPoint(x: button.bounds.midX, y: button.bounds.midY)
            
            button.layer.addSublayer(layer1)
            
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            
            let itemStack = UIStackView(arrangedSubviews: [button, label])
            itemStack.axis = .vertical
            itemStack.spacing = 4
            itemStack.alignment = .center
            
            tabStackView.addArrangedSubview(itemStack)
        }
    }
    
    // 탭 스택뷰 추가 및 레이아웃 설정
    tabBarContainer.addSubview(tabStackView)
    tabStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        tabStackView.leadingAnchor.constraint(equalTo: tabBarContainer.leadingAnchor),
        tabStackView.trailingAnchor.constraint(equalTo: tabBarContainer.trailingAnchor),
        tabStackView.bottomAnchor.constraint(equalTo: tabBarContainer.bottomAnchor),
        tabStackView.heightAnchor.constraint(equalToConstant: 60) // 기본 탭 높이 설정
    ])
    
    return tabBarContainer
}
