class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :first_name,          type: String, default: ""
  field :last_name,           type: String, default: ""
  field :username,            type: String, default: ""
  field :email,               type: String, default: ""
  field :encrypted_password,  type: String, default: ""
  field :gender,              type: String, default: ""
  field :grade,               type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  ## Other
  field :books, type: Array

  ## Helper functions
  def notebook_owner? notebook_id
    books && books.find(notebook_id)
  end

  def notebook_array
    if books
      Notebook.find(books)
    else
      []
    end
  end

  def notebook_create notebook_params
    notebook = Notebook.create(notebook_params)
    if books
      update(books: books.push(notebook.id))
    else
      update(books: [notebook.id])
    end
  end

  def notebook_delete notebook_id
    if books && books.find(notebook_id)
      notebook = Notebook.find(notebook_id)
      if notebook
        notebook.delete
      end
      books.delete(notebook.id)
      update(books: books)
    end
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :grade, presence: true

end
