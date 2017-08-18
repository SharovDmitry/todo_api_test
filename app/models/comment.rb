class Comment < ApplicationRecord

  belongs_to :task

  validates :content, length: { maximum: 256 }
  validate :content_or_image_present?

  mount_base64_uploader :image, FileUploader

  after_destroy :remove_empty_file_directory

  def remove_empty_file_directory
    return if image.file.blank?
    path = File.expand_path(image.store_path, image.root)
    FileUtils.remove_dir(path)
  end

  def content_or_image_present?
    errors.add(:base, "Content or Image should be present") if content.blank? && image.blank?
  end

end