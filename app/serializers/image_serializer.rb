class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :credit_to, :image_url
end
