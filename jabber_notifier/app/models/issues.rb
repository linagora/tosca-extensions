class Issue < ActiveRecord::Base
  # This method use App::JabberAccount & App::JabberPassword in order
  # to work. So yes, you'll need to create a custom account, because Jabber
  # Protocol does not allow to spam users without a real account :).
  def send_jabber_notification()
    return unless defined? App::JabberAccount
    # Jabber::debug = true
    body = self.description
    subject = "[OSSA##{self.id}] : #{self.resume}"
    jid = Jabber::JID::new(App::JabberAccount)
    cl = Jabber::Client::new(jid)
    begin
      cl.connect
      cl.auth(App::JabberPassword)
    rescue
      logger.info "Jabber : Error login"
    end
    self.contract.engineer_users.each { |expert|
      message = Jabber::Message::new(expert.email, body).set_subject(subject)
      cl.send message
    }
    cl.close
  end

end
