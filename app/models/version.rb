class Version < ActiveRecord::Base
    belongs_to :quickmod

    validates :name, presence: true, uniqueness: {scope: :quickmod}, format: {with: /\A[a-zA-Z0-9_\-\.]+\Z/, message: 'only alphanumeric characters, dashes, dots, and underscores are allowed'}
    validates :md5, format: {with: /\A[a-fA-F0-9]*\Z/, message: 'must be a valid MD5 hash'}
    validate :valid_url?

    enum download_type: [:parallel_dl, :sequential_dl, :direct_dl]
    enum install_type: [:forge_mod, :forge_core_mod, :extract_mod, :config_pack_mod, :group_mod]

    def valid_url?
        # Try to parse the URL. If it fails, return false.
        !!URI.parse(@url)
    rescue
        false
    end
end
