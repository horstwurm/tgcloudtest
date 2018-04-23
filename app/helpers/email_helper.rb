module EmailHelper
  def email_image_tag(image, **options)
    #attachments[image] = File.read(Rails.root.join("app/assets/images/#{image}"))
    attachments.inline[image] = File.read(Rails.root.join("app/assets/images/#{image}"))
    image_tag attachments[image].url, **options
  end

  def email_s3image_tag(image, **options)
    #attachments[image] = File.read(Rails.root.join("app/assets/images/#{image}"))
    attachments.inline[image] = File.read(image)
    image_tag attachments[image].url, **options
  end
end