class Version < ActiveRecord::Base
    belongs_to :quickmod
    
    has_many :references
    has_many :downloadurls

    validates :version, presence: true, uniqueness: {scope: :quickmod}, format: {with: /\A[a-zA-Z0-9_\-\.]+\Z/, message: 'only alphanumeric characters, dashes, dots, and underscores are allowed'}
    validates :sha1, format: {with: /\A[a-fA-F0-9]*\Z/, message: 'must be a valid SHA1 hash'}

    enum install_type: [:forge_mod, :forge_core_mod, :extract_mod, :config_pack_mod, :group_mod]
end
