class BucketManager
  @@s3 = Aws::S3::Client.new
  @@bucket = ENV["BUCKET"]

  def self.call()
  end

  def write(data, key)
    resp = @@s3.put_object(body: data, bucket: @@bucket, key: key)
  end

  def read(key, file_path)
    resp =
      @@s3.get_object(
        { bucket: @@bucket, key: key },
        target: file_path,
      )
  end

  def delete(key)
    resp = @@s3.delete_object({ bucket: @@bucket, key: key })
  end
end
