import UIKit
import Firebase
import FirebaseCore
class HomeViewController: UIViewController {
    var onLogout: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupUI()

        // 자동 로그아웃 처리를 여기에 추가할 수 있습니다.
        // 예를 들어, 네트워크 상태 체크 후 로그아웃 처리
        checkUserSessionAndLogout()
    }

    private func checkUserSessionAndLogout() {
        // 예시: 세션이 만료되었을 경우 로그아웃
        let isSessionExpired = true // 예시: 실제 세션 만료 조건을 체크해야 합니다.
        
        if isSessionExpired {
            onLogout?()  // 세션 만료 시 로그아웃 처리
        }
    }
    
    private func setupUI() {
        // **헤더 섹션**
        let headerLabel = UILabel()
        headerLabel.text = "Home"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 40)
        headerLabel.textColor = UIColor.systemGreen
        view.addSubview(headerLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "가벼운 러닝으로 상쾌한 하루를 시작해보세요"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textColor = UIColor.gray
        view.addSubview(subtitleLabel)
        
        // **사용자 정보 카드**
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 10
        view.addSubview(cardView)
        
        let userIDLabel = UILabel()
        userIDLabel.text = "userID"
        userIDLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        let ellipsisButton = UIButton(type: .system)
        ellipsisButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        ellipsisButton.tintColor = .gray
        
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to your activity hub."
        welcomeLabel.font = UIFont.systemFont(ofSize: 14)
        welcomeLabel.textColor = .gray
        
        // **러닝, 칼로리, 심박수 섹션**
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
        
        // **Auto Layout 설정**
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            // 헤더 섹션 레이아웃
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            
            // 카드 뷰 레이아웃
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            cardView.heightAnchor.constraint(equalToConstant: 180),
            
            infoStackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            infoStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            // 캘린더 레이아웃
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
        
        let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        // 요일 헤더
        let weekStackView = UIStackView()
        weekStackView.axis = .horizontal
        weekStackView.alignment = .center
        weekStackView.distribution = .fillEqually
        
        for day in daysOfWeek {
            let label = UILabel()
            label.text = day
            label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            label.textAlignment = .center
            label.textColor = (day == "Sun" ? UIColor.red : (day == "Sat" ? UIColor.systemGreen : UIColor.gray))
            weekStackView.addArrangedSubview(label)
        }
        
        // 날짜 그리드
        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.spacing = 8
        
        var currentRowStack: UIStackView?
        
        for day in 1...31 {
            if day % 7 == 1 {
                currentRowStack = UIStackView()
                currentRowStack?.axis = .horizontal
                currentRowStack?.alignment = .center
                currentRowStack?.distribution = .fillEqually
                currentRowStack?.spacing = 4
                gridStackView.addArrangedSubview(currentRowStack!)
            }
            
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.black
            
            if [9, 14].contains(day) {
                label.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
                label.textColor = .white
                label.layer.cornerRadius = 4
                label.clipsToBounds = true
            } else if day == 15 {
                label.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.8)
                label.textColor = .white
                label.layer.cornerRadius = 4
                label.clipsToBounds = true
            }
            
            label.text = "\(day)"
            currentRowStack?.addArrangedSubview(label)
        }
        
        // 캘린더 전체 스택뷰 구성
        let calendarStackView = UIStackView(arrangedSubviews: [weekStackView, gridStackView])
        calendarStackView.axis = .vertical
        calendarStackView.spacing = 8
        
        calendarContainer.addSubview(calendarStackView)
        
        // Auto Layout 설정
        calendarStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarStackView.topAnchor.constraint(equalTo: calendarContainer.topAnchor, constant: 16),
            calendarStackView.leadingAnchor.constraint(equalTo: calendarContainer.leadingAnchor, constant: 16),
            calendarStackView.trailingAnchor.constraint(equalTo: calendarContainer.trailingAnchor, constant: -16),
            calendarStackView.bottomAnchor.constraint(equalTo: calendarContainer.bottomAnchor, constant: -16)
        ])
        
        return calendarContainer
    }
    
    private func createTabBar() -> UIView {
        let tabBarContainer = UIView()
        
        tabBarContainer.backgroundColor = .white
        
        let tabItemsInfo: [(String, String)] =
            [("house.fill", "Home"),
             ("person.2.fill", "Group"),
             ("figure.walk.circle.fill", "Activity"),
             ("person.crop.circle.fill", "Profile")]
        
        let tabStackView = UIStackView()
        tabStackView.axis = .horizontal
        tabStackView.alignment = .center
        tabStackView.distribution = .fillEqually
        
        for (iconName, title) in tabItemsInfo {
            let button = UIButton(type: .system)
            button.tintColor = .gray
            button.setImage(UIImage(systemName: iconName), for: .normal)
            button.addTarget(self, action: #selector(tabBarTapped(_:)), for: .touchUpInside)
            
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            
            let tabItemStackView = UIStackView(arrangedSubviews: [button, label])
            tabItemStackView.axis = .vertical
            tabItemStackView.spacing = 4
            tabStackView.addArrangedSubview(tabItemStackView)
        }
        
        tabBarContainer.addSubview(tabStackView)
        tabStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tabStackView.leadingAnchor.constraint(equalTo: tabBarContainer.leadingAnchor),
            tabStackView.trailingAnchor.constraint(equalTo: tabBarContainer.trailingAnchor),
            tabStackView.topAnchor.constraint(equalTo: tabBarContainer.topAnchor),
            tabStackView.bottomAnchor.constraint(equalTo: tabBarContainer.bottomAnchor)
        ])
        
        return tabBarContainer
    }
    
    @objc private func tabBarTapped(_ sender: UIButton) {
        // 탭바 버튼이 클릭되었을 때의 행동을 구현할 수 있습니다.
    }
}
