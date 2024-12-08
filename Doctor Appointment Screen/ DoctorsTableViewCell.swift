
import UIKit

protocol DoctorsTableViewCellDelegate: AnyObject {
    func didTapAddAppointmentButton(for cell: DoctorsTableViewCell)
}

class DoctorsTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelDescription: UILabel!
    var labelType: UILabel!
    var actionButton: UIButton!
    weak var delegate: DoctorsTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelDescription()
        setupLabelType()
        setupActionButton() // Setup the button
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelDescription(){
        labelDescription = UILabel()
        labelDescription.font = UIFont.boldSystemFont(ofSize: 14)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDescription)
    }
    
    func setupLabelType(){
        labelType = UILabel()
        labelType.font = UIFont.boldSystemFont(ofSize: 14)
        labelType.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelType)
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.isUserInteractionEnabled = true  // Add this
        self.contentView.isUserInteractionEnabled = true // Add this
        self.addSubview(wrapperCellView)
    }

    func setupActionButton() {
        actionButton = UIButton(type: .system)
        
        // Just set the icon without text
        actionButton.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
        actionButton.tintColor = .systemBlue
        actionButton.backgroundColor = .clear  // Remove background color
        
        actionButton.isUserInteractionEnabled = true
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add touch events
        actionButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        actionButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        wrapperCellView.addSubview(actionButton)
    }


    @objc private func addButtonTapped() {
        print("DEBUG: Button TOUCH UP INSIDE detected!")
        delegate?.didTapAddAppointmentButton(for: self)
    }

    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Wrapper cell view constraints
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            // Label Name constraints
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelName.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -8),
            labelName.heightAnchor.constraint(equalToConstant: 20),

            // Label Description constraints
            labelDescription.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelDescription.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelDescription.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -8),

            // Label Type constraints
            labelType.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 4),
            labelType.leadingAnchor.constraint(equalTo: labelDescription.leadingAnchor),
            labelType.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -8),
            labelType.bottomAnchor.constraint(lessThanOrEqualTo: wrapperCellView.bottomAnchor, constant: -8),

            // Action Button constraints
            actionButton.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            actionButton.widthAnchor.constraint(equalToConstant: 30),
            actionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
