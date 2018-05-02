module TalkUp

    class IndexRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
    end
end