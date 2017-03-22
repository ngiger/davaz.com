require 'state/works/rack'
require 'view/works/photos'

module DaVaz::State
  module Works
    class Photos < Rack
      VIEW        = DaVaz::View::Works::Photos
      ARTGROUP_ID = 'PHO'
      def initialize(session, model)
        SBSM.debug('init Works::Photos')
        super(session, model)
      end
    end

    class AdminPhotos < AdminRack
      VIEW        = DaVaz::View::Works::AdminPhotos
      ARTGROUP_ID = 'PHO'
      def initialize(session, model)
        SBSM.debug('init Works::AdminPhotoss')
        super(session, model)
      end
    end
  end
end
