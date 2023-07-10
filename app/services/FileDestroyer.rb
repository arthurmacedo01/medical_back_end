class FileDestroyer
  def self.call(file_path)
    new().call(file_path)
  end

  def call(file_path)
    File.delete(file_path) if file_path && File.exist?(file_path)
  end
end
