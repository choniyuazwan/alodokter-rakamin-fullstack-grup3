require "test_helper"

class PasswordMailerTest < ActionMailer::TestCase
  test "forget" do
    mail = PasswordMailer.forget
    assert_equal "Forget", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
