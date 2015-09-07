class User < ActiveRecord::Base
  validates_presence_of :name, :message => 'Debes escribir tu nombre.', if: :business?, on:  :update
  validates_length_of :name, :minimum => 3, :message => 'Tu nombre debe tener por lo menos 3 caracteres.', if: :business?, on:  :update
  validates_format_of :name, :with => /\A[a-zA-Z0-9 áéíóúÁÉÍÓÚñÑ._-]+\z/, :message => "El nombre solo debe tener letras, números, puntos y guiones.", if: :business?, on:  :update

  validates_presence_of :email, :message => 'Debes escribir tu correo.', if: :business?, on:  :update
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "El correo debe tener un formato válido.", if: :business?, on:  :update

  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook, :linkedin]

  has_many :complaints
  has_many :business


  def business?
    !self.admin?
  end

  def has_business?(business_id)
    self.business.exists? business_id
  end



  def profile_complete?
    self.email.present? && self.name.present?
  end

  def to_s
     self.name || self.email #|| self.business_name 
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
          password:Devise.friendly_token[0,20]
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
          password:Devise.friendly_token[0,20]
          )
      end

    end
  end
end
