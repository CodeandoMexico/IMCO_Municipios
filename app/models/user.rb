class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook, :linkedin]

  validates :city_id, presence: true
  belongs_to :city

  has_many :user_formation_step
  has_many :formation_steps, through: :user_formation_step
  has_many :complaints

  mount_uploader :operation_license_file, PdfUploader
  mount_uploader :land_permission_file, PdfUploader


  def business?
    !self.admin?
  end

  def profile_complete?
    self.address.present? &&
    self.operation_license_file.present? &&
    self.land_permission_file.present? &&
    self.operation_license.present?
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                            municipio_id:'1'
                          )
      end
       end
  end

  def self.connect_to_linkedin(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else

        user = User.create(name:auth.info.first_name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                             municipio_id:'1'
                          )
      end

    end
  end

end
