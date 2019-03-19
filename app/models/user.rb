class User < ApplicationRecord
  has_many :notes
  has_secure_password


  def getTone(day)
    tone = []
    self.notes.each do |note|
      
      if note.created_at.to_date == day
        tone.push(note.tone)
      end
    end
    tone.max_by { |i| tone.count(i) }
  end

  def getAppointments
    appointments = []
    self.notes.each do |note|
      note.tags.each do |tag|
        if tag.name == "Appointment"
          appointments.push(note)
        end
      end
    end
    appointments
  end

  def get_appointments_by_date(date)
    appt = []
    getAppointments.each do |note|
      if note.date == date
        appt.push(note)
      end
    end
    appt
  end

  def get_appointment_content(appointments)
    contents = []
    appointments.each do |appointment|
      contents.push(appointment.content)
    end
    contents
  end

  def reminder
    
    date = Date.today
    appt = self.get_appointment_content(self.get_appointments_by_date(date))
    apptcontent = appt.join(' & ')
    

    @twilio_number = ENV['TWILIO_NUMBER']
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    @client = Twilio::REST::Client.new account_sid, ENV['TWILIO_AUTH_TOKEN']
    body = "Hi #{self.name}. Just a reminder that you have to do #{apptcontent} TODAY."
    message = @client.messages.create(
      :from => @twilio_number,
      :to => self.phone_number,
      :body => body,
    )
  end

  def self.all_reminders
    users = self.all

    users.each do |user|
      user.reminder
    end
  end

  # def run_at 
  #   self.date + 8.hours
  # end

  

  # handle_asynchronously :reminder, :run_at => Proc.new { |i| i.run_at }

end
