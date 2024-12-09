import UIKit

class HistoryView: UIView {



    var tabBar: UITabBar!
    var symptomView: SymptomView!
    var appointmentView: AppointmentView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white // Set the background color



        self.backgroundColor = .white
        setupTabBar()
        setupSymptomView()
        setupAppointmentView()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupTabBar() {
        tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.shadowImage = UIImage() // Remove the shadow (grey line)
        tabBar.backgroundImage = UIImage() // Remove any default background image

        self.addSubview(tabBar)
        
        

        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // Function to set up constraints

    private func setupSymptomView() {
        symptomView = SymptomView()
        symptomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(symptomView)

        NSLayoutConstraint.activate([
            symptomView.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
            symptomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symptomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            symptomView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupAppointmentView() {
        appointmentView = AppointmentView()
        appointmentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(appointmentView)

        NSLayoutConstraint.activate([
            appointmentView.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
            appointmentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            appointmentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            appointmentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
