module TalkUp

    class Api < Roda
        
        route('issue') do |routing|

            routing.get do
                {'message' => 'issue get route!'}
            end

            routing.on String do |issue_id|

                routing.get do
                    {'message' => 'get this id!'}
                end
            end

        end

    end

end