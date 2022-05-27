require "htmlcsstoimage"
class PagesController < ApplicationController

  def home

  end

  def generate_meme
    meme_url = params[:meme_url]
    text1 = params[:text1]
    text2 = params[:text2]

    html = render_to_string(
      :form,
      locals: { text1: text1, text2: text2, meme_url: meme_url},
      formats: :html, layout: false
    )

    auth = { username: ENV['HCTI_USER_ID'], password: ENV['HCTI_API_KEY'] }

    image = HTTParty.post("https://hcti.io/v1/image", body: { html: html, google_fonts: "Oswald" }, basic_auth: auth)

    redirect_to image["url"], status: :found
  end

  def form
    @text1 = params[:text1]
    @text2 = params[:text2]
    @meme_url = params[:meme_url]
  end

  def fetch_url(html:, css: nil, google_fonts: nil)
    cache_key = "htmlcssimage/#{html}/#{css}/#{google_fonts}"
    cached_url = Rails.cache.read(cache_key)

    return cached_url if cached_url.present?

    client = HTMLCSSToImage.new
    image = client.create_image(html: html, css: css, google_fonts: google_fonts)

    if image.success?
      Rails.cache.write(cache_key, image.url, expires_in: CACHE_EXPIRATION)
    end
    image.url
  end
end
