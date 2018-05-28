require_relative './spec_helper.rb'

describe 'Test SendGrid API' do 

    describe 'Test Sending Email' do

        it 'HAPPY: it should be able to send email' do 
            data = { :username => 'test', :email => 'xumingyo@gmail.com', :verification_url => 'http://example.com', :sendgrid => app.config }
            result = TalkUp::EmailVerification.new.call(data)
            _(result.value.message).must_equal "Email has been sent."
        end

    end
end