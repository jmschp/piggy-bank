module ShowSvgHelper
  def svg_tag(file)
    file_path = "#{Rails.root}/app/assets/images/#{file}"
    return File.read(file_path).html_safe if File.exist?(file_path)

    '(not found)'
  end
end
