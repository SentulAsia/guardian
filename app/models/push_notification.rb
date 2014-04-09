require "net/http"
require "net/https"
class PushNotification
  def self.welcome(user)
    # message_options = {
    #   :registration_ids => [<array of registration ids>],
    #   # optional parameters below.  Read the docs here: http://developer.android.com/guide/google/gcm/gcm.html#send-msg
    #   :collapse_key => "foobar",
    #   :data => { :score => "3x1" },
    #   :delay_while_idle => false,
    #   :time_to_live => 1
    # }

    # response = SpeedyGCM::API.send_notification(message_options)

    # puts response[:code]  # some http response code like 200
    # puts response[:data]  # usually nil is returned
  end
end
