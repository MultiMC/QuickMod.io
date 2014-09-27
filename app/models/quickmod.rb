class QuickMod < ActiveRecord::Base
    has_many :versions
    has_many :authors
    has_many :urls

    def to_param
        uid.gsub('.', '_') + '.json'
    end
    
    def find_by_slug(slug)
      where(uid: slug.gsub('_', '.'))
    end

    validates :uid, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9_\-\.]+\Z/, message: 'only alphanumeric characters, dashes, dots, and underscores are allowed'}
    validates :name, presence: true

    before_save { |qm| qm.uid = qm.uid.downcase }
end
