
// AddAppointmentView.swift
import UIKit

class AddAppointmentView: UIView {
    var scrollView: UIScrollView!
    var contentView: UIView!
    var datePicker: UIDatePicker!
    var timeSlotPicker: UIPickerView!
    var notesTextView: UITextView!
    var submitButton: UIButton!
    
    // Labels
    var dateLabel: UILabel!
    var timeLabel: UILabel!
    var notesLabel: UILabel!
    
    var selectedDoctor: Doctor?
    
    // Available time slots
    let timeSlots = ["09:00 AM", "10:00 AM", "11:00 AM", "02:00 PM", "03:00 PM", "04:00 PM"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupScrollView()
        setupContentView()
        setupLabels()
        setupDatePicker()
        setupTimeSlotPicker()
        setupNotesTextView()
        setupSubmitButton()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func setupLabels() {
        dateLabel = UILabel()
        dateLabel.text = "Select Date"
        dateLabel.font = .boldSystemFont(ofSize: 16)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        timeLabel = UILabel()
        timeLabel.text = "Select Time"
        timeLabel.font = .boldSystemFont(ofSize: 16)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        
        notesLabel = UILabel()
        notesLabel.text = "Additional Notes"
        notesLabel.font = .boldSystemFont(ofSize: 16)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(notesLabel)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(datePicker)
    }
    
    func setupTimeSlotPicker() {
        timeSlotPicker = UIPickerView()
        timeSlotPicker.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeSlotPicker)
    }
    
    func setupNotesTextView() {
        notesTextView = UITextView()
        notesTextView.font = .systemFont(ofSize: 14)
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.borderColor = UIColor.systemGray4.cgColor
        notesTextView.layer.cornerRadius = 8
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(notesTextView)
    }
    
    func setupSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Schedule Appointment", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(submitButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Date Label constraints
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // DatePicker constraints
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Time Label constraints
            timeLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // TimeSlotPicker constraints
            timeSlotPicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            timeSlotPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeSlotPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            timeSlotPicker.heightAnchor.constraint(equalToConstant: 120),
            
            // Notes Label constraints
            notesLabel.topAnchor.constraint(equalTo: timeSlotPicker.bottomAnchor, constant: 20),
            notesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // NotesTextView constraints
            notesTextView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 8),
            notesTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notesTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            notesTextView.heightAnchor.constraint(equalToConstant: 100),
            
            // Submit Button constraints
            submitButton.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 30),
            submitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
