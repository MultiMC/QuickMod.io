class DownloadUrl < ActiveRecord::Base
    belongs_to :qmversion
  
    enum download_type: [:parallel_dl, :sequential_dl, :direct_dl]
    
    validate :valid_url?
    def valid_url?
        # Try to parse the URL. If it fails, return false.
        !!URI.parse(@url)
    rescue
        false
    end
end
