require 'state/public/global'
require 'view/public/lectures'

module DaVaz::State
  module Public
    class Lectures < Global
      VIEW = DaVaz::View::Public::Lectures

      def init
        @model = @session.app.load_lectures
      end
    end

    class AdminLectures < Lectures
      VIEW = DaVaz::View::Public::AdminLectures
    end
  end
end
