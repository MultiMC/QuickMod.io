class QuickMod < ActiveRecord::Base
    extend FriendlyId
    friendly_id :uid

    # FIXME: UID shouldn't be allowed to be "new"

    validates :uid, presence: true
    validates :name, presence: true
end
