module TalkUp

    class Api < Roda
        
        route('issues') do |routing|

            routing.get do
                {'message' => 'issue get route!'}
            end

        end

        route('issue') do |routing|

            routing.on String do |issue_id|

                routing.get do
                    {'message' => "#{issue_id}"}
                end
            end
        end

    end

end