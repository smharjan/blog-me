class Blog < ApplicationRecord
    belongs_to :user
    validate :user_id_exists

    has_one_attached :feature_image
    has_many_attached :images
    validates :feature_image, attached: true

    has_many :comments, as: :commentable 

    has_many :likes, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true
    
    def user_id_exists
        if User.find_by_id(self.user_id).nil?
            errors.add(:user, "can't be empty for any blog")
        end
      
    end
end
