require 'http'
require 'dry/transaction'

module TalkUp

    class EmailVerification
        include Dry::Transaction

        step :username_available?
        step :build_email_body
        step :send_email

        def username_available?(input)
            if Repo::Account.find_by(:username, input[:username]).nil?
                Right(input)
            else
                Left(Result.new(:bad_request, 'username had been taken.'))
            end
        end

        def build_email_body(input)
            verification_url = input[:verification_url]

            email_body = <<~END_EMAIL
                            <H1>Credent Registration Received<H1>
                            <p>Please <a href=\"#{verification_url}\">click here</a> to validate your
                            email. You will be asked to set a password to activate your account.</p>
                        END_EMAIL

            input[:email_body] = email_body
            Right(input)
        end

        def send_email(input)
            result = HTTP.auth( "Bearer #{input[:sendgrid].SENDGRID_KEY}").post(
                        input[:sendgrid].SENDGRID_API,
                        json: {
                            personalizations: [{
                                to: [{ 'email' => input[:email] }]
                            }],
                            from: { 'email' => 'no-reply@talkup.com' },
                            subject: 'TalkUp Registration Verification',
                            content: [
                                {
                                    type: 'text/html',
                                    value: input[:email_body]
                                }
                            ]
                        }
                    )
            Right(Result.new(:ok, "Email has been sent."))
            rescue StandardError 
                Left(Result.new(:bad_request, "Email address not found."))
        end
    end
end