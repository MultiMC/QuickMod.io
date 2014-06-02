class QuickMod < ActiveRecord::Base
    extend FriendlyId
    friendly_id :uid

    validates :uid, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_\-]+\Z/, message: 'only alphanumeric characters, numbers dashes and underscores are allowed'}
    validates :name, presence: true
    validate :uid_reserved?

    before_save { |qm| qm.uid = qm.uid.downcase }

    def uid_reserved?
        if self.uid == 'new'
            errors.add(:uid, 'is reserved')
        end
    end
end
