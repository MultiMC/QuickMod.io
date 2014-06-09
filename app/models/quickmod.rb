class QuickMod < ActiveRecord::Base
	belongs_to :owner, class_name: 'User'
    has_many :versions

    extend FriendlyId
    friendly_id :slug_candidates, :use => :slugged

    validates :uid, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_\-\.]+\Z/, message: 'only alphanumeric characters, dashes, dots, and underscores are allowed'}
    validates :name, presence: true
    validate :uid_reserved?

    before_save { |qm| qm.uid = qm.uid.downcase }

    def force_regen_slug=(val)
        @force_regen_slug = val
    end

    def should_generate_new_friendly_id?
        uid_changed? || @force_regen_slug || super
    end

    # TODO: Add more candidates, so we don't get a UUID at the end of slugs
    # when there's a name clash.
    def slug_candidates
        [
            :uid,
        ]
    end

    def normalize_friendly_id(str)
        super.gsub(/\./, '-')
    end

    def uid_reserved?
        if self.uid == 'new'
            errors.add(:uid, 'is reserved')
        end
    end

	# True if the given user owns this QuickMod
	def owned_by?(usr)
		not usr.nil? and usr.id == owner_id
	end
end
