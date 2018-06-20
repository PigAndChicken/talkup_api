require 'http'
require 'dry-monads'
require 'dry/transaction'

module TalkUp

    class AuthSsoAccount
        include Dry::Transaction

        step :get_account_from_api
        step :exist?

        def get_account_from_api(input)
            response = HTTP.headers(user_agent: 'Config Secure',
                                    authorization: "token #{input[:access_token]}",
                                    accept: 'application/json').get(input[:config].GH_ACCOUNT_API)
            raise if response.status > 400
            gh_account = response.parse
            username = gh_account['login'] + '@github'
            email = gh_account['email']
            Right({username: username, email: email, type: 'sso'})
        end

        def exist?(input)
            account = Repo::Account.find_by(:username, input[:username]) || Repo::Account.create(input)
            Right(Result.new(:ok, account))
        end

    end
end