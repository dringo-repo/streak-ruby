module Streak
  class Contact < StreakObject
    def self.get(params = {})
      res = Streak.request(:get, "/search?query=#{params[:email]}")
      obj = convert_to_streak_object(res, Contact)
      extract_contacts_from obj
    end

    def self.add_to_box(box_key, params={})
      res = Streak.request(:post, "/boxes/" + box_key, MultiJson.dump(params))
      obj = convert_to_streak_object(res, Contact)
    end

    private

      def self.extract_contacts_from(obj)
        obj.instance_variable_get(:@values)[:results].instance_variable_get(:@values)[:contacts]
      end
  end
end
